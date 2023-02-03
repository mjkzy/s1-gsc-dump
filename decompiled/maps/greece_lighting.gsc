// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    init_level_lighting_flags();
    thread setup_dof_presets();
    thread set_level_lighting_values();
    thread initsafehousexslice();
    thread initsafehouseintro();
    thread inittabletoverlay();
    thread initsafehousefollow();
    thread initsafehouseclearstart();
    thread setsafehouseextdrawdist();
    thread setsafehouseintdrawdist();
    thread lightintensityflicker( "safehouse_computer_room_monitor_flicker", "start_safehouse_computerlab_light_flicker", "stop_safehouse_computerlab_light_flicker", 500, 2000, 0.05, 0.15 );

    if ( level.nextgen )
        thread lightintensityflicker( "safehouse_computer_room_monitor_main_flicker", "start_safehouse_computerlab_light_flicker", "stop_safehouse_computerlab_light_flicker", 1, 5000, 0.1, 0.25 );
    else
        thread lightintensityflicker( "safehouse_computer_room_monitor_main_flicker", "start_safehouse_computerlab_light_flicker", "stop_safehouse_computerlab_light_flicker", 100, 15000, 0.1, 0.25 );

    thread lightintensityflicker( "halogen_flickering", "halogen_flickering_jewelry_start", "halogen_flickering_jewelry_stop", 1, 155000, 0.1, 0.25 );
    thread initsafehousetransitionstart();
    thread initsafehouseexosuitup();
    thread initsafehouseexosuitupfadeout();
    thread initconfcenterstart();
    thread initbeginconfcentersupporta();
    thread initbeginconfcentersupportb();
    thread initbeginconfcentersupportc();
    thread initbeginconfcenterkill();
    thread initbeginconfcentercombat();
    thread initbeginconfcenteroutro();
    thread initsafehouseoutrostart();
    thread setalleystransitionculldist();
    thread initalleystransitionstart();
    thread initalleysstart();
    thread initsniperscrambleintro();
    thread initsniperscramblestarthotel();
    thread initsniperscrambledrones();
    thread initsniperscramblefinalelighting();
    thread initendingambushinteractlighting();
    thread ending_confculldist();
    thread preending_confculldist();
    thread endingambushvision();
    thread initendinghadesfight();

    if ( level.nextgen )
        setsaveddvar( "r_hemiAoEnable", 1 );

    if ( level.currentgen )
    {

    }

    thread inittriggermultiplevisionlightset( "alleys_store_aa", "greece_alleys_start", "greece_alleys_store_aa", "alleys_start", "alleys_store_aa", 2.0 );
    thread dynamic_dof( 0.25, 1.5, 1, "init_tablet_overlay", 1 );
    thread setup_vfx_sunflare();
    thread setup_dof_safehouseintro();
    thread setup_dof_safehousefollow();
    thread setup_dof_takedownkill();
}

inittriggermultiplevisionlightset( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = getent( var_0, "targetname" );

    if ( !isdefined( var_6 ) )
        iprintln( "Failed to find Vision / LightSet Trigger:" + var_0 );
    else
        var_6 thread triggermultiplevisionlightsetinternal( var_1, var_2, var_3, var_4, var_5 );
}

triggermultiplevisionlightsetinternal( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = 1;
    var_6 = 0;

    for (;;)
    {
        if ( level.player istouching( self ) )
        {
            if ( var_5 )
            {
                if ( var_1 != "none" )
                    maps\_utility::vision_set_changes( var_1, var_4 );

                if ( var_3 != "none" )
                    level.player lightsetforplayer( var_3 );

                var_6 = 1;
                var_5 = 0;
            }
        }
        else if ( var_6 )
        {
            if ( var_0 != "none" )
                maps\_utility::vision_set_changes( var_0, var_4 );

            if ( var_2 != "none" )
                level.player lightsetforplayer( var_2 );

            var_6 = 0;
            var_5 = 1;
        }

        wait 0.2;
    }
}

linearlerp( var_0, var_1, var_2 )
{
    return abs( var_0 * ( 1 - var_2 ) + var_1 * var_2 );
}

dynamic_dof( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !common_scripts\utility::flag( "autofocus_loop_active" ) )
    {
        common_scripts\utility::flag_wait( var_3 );
        var_5 = 10;

        while ( common_scripts\utility::flag( var_3 ) )
        {
            common_scripts\utility::flag_set( "autofocus_loop_active" );
            var_6 = 12000;
            var_7 = level.player getangles();
            var_8 = anglestoforward( var_7 );

            if ( var_4 )
                var_9 = level.cameralinkpoint.origin;
            else
                var_9 = level.player.origin + ( 0, 0, 68 );

            var_10 = var_9 + var_8 * var_6;
            var_11 = bullettrace( var_9 + var_8 * 1, var_10, 0, undefined );
            var_12 = distance( var_9, var_11["position"] );
            var_13 = var_11["entity"];
            var_14 = var_12;

            if ( isdefined( var_13 ) )
            {
                if ( isdefined( var_13.origin ) )
                {
                    var_15 = distance( var_9, var_13.origin );

                    if ( var_15 < var_12 )
                        var_14 = var_15;
                }
            }

            var_16 = var_14 * var_0;
            var_16 = linearlerp( var_5, var_16, 0.35 );
            var_5 = var_16;
            level.dof["script"]["current"]["nearEnd"] = var_16;
            level.dof["script"]["current"]["farStart"] = var_14;
            level.dof["script"]["current"]["farEnd"] = var_14 * var_1;
            level.dof["script"]["current"]["farBlur"] = var_2;
            waitframe();
        }

        waitframe();
        common_scripts\utility::flag_clear( "autofocus_loop_active" );
        waitframe();
        thread dynamic_dof( var_0, var_1, var_2, var_3, var_4 );
    }
}

autofocus_loop()
{
    common_scripts\utility::flag_wait( "flag_autofocus_on" );

    if ( level.nextgen )
        setsaveddvar( "r_dof_physical_enable", 1 );

    level.player enablephysicaldepthoffieldscripting();
    waitframe();

    while ( common_scripts\utility::flag( "flag_autofocus_on" ) == 1 )
    {
        waitframe();
        var_0 = trace_distance();
        level.player setphysicaldepthoffield( 1.8, var_0 );
    }

    level.player disablephysicaldepthoffieldscripting();

    if ( level.nextgen )
        return;
}

trace_distance()
{
    var_0 = 10000;
    var_1 = level.player geteye();
    var_2 = level.player getangles();

    if ( isdefined( level.player.dof_ref_ent ) )
        var_3 = combineangles( level.player.dof_ref_ent.angles, var_2 );
    else
        var_3 = var_2;

    var_4 = vectornormalize( anglestoforward( var_3 ) );
    var_5 = bullettrace( var_1, var_1 + var_4 * var_0, 1, level.player, 1, 1, 0, 0, 0 );
    return distance( var_1, var_5["position"] );
}

lightintensityflicker( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = getent( var_0, "targetname" );

    if ( !isdefined( var_7 ) )
        return;

    common_scripts\utility::flag_wait( var_1 );
    common_scripts\utility::flag_clear( var_2 );
    var_8 = 1;

    while ( var_8 )
    {
        var_9 = randomfloatrange( var_3, var_4 );
        var_7 setlightintensity( var_9 );

        if ( common_scripts\utility::flag( var_2 ) )
        {
            var_8 = 0;
            common_scripts\utility::flag_clear( var_1 );
            thread lightintensityflicker( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );
            continue;
        }

        wait(randomfloatrange( var_5, var_6 ));
    }
}

set_level_lighting_values()
{
    if ( isusinghdr() )
    {
        setsaveddvar( "r_disableLightSets", 0 );
        setsaveddvar( "r_aodiminish", 0.1 );
        maps\_utility::vision_set_fog_changes( "greece", 0 );
        level.player lightsetforplayer( "greece" );

        if ( level.nextgen )
            level.player setclutforplayer( "clut_greece_safehouse_start_aa", 1.0 );
    }

    maps\_lighting::blend_dof_presets( "default", "greece_safehouse_intro", 1 );
}

init_level_lighting_flags()
{
    common_scripts\utility::flag_init( "init_safehouse_intro_lighting" );
    common_scripts\utility::flag_init( "init_tablet_overlay" );
    common_scripts\utility::flag_init( "init_safehouse_follow_lighting" );
    common_scripts\utility::flag_init( "init_safehouse_takedown_kill" );
    common_scripts\utility::flag_init( "init_safehouse_xslice" );
    common_scripts\utility::flag_init( "safehouse_terrace_int" );
    common_scripts\utility::flag_init( "safehouse_terrace_ext" );
    common_scripts\utility::flag_init( "init_safehouse_melee_kill_initiated_post" );
    common_scripts\utility::flag_init( "init_safehouse_clear_start_lighting" );
    common_scripts\utility::flag_init( "start_safehouse_computerlab_light_flicker" );
    common_scripts\utility::flag_init( "stop_safehouse_computerlab_light_flicker" );
    common_scripts\utility::flag_init( "init_safehouse_transition_start_lighting" );
    common_scripts\utility::flag_init( "greece_safehouse_exso_dressup" );
    common_scripts\utility::flag_init( "greece_safehouse_exso_dressup_fadeout" );
    common_scripts\utility::flag_init( "init_confcenter_start_lighting" );
    common_scripts\utility::flag_init( "init_begin_confcenter_support_a_lighting" );
    common_scripts\utility::flag_init( "init_begin_confcenter_support_b_lighting" );
    common_scripts\utility::flag_init( "init_begin_confcenter_support_c_lighting" );
    common_scripts\utility::flag_init( "init_begin_confcenter_kill_lighting" );
    common_scripts\utility::flag_init( "init_begin_confcenter_combat_lighting" );
    common_scripts\utility::flag_init( "init_begin_confcenter_outro_lighting" );
    common_scripts\utility::flag_init( "init_safehouse_outro_start_lighting" );
    common_scripts\utility::flag_init( "init_alleys_transition_start_lighting" );
    common_scripts\utility::flag_init( "init_alleys_lighting" );
    common_scripts\utility::flag_init( "init_sniper_scramble_lighting" );
    common_scripts\utility::flag_init( "init_sniper_scramble_hotel_lighting" );
    common_scripts\utility::flag_init( "init_sniper_scramble_drones_lighting" );
    common_scripts\utility::flag_init( "init_sniper_scramble_finale_lighting" );
    common_scripts\utility::flag_init( "init_ending_ambush_interact_lighting_level" );
    common_scripts\utility::flag_init( "Init_FlagEndingSetAmbushInteractBeginLighting" );
    common_scripts\utility::flag_init( "init_ending_hades_fight" );
    common_scripts\utility::flag_init( "halogen_flickering_jewelry_start" );
    common_scripts\utility::flag_init( "halogen_flickering_jewelry_stop" );
    common_scripts\utility::flag_init( "init_dynamic_dof" );
    common_scripts\utility::flag_init( "flag_autofocus_on" );
    common_scripts\utility::flag_init( "autofocus_loop_active" );
    common_scripts\utility::flag_init( "pre_ending_conf_culldist" );
    common_scripts\utility::flag_init( "ending_conf_culldist" );
}

setup_dof_presets()
{
    if ( level.nextgen )
    {
        maps\_lighting::create_dof_preset( "greece", 10, 18, 4.0, 2500, 38000, 0.964, 0.5 );
        maps\_lighting::create_dof_preset( "greece_safehouse_intro", 10, 18, 4.0, 2500, 38000, 0.964, 0.5 );
        maps\_lighting::create_dof_preset( "greece_safehouse_takedown_kill", 0, 0, 4.0, 0, 50, 2.0, 0.5 );
        maps\_lighting::create_dof_preset( "greece_safehouse_exso_dressup_fov", 0, 0, 4.0, 10, 200, 4.0, 0.5 );
        maps\_lighting::create_dof_preset( "greece_safehouse_transition_start", 10, 18, 4.0, 2500, 38000, 0.964, 0.5 );
        maps\_lighting::create_dof_preset( "greece_confcenter_start", 10, 18, 4.0, 2500, 38000, 0.964, 0.5 );
        maps\_lighting::create_dof_preset( "greece_confcenter_begin_support_a", 10, 18, 4.0, 1000, 22360, 1.8, 0.5 );
        maps\_lighting::create_dof_preset( "greece_confcenter_begin_support_b", 10, 18, 4.0, 1500, 30000, 0.964, 0.5 );
        maps\_lighting::create_dof_preset( "greece_confcenter_begin_support_c", 10, 18, 4.0, 1500, 30000, 0.964, 0.5 );
        maps\_lighting::create_dof_preset( "greece_confcenter_begin_kill", 10, 18, 4.0, 2500, 38000, 0.964, 0.5 );
        maps\_lighting::create_dof_preset( "greece_confcenter_begin_combat", 10, 18, 4.0, 2500, 38000, 0.964, 0.5 );
        maps\_lighting::create_dof_preset( "greece_confcenter_begin_outro", 10, 18, 4.0, 2500, 38000, 0.964, 0.5 );
        maps\_lighting::create_dof_preset( "greece_safehouse_outro_start", 10, 18, 4.0, 2500, 38000, 0.964, 0.5 );
        maps\_lighting::create_dof_preset( "greece_alleys_transition_start", 10, 18, 4.0, 2500, 38000, 0.964, 0.5 );
        maps\_lighting::create_dof_preset( "greece_alleys_start", 10, 18, 4.0, 2500, 38000, 0.964, 0.5 );
        maps\_lighting::create_dof_viewmodel_preset( "greece_drone_dof", 7, 15 );
    }
    else
    {
        maps\_lighting::create_dof_preset( "greece", 10, 18, 2.0, 2500, 38000, 0.564, 0.5 );
        maps\_lighting::create_dof_preset( "greece_safehouse_intro", 10, 18, 2.0, 2500, 38000, 0.564, 0.5 );
        maps\_lighting::create_dof_preset( "greece_safehouse_takedown_kill", 0, 0, 2.0, 0, 50, 2.0, 0.5 );
        maps\_lighting::create_dof_preset( "greece_safehouse_exso_dressup_fov", 0, 0, 2.0, 10, 200, 3.0, 0.5 );
        maps\_lighting::create_dof_preset( "greece_safehouse_transition_start", 10, 18, 2.0, 2500, 38000, 0.564, 0.5 );
        maps\_lighting::create_dof_preset( "greece_confcenter_start", 10, 18, 2.0, 2500, 38000, 0.564, 0.5 );
        maps\_lighting::create_dof_preset( "greece_confcenter_begin_support_a", 10, 60, 4.0, 6373, 30471, 2.12, 0.5 );
        maps\_lighting::create_dof_preset( "greece_confcenter_begin_support_b", 10, 18, 2.0, 1500, 30000, 0.564, 0.5 );
        maps\_lighting::create_dof_preset( "greece_confcenter_begin_support_c", 10, 18, 2.0, 1500, 30000, 0.564, 0.5 );
        maps\_lighting::create_dof_preset( "greece_confcenter_begin_kill", 10, 18, 2.0, 2500, 38000, 0.564, 0.5 );
        maps\_lighting::create_dof_preset( "greece_confcenter_begin_combat", 10, 18, 2.0, 2500, 38000, 0.564, 0.5 );
        maps\_lighting::create_dof_preset( "greece_confcenter_begin_outro", 10, 18, 2.0, 2500, 38000, 0.564, 0.5 );
        maps\_lighting::create_dof_preset( "greece_safehouse_outro_start", 10, 18, 2.0, 2500, 38000, 0.564, 0.5 );
        maps\_lighting::create_dof_preset( "greece_alleys_transition_start", 10, 18, 2.0, 2500, 38000, 0.564, 0.5 );
        maps\_lighting::create_dof_preset( "greece_alleys_start", 10, 18, 2.0, 2500, 38000, 0.564, 0.5 );
        maps\_lighting::create_dof_viewmodel_preset( "greece_drone_dof", 7, 15 );
    }
}

hack_lighttweaks_enable( var_0 )
{
    wait 0.1;
}

setup_vfx_sunflare()
{
    thread maps\_shg_fx::fx_spot_lens_flare_dir( "sunflare", ( -15.2216, 146.493, 0 ), 10000 );
}

initsafehouseintro()
{
    common_scripts\utility::flag_wait( "init_safehouse_intro_lighting" );

    if ( level.currentgen )
    {
        setculldist( 0 );
        var_0 = getent( "vista_buildings_intro", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 hide();
    }
    else
        setculldist( 0 );

    maps\_utility::vision_set_fog_changes( "greece_safehouse_intro", 0 );
    maps\_lighting::blend_dof_presets( "default", "greece_safehouse_intro", 1 );
    level.player lightsetforplayer( "safehouse_intro" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_safehouse_start_aa", 0.0 );

    thread setup_ilona_lighting();
}

setup_ilona_lighting()
{
    if ( level.nextgen )
    {
        setsaveddvar( "r_dof_physical_bokehEnable", 1 );
        var_0 = getent( "char_fill", "targetname" );
        thread maps\_lighting::set_spot_intensity( "char_fill", 5000 );
        var_0 setlightradius( 120 );
        var_0 setlightfovrange( 110, 20 );
        var_1 = getent( "char_rim", "targetname" );
        thread maps\_lighting::set_spot_intensity( "char_rim", 50000 );
        var_1 setlightradius( 120 );
        var_1 setlightfovrange( 110, 20 );
    }

    var_2 = getent( "ilona_lighting_centroid", "targetname" );
    level.allies["Ilona"] overridelightingorigin( var_2.origin );
}

inittabletoverlay()
{
    common_scripts\utility::flag_wait( "init_tablet_overlay" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_security_cam", 0.0 );
    else
        maps\_utility::vision_set_fog_changes( "greece_tablet_overlay", 0 );

    setsaveddvar( "r_dof_physical_hipenable", 1 );
    setsaveddvar( "r_dof_physical_hipFstop", 1.5 );

    if ( level.currentgen )
    {
        setculldist( 6500 );
        var_0 = getent( "vista_buildings_intro", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 show();
    }
    else
        setculldist( 0 );

    common_scripts\utility::flag_clear( "init_tablet_overlay" );
}

setup_dof_safehouseintro()
{
    common_scripts\utility::flag_wait( "init_safehouse_intro_lighting" );
    wait 2.0;

    if ( level.nextgen )
        setsaveddvar( "r_dof_physical_enable", 1 );

    setsaveddvar( "r_dof_physical_hipenable", 0 );
    level.player enablephysicaldepthoffieldscripting();

    if ( level.nextgen )
    {
        level.player setphysicaldepthoffield( 2.0, 450.0, 2.0, 2.0 );
        wait 3.0;
        level.player setphysicaldepthoffield( 3.0, 70.0, 2.0, 2.0 );
        wait 8.0;
        level.player setphysicaldepthoffield( 3.0, 54.0 );
        wait 5.0;
        level.player setphysicaldepthoffield( 3.0, 60.0 );
    }
    else
    {
        level.player setphysicaldepthoffield( 3.0, 450.0, 2.0, 2.0 );
        wait 3.0;
        level.player setphysicaldepthoffield( 2.8, 60.0, 2.0, 2.0 );
        wait 8.0;
        level.player setphysicaldepthoffield( 3.0, 54.0 );
        wait 5.0;
        level.player setphysicaldepthoffield( 3.0, 60.0 );
    }

    common_scripts\utility::flag_wait( "FlagScanTargetBegin" );
    level.player disablephysicaldepthoffieldscripting();

    if ( level.nextgen )
        setsaveddvar( "r_dof_physical_hipenable", 0 );

    wait 2.0;
    maps\_lighting::blend_dof_presets( "default", "greece_safehouse_intro", 1.0 );
}

initsafehousefollow()
{
    common_scripts\utility::flag_wait( "init_safehouse_follow_lighting" );
    common_scripts\utility::flag_clear( "init_tablet_overlay" );

    if ( level.currentgen )
    {
        setculldist( 0 );
        var_0 = getent( "vista_buildings_intro", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 show();
    }
    else
        setculldist( 0 );

    maps\_utility::vision_set_fog_changes( "greece_safehouse_intro", 1 );
    level.player lightsetforplayer( "safehouse_intro" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_safehouse_start_aa", 0.0 );

    thread setup_ilona_lighting();
    setsaveddvar( "r_dof_physical_hipenable", 0 );
}

setup_dof_safehousefollow()
{
    common_scripts\utility::flag_wait( "init_safehouse_follow_lighting" );

    if ( level.nextgen )
        setsaveddvar( "r_dof_physical_enable", 1 );

    level.player enablephysicaldepthoffieldscripting();

    if ( level.nextgen )
    {
        level.player setphysicaldepthoffield( 8.0, 14, 20, 20 );
        wait 2.0;
        level.player setphysicaldepthoffield( 12.0, 55.0, 2, 2 );
        wait 4.0;
        level.player setphysicaldepthoffield( 3.8, 26.0, 2, 2 );
        wait 1.5;
        level.player setphysicaldepthoffield( 8.0, 70.0, 1, 2 );
    }
    else
    {
        level.player setphysicaldepthoffield( 5.0, 14, 20, 20 );
        wait 1.5;
        level.player setphysicaldepthoffield( 3.8, 55.0, 7, 7 );
        wait 2.0;
        level.player setphysicaldepthoffield( 4.8, 26.0, 7, 7 );
        wait 4.5;
        level.player setphysicaldepthoffield( 11.0, 250.0, 1, 2 );
    }

    wait 5;

    if ( level.nextgen )
    {
        setsaveddvar( "r_mbEnable", 0 );
        level.player disablephysicaldepthoffieldscripting();
    }

    var_0 = getent( "ilona_lighting_centroid", "targetname" );
    level.allies["Ilona"] defaultlightingorigin();

    if ( level.nextgen )
    {

    }

    if ( !common_scripts\utility::flag( "flag_autofocus_on" ) )
    {
        common_scripts\utility::flag_set( "flag_autofocus_on" );
        thread dynamic_dof( 0.015, 5, 0.8, "flag_autofocus_on", 0 );
    }
}

inittakedownkill()
{
    maps\_lighting::blend_dof_presets( "greece_safehouse_intro", "greece_safehouse_takedown_kill", 0.5 );
    wait 4.0;
    wait 1.0;
    maps\_lighting::blend_dof_presets( "greece_safehouse_takedown_kill", "greece_safehouse_intro", 1.0 );
}

initsafehousetakedownkill()
{
    common_scripts\utility::flag_wait( "init_safehouse_melee_kill_initiated_post" );

    if ( level.currentgen )
    {
        setculldist( 3000 );
        var_0 = getent( "vista_buildings_intro", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 hide();
    }
    else
        setculldist( 3000 );

    thread inittakedownkill();
}

setup_dof_takedownkill()
{
    common_scripts\utility::flag_wait( "init_safehouse_melee_kill_initiated_post" );
    thread inittakedownkill();

    if ( level.nextgen )
    {
        setsaveddvar( "r_mbEnable", 2 );
        setsaveddvar( "r_mbVelocityScalar", 0.5 );
        setsaveddvar( "r_dof_physical_enable", 1 );
    }

    level.player enablephysicaldepthoffieldscripting();

    if ( level.nextgen )
    {
        level.player setphysicaldepthoffield( 6.0, 20.0 );
        wait 0.5;
        level.player setphysicaldepthoffield( 6.0, 20.0 );
        wait 0.5;
        level.player setphysicaldepthoffield( 6.0, 70.0 );
        wait 0.5;
        level.player setphysicaldepthoffield( 6.0, 26.0 );
        wait 0.5;
        level.player setphysicaldepthoffield( 6.0, 7.5 );
        wait 1.5;
        level.player setphysicaldepthoffield( 6.0, 20.0 );
        wait 1.0;
        level.player setphysicaldepthoffield( 12.0, 350.0 );
        wait 2.0;
        level.player setphysicaldepthoffield( 12.0, 40.0 );
        wait 1.0;
        level.player setphysicaldepthoffield( 12.0, 250.0 );
    }
    else
    {
        level.player setphysicaldepthoffield( 5.2, 20.0 );
        wait 0.5;
        level.player setphysicaldepthoffield( 5.2, 20.0 );
        wait 0.5;
        level.player setphysicaldepthoffield( 5.2, 70.0 );
        wait 0.5;
        level.player setphysicaldepthoffield( 5.2, 26.0 );
        wait 0.5;
        level.player setphysicaldepthoffield( 5.2, 7.5 );
        wait 1.5;
        level.player setphysicaldepthoffield( 5.2, 20.0 );
        wait 1.0;
        level.player setphysicaldepthoffield( 9.0, 350.0 );
        wait 2.0;
        level.player setphysicaldepthoffield( 9.0, 40.0 );
        wait 1.0;
        level.player setphysicaldepthoffield( 9.0, 250.0 );
    }

    wait 1.0;
    level.player disablephysicaldepthoffieldscripting();

    if ( level.nextgen )
    {

    }

    wait 0.2;
    wait 1;

    if ( level.nextgen )
        setsaveddvar( "r_mbEnable", 0 );

    maps\_lighting::blend_dof_presets( "default", "greece_safehouse_transition_start", 1.0 );
}

initsafehousexslice()
{
    common_scripts\utility::flag_wait( "init_safehouse_xslice" );

    if ( level.currentgen )
    {
        setculldist( 3000 );
        var_0 = getent( "vista_buildings_intro", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 show();
    }
    else
        setculldist( 3000 );

    maps\_utility::vision_set_fog_changes( "greece_safehouse_intro", 0 );
    maps\_lighting::blend_dof_presets( "default", "greece_safehouse_intro", 0 );
    level.player lightsetforplayer( "safehouse_intro" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_safehouse_start_aa", 0.0 );
}

initsafehouseclearstart()
{
    common_scripts\utility::flag_wait( "init_safehouse_clear_start_lighting" );

    if ( level.currentgen )
    {
        setculldist( 3000 );
        var_0 = getent( "vista_buildings_intro", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 show();
    }
    else
        setculldist( 3000 );

    maps\_utility::vision_set_fog_changes( "greece_safehouse_intro", 0 );
    maps\_lighting::blend_dof_presets( "default", "greece_safehouse_intro", 0 );
    level.player lightsetforplayer( "safehouse_intro" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_safehouse_start_aa", 3.0 );

    common_scripts\utility::flag_set( "start_safehouse_computerlab_light_flicker" );
}

setsafehouseextdrawdist()
{
    common_scripts\utility::flag_wait( "safehouse_terrace_ext" );

    if ( level.currentgen )
    {
        setculldist( 0 );
        var_0 = getent( "vista_buildings_intro", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 show();

        common_scripts\utility::flag_clear( "safehouse_terrace_ext" );
        thread setsafehouseextdrawdist();
    }
}

setsafehouseintdrawdist()
{
    common_scripts\utility::flag_wait( "safehouse_terrace_int" );

    if ( level.currentgen )
    {
        setculldist( 3000 );
        var_0 = getent( "vista_buildings_intro", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 show();

        common_scripts\utility::flag_clear( "safehouse_terrace_int" );
        thread setsafehouseintdrawdist();
    }
}

initsafehousetransitionstart()
{
    common_scripts\utility::flag_wait( "init_safehouse_transition_start_lighting" );

    if ( level.currentgen )
    {
        setculldist( 3000 );
        var_0 = getent( "vista_buildings_intro", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 show();
    }
    else
        setculldist( 0 );

    maps\_utility::vision_set_fog_changes( "greece_safehouse_dark", 1 );
    maps\_lighting::blend_dof_presets( "default", "greece_safehouse_intro", 1 );
    level.player lightsetforplayer( "safehouse_dark" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_safehouse_start_aa", 3.0 );
}

initsafehouseexosuitup()
{
    common_scripts\utility::flag_wait( "greece_safehouse_exso_dressup" );
    maps\_lighting::blend_dof_presets( "greece_safehouse_intro", "greece_safehouse_exso_dressup_fov", 6 );
}

initsafehouseexosuitupfadeout()
{
    common_scripts\utility::flag_wait( "greece_safehouse_exso_dressup_fadeout" );
    maps\_lighting::blend_dof_presets( "greece_safehouse_exso_dressup_fov", "greece_safehouse_intro", 2 );
}

hackenablevisiontweaks()
{

}

setup_dof_drone()
{
    setsaveddvar( "r_dof_physical_hipEnable", 1 );
    setsaveddvar( "r_dof_physical_hipFstop", 0.15 );
    setsaveddvar( "r_dof_physical_hipSharpCocDiameter", 0.05 );
    setsaveddvar( "r_dof_physical_hipFocusSpeed", 32, 32, 32, 32 );
}

initconfcenterstart()
{
    common_scripts\utility::flag_wait( "init_confcenter_start_lighting" );

    if ( level.currentgen )
        setculldist( 0 );
    else
        setculldist( 0 );

    maps\_utility::vision_set_fog_changes( "greece_confcenter_begin_support_a", 0.0 );
    maps\_lighting::blend_dof_presets( "default", "greece_confcenter_begin_support_a", 0 );
    level.player lightsetforplayer( "confcenter_start" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_conference_center_aa", 0.0 );

    common_scripts\utility::flag_set( "stop_safehouse_computerlab_light_flicker" );
    thread setup_dof_drone();
}

initbeginconfcentersupporta()
{
    common_scripts\utility::flag_wait( "init_begin_confcenter_support_a_lighting" );

    if ( level.currentgen )
        setculldist( 0 );
    else
        setculldist( 0 );

    level.player enableforceviewmodeldof();
    maps\_utility::vision_set_fog_changes( "greece_confcenter_begin_support_a", 0 );
    maps\_lighting::blend_dof_presets( "default", "greece_confcenter_begin_support_a", 0 );
    maps\_lighting::blend_dof_viewmodel_presets( "default", "greece_drone_dof", 0.1 );
    level.player lightsetforplayer( "confcenter_start" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_conference_center_aa", 0.0 );

    thread setup_dof_drone();
}

initbeginconfcentersupportb()
{
    common_scripts\utility::flag_wait( "init_begin_confcenter_support_b_lighting" );

    if ( level.currentgen )
        setculldist( 0 );
    else
        setculldist( 0 );

    maps\_utility::vision_set_fog_changes( "greece_confcenter_begin_support_a", 0 );
    maps\_lighting::blend_dof_presets( "default", "greece_confcenter_begin_support_a", 0 );
    maps\_lighting::blend_dof_viewmodel_presets( "default", "greece_drone_dof", 0.1 );
    thread hackenablevisiontweaks();
    level.player lightsetforplayer( "confcenter_start" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_conference_center_aa", 0.0 );

    thread setup_dof_drone();
}

initbeginconfcentersupportc()
{
    common_scripts\utility::flag_wait( "init_begin_confcenter_support_c_lighting" );

    if ( level.currentgen )
        setculldist( 0 );
    else
        setculldist( 0 );

    maps\_utility::vision_set_fog_changes( "greece_confcenter_begin_support_a", 0 );
    maps\_lighting::blend_dof_presets( "default", "greece_confcenter_begin_support_a", 0 );
    maps\_lighting::blend_dof_viewmodel_presets( "default", "greece_drone_dof", 0.1 );
    thread hackenablevisiontweaks();
    level.player lightsetforplayer( "confcenter_start" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_conference_center_aa", 0.0 );

    thread setup_dof_drone();
}

initbeginconfcenterkill()
{
    common_scripts\utility::flag_wait( "init_begin_confcenter_kill_lighting" );

    if ( level.currentgen )
        setculldist( 0 );
    else
        setculldist( 0 );

    maps\_utility::vision_set_fog_changes( "greece_confcenter_begin_support_a", 0 );
    maps\_lighting::blend_dof_presets( "default", "greece_confcenter_begin_support_a", 0 );
    level.player lightsetforplayer( "confcenter_start" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_conference_center_aa", 0.0 );

    thread setup_dof_drone();
}

initbeginconfcentercombat()
{
    common_scripts\utility::flag_wait( "init_begin_confcenter_combat_lighting" );

    if ( level.currentgen )
        setculldist( 0 );
    else
        setculldist( 0 );

    maps\_utility::vision_set_fog_changes( "greece_confcenter_begin_support_a", 0 );
    maps\_lighting::blend_dof_presets( "default", "greece_confcenter_begin_support_a", 0 );
    level.player lightsetforplayer( "confcenter_start" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_conference_center_aa", 0.0 );

    thread setup_dof_drone();
}

initbeginconfcenteroutro()
{
    common_scripts\utility::flag_wait( "init_begin_confcenter_outro_lighting" );

    if ( level.currentgen )
        setculldist( 0 );
    else
        setculldist( 0 );

    maps\_utility::vision_set_fog_changes( "greece_confcenter_begin_support_a", 0 );
    maps\_lighting::blend_dof_presets( "default", "greece_confcenter_begin_support_a", 0 );
    level.player lightsetforplayer( "confcenter_start" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_conference_center_aa", 0.0 );

    thread setup_dof_drone();
}

initsafehouseoutrostart()
{
    common_scripts\utility::flag_wait( "init_safehouse_outro_start_lighting" );
    setsaveddvar( "r_dof_physical_hipenable", 0 );

    if ( level.currentgen )
    {
        setculldist( 0 );
        var_0 = getent( "vista_buildings_intro", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 show();
    }
    else
        setculldist( 0 );

    if ( level.nextgen )
    {

    }

    thread handlesafehouseoutroblur();
    maps\_utility::vision_set_fog_changes( "greece_safehouse_outro_start", 0 );
    level.player lightsetforplayer( "safehouse_outro_start" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_safehouse_start_aa", 0.0 );

    common_scripts\utility::flag_set( "start_safehouse_computerlab_light_flicker" );
    common_scripts\utility::flag_wait( "FlagTriggerExitPlayerComingDownStairs" );
    var_1 = getent( "light_cuc_greece_bullets_ent", "targetname" );
    var_2 = getent( "safehouse_windowblast_light", "targetname" );

    if ( isdefined( var_1 ) && isdefined( var_2 ) )
    {
        var_1 setlightshadowstate( "force_on" );
        thread maps\_lighting::lerp_spot_intensity( "light_cuc_greece_bullets_ent", 1, 1 );
        wait 1.0;
        thread maps\_lighting::lerp_spot_intensity( "light_cuc_greece_bullets_ent", 1, 0.1 );
        var_2 setlightshadowstate( "force_on" );
        thread maps\_lighting::lerp_spot_intensity( "safehouse_windowblast_light", 3, 75000 );
        common_scripts\utility::flag_wait( "FlagTriggerExitPlayerLeavingBuilding" );
        var_1 setlightshadowstate( "normal" );
        thread maps\_lighting::lerp_spot_intensity( "safehouse_windowblast_light", 2, 0.1 );
    }
}

handlesafehouseoutroblur()
{
    wait 3.0;

    if ( !common_scripts\utility::flag( "flag_autofocus_on" ) )
    {
        common_scripts\utility::flag_set( "flag_autofocus_on" );
        thread dynamic_dof( 0.015, 5, 0.8, "flag_autofocus_on", 0 );
    }

    maps\_lighting::blend_dof_presets( "default", "greece_safehouse_outro_start", 0 );
    level.player setviewmodeldepthoffield( 1, 0 );
}

setalleystransitionculldist()
{
    common_scripts\utility::flag_wait( "FlagTriggerAlleysTransitionStreet" );

    if ( level.currentgen )
        setculldist( 6500 );
    else
        setculldist( 6500 );
}

initalleystransitionstart()
{
    common_scripts\utility::flag_wait( "init_alleys_transition_start_lighting" );
    wait 2.0;

    if ( level.currentgen )
    {
        setculldist( 6500 );
        var_0 = getent( "vista_buildings_intro", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 show();
    }
    else
        setculldist( 6500 );

    if ( !common_scripts\utility::flag( "flag_autofocus_on" ) )
    {
        common_scripts\utility::flag_set( "flag_autofocus_on" );
        thread dynamic_dof( 0.015, 5, 0.8, "flag_autofocus_on", 0 );
    }

    maps\_utility::vision_set_fog_changes( "greece_alleys_transition_start", 3 );
    level.player lightsetforplayer( "alleys_transition_start" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_safehouse_start_aa", 2.0 );
}

initalleysstart()
{
    common_scripts\utility::flag_wait( "init_alleys_lighting" );

    if ( level.currentgen )
    {
        setculldist( 3000 );
        var_0 = getent( "vista_buildings_intro", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 show();
    }
    else
        setculldist( 3000 );

    if ( !common_scripts\utility::flag( "flag_autofocus_on" ) )
    {
        common_scripts\utility::flag_set( "flag_autofocus_on" );
        thread dynamic_dof( 0.015, 5, 0.8, "flag_autofocus_on", 0 );
    }

    maps\_utility::vision_set_fog_changes( "greece_alleys_start", 1 );
    maps\_lighting::blend_dof_presets( "default", "greece_alleys_start", 0 );
    level.player lightsetforplayer( "alleys_start" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_safehouse_start_aa", 1.0 );

    common_scripts\utility::flag_set( "stop_safehouse_computerlab_light_flicker" );
    common_scripts\utility::flag_set( "halogen_flickering_jewelry_start" );
}

initsniperscrambleintro()
{
    common_scripts\utility::flag_wait( "FlagSniperScrambleStart" );

    if ( level.currentgen )
    {
        setculldist( 5000 );
        var_0 = getent( "vista_buildings_intro", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 hide();
    }
    else
        setculldist( 0 );

    if ( !common_scripts\utility::flag( "flag_autofocus_on" ) )
    {
        common_scripts\utility::flag_set( "flag_autofocus_on" );
        thread dynamic_dof( 0.015, 5, 0.8, "flag_autofocus_on", 0 );
    }

    maps\_utility::vision_set_fog_changes( "greece_sniper_scramble_start", 0 );
    level.player lightsetforplayer( "sniper_scramble_start" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_safehouse_start_aa", 2.0 );
}

initsniperscramblestarthotel()
{
    common_scripts\utility::flag_wait( "init_sniper_scramble_hotel_lighting" );

    if ( level.currentgen )
    {
        setculldist( 9000 );
        var_0 = getent( "vista_buildings_intro", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 hide();
    }
    else
        setculldist( 0 );

    if ( !common_scripts\utility::flag( "flag_autofocus_on" ) )
    {
        common_scripts\utility::flag_set( "flag_autofocus_on" );
        thread dynamic_dof( 0.015, 5, 0.8, "flag_autofocus_on", 0 );
    }

    if ( level.nextgen )
        maps\_utility::vision_set_fog_changes( "greece_sniper_scramble_start", 0 );
    else
        maps\_utility::vision_set_fog_changes( "greece_sniper_scramble", 0 );

    level.player lightsetforplayer( "sniper_scramble_start" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_safehouse_start_aa", 0.0 );
}

initsniperscrambledrones()
{
    common_scripts\utility::flag_wait( "init_sniper_scramble_drones_lighting" );

    if ( level.currentgen )
    {
        setculldist( 9000 );
        var_0 = getent( "vista_buildings_intro", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 hide();
    }
    else
        setculldist( 0 );

    if ( !common_scripts\utility::flag( "flag_autofocus_on" ) )
    {
        common_scripts\utility::flag_set( "flag_autofocus_on" );
        thread dynamic_dof( 0.015, 5, 0.8, "flag_autofocus_on", 0 );
    }

    if ( level.nextgen )
        maps\_utility::vision_set_fog_changes( "greece_sniper_scramble_start", 0 );
    else
        maps\_utility::vision_set_fog_changes( "greece_sniper_scramble", 0 );

    level.player lightsetforplayer( "sniper_scramble_start" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_safehouse_start_aa", 0.0 );
}

initsniperscramblefinalelighting()
{
    common_scripts\utility::flag_wait( "init_sniper_scramble_finale_lighting" );

    if ( level.currentgen )
    {
        setculldist( 9000 );
        var_0 = getent( "vista_buildings_intro", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 hide();
    }
    else
        setculldist( 0 );

    if ( !common_scripts\utility::flag( "flag_autofocus_on" ) )
    {
        common_scripts\utility::flag_set( "flag_autofocus_on" );
        thread dynamic_dof( 0.015, 5, 0.8, "flag_autofocus_on", 0 );
    }

    if ( level.nextgen )
        maps\_utility::vision_set_fog_changes( "greece_sniper_scramble_start", 0 );
    else
        maps\_utility::vision_set_fog_changes( "greece_sniper_scramble", 0 );

    level.player lightsetforplayer( "sniper_scramble_start" );

    if ( level.nextgen )
        level.player setclutforplayer( "clut_greece_safehouse_start_aa", 0.0 );

    common_scripts\utility::flag_wait( "FlagScrambleSniperKilled" );
    maps\_utility::vision_set_fog_changes( "greece_convoy_explosion", 0.25 );
    wait 0.12;
    maps\_utility::vision_set_fog_changes( "greece_sniper_scramble_start", 0.25 );
    common_scripts\utility::flag_wait( "FlagScramblePlayerStartMoveTruck" );

    if ( level.nextgen )
    {
        setsaveddvar( "r_dof_physical_enable", 1 );
        level.player enablephysicaldepthoffieldscripting();
        setsaveddvar( "r_mbEnable", 2 );
        setsaveddvar( "r_mbVelocityScalar", 0.5 );
        level.player setphysicaldepthoffield( 3.0, 54.0 );
        wait 3.5;
        level.player setphysicaldepthoffield( 3.0, 55.0 );
        wait 1.5;
        level.player setphysicaldepthoffield( 6.0, 45.0 );
        wait 1.5;
        level.player setphysicaldepthoffield( 8.0, 55.0 );
        wait 0.5;
        level.player setphysicaldepthoffield( 12.0, 160.0 );
        wait 0.5;

        if ( level.nextgen )
            setsaveddvar( "r_mbEnable", 0 );
    }
    else
    {
        level.player setphysicaldepthoffield( 4.0, 54.0 );
        wait 4;
        level.player setphysicaldepthoffield( 4.0, 13.0 );
        wait 4;
        level.player setphysicaldepthoffield( 3.0, 26.0 );
    }

    wait 0.5;
    level.player disablephysicaldepthoffieldscripting();

    if ( level.nextgen )
    {

    }

    wait 0.2;
    maps\_lighting::blend_dof_presets( "default", "greece_safehouse_intro", 1.0 );
}

initendingambushinteractlighting()
{
    common_scripts\utility::flag_wait( "init_ending_ambush_interact_lighting_level" );
    level.player lightsetforplayer( "sniper_scramble_start" );

    if ( level.currentgen )
    {
        setculldist( 10000 );
        var_0 = getent( "vista_buildings_intro", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 hide();
    }
    else
        setculldist( 10000 );

    if ( level.nextgen )
    {
        level.player setclutforplayer( "clut_greece_safehouse_start_aa", 2.0 );
        setsaveddvar( "r_mbEnable", 2 );
        setsaveddvar( "r_mbVelocityScalar", 0.5 );
    }
    else
        maps\_utility::vision_set_fog_changes( "greece_sniper_scramble", 1.0 );

    if ( level.nextgen )
    {
        setsaveddvar( "r_dof_physical_enable", 1 );
        level.player enablephysicaldepthoffieldscripting();
        level.player setphysicaldepthoffield( 8.0, 16.0, 2, 2 );
        wait 0.5;
        level.player setphysicaldepthoffield( 18.0, 330.0, 2, 2 );
        wait 2.2;
        level.player setphysicaldepthoffield( 3.0, 17.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 6.0, 115.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 8.0, 40.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 12.0, 110.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 18.0, 348.0, 2, 2 );
        wait 3.0;
        level.player setphysicaldepthoffield( 22.0, 850.0, 2, 2 );
        wait 2.0;
        level.player setphysicaldepthoffield( 22.0, 13.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 22.0, 320.0, 2, 2 );
        wait 2.5;
        level.player setphysicaldepthoffield( 32.0, 389.0, 2, 2 );
        wait 0.5;
    }
    else
    {
        level.player setphysicaldepthoffield( 2, 16.0, 2, 2 );
        wait 2.0;
        level.player setphysicaldepthoffield( 4.0, 30.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 6.0, 234.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 6.0, 155.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 9.0, 51.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 13.0, 127.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 19.0, 348.0, 2, 2 );
        wait 3.0;
        level.player setphysicaldepthoffield( 23.0, 850.0, 2, 2 );
        wait 2.0;
        level.player setphysicaldepthoffield( 23.0, 13.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 23.0, 320.0, 2, 2 );
        wait 10.0;
        level.player setphysicaldepthoffield( 33.0, 389.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 19.0, 17.0, 2, 2 );
        wait 6.0;
        level.player setphysicaldepthoffield( 33.0, 389.0, 2, 2 );
        wait 0.5;
    }

    level.player disablephysicaldepthoffieldscripting();

    if ( level.nextgen )
    {

    }

    wait 0.2;
    wait 1;

    if ( level.nextgen )
        setsaveddvar( "r_mbEnable", 0 );

    maps\_lighting::blend_dof_presets( "default", "greece_safehouse_transition_start", 1.0 );

    if ( !common_scripts\utility::flag( "flag_autofocus_on" ) )
    {
        common_scripts\utility::flag_set( "flag_autofocus_on" );
        thread dynamic_dof( 0.015, 5, 0.8, "flag_autofocus_on", 0 );
    }
}

ending_confculldist()
{
    common_scripts\utility::flag_wait( "ending_conf_culldist" );

    if ( level.currentgen )
        setculldist( 10000 );

    common_scripts\utility::flag_clear( "ending_conf_culldist" );
    thread ending_confculldist();
}

preending_confculldist()
{
    common_scripts\utility::flag_wait( "pre_ending_conf_culldist" );

    if ( level.currentgen )
        setculldist( 3000 );

    common_scripts\utility::flag_clear( "pre_ending_conf_culldist" );
    thread preending_confculldist();
}

endingambushvision()
{
    common_scripts\utility::flag_wait( "Init_FlagEndingSetAmbushInteractBeginLighting" );

    if ( level.currentgen )
    {
        setculldist( 8000 );
        var_0 = getent( "vista_buildings_intro", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 hide();
    }
    else
        setculldist( 10000 );

    maps\_utility::vision_set_fog_changes( "greece_convoy_explosion", 0.5 );
    wait 0.25;
    maps\_utility::vision_set_fog_changes( "greece_sniper_scramble_start", 0.5 );
}

initendinghadesfight()
{
    common_scripts\utility::flag_wait( "init_ending_hades_fight" );
    common_scripts\utility::flag_wait( "FlagEndingHadesVehicleInteractBegin" );

    if ( level.currentgen )
    {
        setculldist( 3000 );
        var_0 = getent( "vista_buildings_intro", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 hide();
    }
    else
        setculldist( 10000 );

    if ( level.nextgen )
    {
        setsaveddvar( "r_mbEnable", 2 );
        setsaveddvar( "r_mbVelocityScalar", 0.5 );
        setsaveddvar( "r_dof_physical_enable", 1 );
        level.player enablephysicaldepthoffieldscripting();
        level.player setphysicaldepthoffield( 4.0, 16.0, 2, 2 );
        wait 2.0;
        level.player setphysicaldepthoffield( 5.0, 40.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 7.0, 14.0, 2, 2 );
        wait 3.0;
        level.player setphysicaldepthoffield( 7.0, 155.0, 2, 2 );
        wait 2.1;
        level.player setphysicaldepthoffield( 14.0, 50.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 14.0, 127.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 7.0, 12.0, 2, 2 );
        maps\_utility::vision_set_fog_changes( "greece_ending_hades", 2.0 );
        wait 3.0;
        level.player setphysicaldepthoffield( 28.0, 850.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 28.0, 13.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 28.0, 320.0, 2, 2 );
        maps\_utility::vision_set_fog_changes( "greece_sniper_scramble_start", 4.0 );
        wait 5.0;
        level.player setphysicaldepthoffield( 32.0, 389.0, 2, 2 );
        wait 47.0;
        level.player setphysicaldepthoffield( 6.0, 20.0, 2, 2 );
        wait 2.0;
        level.player setphysicaldepthoffield( 36.0, 389.0, 2, 2 );
        wait 3.0;
        level.player setphysicaldepthoffield( 6.0, 20.0, 2, 2 );
        wait 16.0;
        level.player setphysicaldepthoffield( 20.0, 60.0, 2, 2 );
        wait 20.0;
    }
    else
    {
        level.player setphysicaldepthoffield( 3.0, 16.0, 2, 2 );
        wait 2.0;
        level.player setphysicaldepthoffield( 4.0, 40.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 6.0, 14.0, 2, 2 );
        wait 3.0;
        level.player setphysicaldepthoffield( 6.0, 155.0, 2, 2 );
        wait 2.1;
        level.player setphysicaldepthoffield( 13.0, 50.0, 2, 2 );
        maps\_utility::vision_set_fog_changes( "greece_ending_hades", 1.0 );
        wait 1.0;
        level.player setphysicaldepthoffield( 13.0, 127.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 6.0, 12.0, 2, 2 );
        wait 3.0;
        level.player setphysicaldepthoffield( 24.0, 850.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 24.0, 13.0, 2, 2 );
        wait 1.0;
        level.player setphysicaldepthoffield( 24.0, 320.0, 2, 2 );
        maps\_utility::vision_set_fog_changes( "greece_sniper_scramble", 4.0 );
        wait 5.0;
        level.player setphysicaldepthoffield( 33.0, 389.0, 2, 2 );
        wait 45.0;
        level.player setphysicaldepthoffield( 3, 20.0, 2, 2 );
        wait 20.0;
    }

    level.player disablephysicaldepthoffieldscripting();

    if ( level.nextgen )
    {

    }

    wait 0.2;
    wait 1;

    if ( level.nextgen )
        setsaveddvar( "r_mbEnable", 0 );

    maps\_lighting::blend_dof_presets( "default", "greece_safehouse_transition_start", 1.0 );

    if ( !common_scripts\utility::flag( "flag_autofocus_on" ) )
    {
        common_scripts\utility::flag_set( "flag_autofocus_on" );
        thread dynamic_dof( 0.015, 5, 0.8, "flag_autofocus_on", 0 );
    }
}
