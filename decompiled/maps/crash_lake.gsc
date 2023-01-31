// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

precache_overlook()
{
    common_scripts\utility::flag_init( "overlook_done" );
    common_scripts\utility::flag_init( "FLAG_overlook_death" );
    common_scripts\utility::flag_init( "crash_overlook" );
    common_scripts\utility::flag_init( "overlook_save" );
    common_scripts\utility::flag_init( "lake_begin_outdoors" );
    maps\_utility::add_control_based_hint_strings( "player_crash_falloff", &"CRASH_FALLOFF", ::should_break_recover_hint );
}

precache_lake()
{
    common_scripts\utility::flag_init( "ice_lake_start_combat" );
    common_scripts\utility::flag_init( "lake_done" );
    common_scripts\utility::flag_init( "gideon_frees_you" );
    common_scripts\utility::flag_init( "ice_lake_side_wave" );
    common_scripts\utility::flag_init( "ice_lake_move_up" );
    common_scripts\utility::flag_init( "survivors_vulnerable" );
    common_scripts\utility::flag_init( "kill_survivors" );
    common_scripts\utility::flag_init( "ice_lake_cormack_movedown" );
    common_scripts\utility::flag_init( "ice_lake_wave_1_done" );
    common_scripts\utility::flag_init( "ice_lake_wave_2_done" );
    common_scripts\utility::flag_init( "ice_lake_wave_3_done" );
    common_scripts\utility::flag_init( "start_shooting_at_squad" );
    common_scripts\utility::flag_init( "ice_lake_callout_pause" );
    common_scripts\utility::flag_init( "lake_underwater_lighting" );
    common_scripts\utility::flag_init( "lake_drown" );
    common_scripts\utility::flag_init( "lake_player_fail" );
    common_scripts\utility::flag_init( "cargo_captured" );
    common_scripts\utility::flag_init( "player_swimming_end" );
    common_scripts\utility::flag_init( "player_swimming_drown" );
    precacheitem( "iw5_mahemstraight_sp" );
    precachestring( &"CRASH_FAIL_CARGO" );
    precachestring( &"CRASH_FAIL_DROWN" );
    maps\_utility::add_control_based_hint_strings( "player_lake_swim", &"CRASH_HINT_SWIM_GAMEPAD", ::should_break_swim_hint, &"CRASH_HINT_SWIM_KEYBOARD", &"CRASH_HINT_SWIM_GAMEPAD_S" );
    precachemodel( "generic_prop_raven" );
    precachemodel( "mob_crane_container_short_blk" );
}

precache_lake_cinema()
{
    common_scripts\utility::flag_init( "lake_cinema_done" );
    common_scripts\utility::flag_init( "setup_lake_cargo" );
    common_scripts\utility::flag_init( "go_lake_cargo" );
    common_scripts\utility::flag_init( "go_gideon_moment" );
    common_scripts\utility::flag_init( "go_lighting_gideon" );
    common_scripts\utility::flag_init( "gideon_lighting_unlock" );
    common_scripts\utility::flag_init( "go_gideon_moment_save" );
}

debug_start_overlook()
{
    maps\crash::set_completed_flags();
    maps\crash_utility::setup_player();
    maps\crash_utility::setup_allies();
    soundscripts\_snd::snd_message( "start_overlook" );
    common_scripts\utility::flag_set( "combat_cave_outdoors" );
    thread maps\crash::objective_init();
    level.player _meth_83C0( "crash_overlook" );
    maps\_utility::vision_set_fog_changes( "crash_overlook", 0 );
    level.player _meth_8490( "clut_crash_overlook", 0 );
    setsunflareposition( ( -13.9, -125.7, 0 ) );
    common_scripts\_exploder::exploder( 1999 );
}

debug_start_lake()
{
    maps\crash::set_completed_flags();
    maps\crash_utility::setup_player();
    maps\crash_utility::setup_allies();
    soundscripts\_snd::snd_message( "start_lake" );
    thread exo_temp_overlook_lake();
    thread maps\crash::objective_init();
    level.player _meth_83C0( "crash_avalanche" );
    maps\_utility::vision_set_fog_changes( "crash_avalanche", 0 );
    level.player _meth_8490( "clut_crash_overlook", 2 );
    setsunflareposition( ( -10.39, -112.7, 0 ) );
    common_scripts\_exploder::exploder( 1999 );
}

debug_start_lake_cinema()
{
    maps\crash::set_completed_flags();
    maps\crash_utility::setup_player();
    maps\crash_utility::setup_allies();
    soundscripts\_snd::snd_message( "start_lake_cinema" );
    thread maps\crash_exfil::dead_stinger_guy();
    thread maps\crash_exfil::vtol_takedown_cormack_stinger();
    thread maps\crash::objective_init();
    common_scripts\utility::flag_set( "hide_player_snow_footprints" );
    common_scripts\utility::flag_set( "indoors" );
    thread lake_fall_in( 1 );
    level.visionset_default = "crash_avalanche";
    common_scripts\_exploder::exploder( 1999 );
}

overlook_autosave()
{
    common_scripts\utility::flag_wait( "FLAG_overlook_autosave" );
    thread maps\_utility::autosave_by_name( "entered_overlook" );
    common_scripts\utility::flag_set( "combat_cave_done" );
}

begin_overlook()
{
    thread maps\crash_fx::overlook_smoke_vista();
    thread overlook_kill_player();
    thread overlook_autosave();
    thread overlook_anim();
    thread exo_temp_overlook_lake();
    thread overlook_wind();
    thread overlook_land();
    thread overlook_grab_save();
    thread overlook_force_stand();
    thread overlook_drone();
    setdvar( "scr_traverse_debug", 1 );
    common_scripts\utility::flag_wait( "overlook_done" );
}

overlook_drone()
{
    level endon( "lake_begin_indoors" );
    common_scripts\utility::flag_wait( "FLAG_overlook_traversing" );
    level.cormack.ignoreall = 1;
    level.ilana.ignoreall = 1;
    var_0 = vehicle_scripts\_pdrone::start_flying_attack_drones( "pdrone_small1" );
    wait 2;

    foreach ( var_2 in var_0 )
    {
        var_2.ignoreme = 1;
        var_2.ignoreall = 1;
    }

    var_4 = vehicle_scripts\_pdrone::start_flying_attack_drones( "pdrone_small3" );
    var_5 = vehicle_scripts\_pdrone::start_flying_attack_drones( "pdrone_small2" );
    var_6 = common_scripts\utility::array_combine( var_0, var_4 );
    var_6 = common_scripts\utility::array_combine( var_6, var_5 );

    foreach ( var_2 in var_6 )
    {
        var_2.ignoreme = 1;
        var_2.ignoreall = 1;
        var_2.attack_accuracy = 0.25;
        var_2 _meth_84ED( "enhanceable" );
        var_2 _meth_84ED( "detected" );
    }

    var_6 overlook_start_combat();
}

overlook_start_combat()
{
    wait 2;
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_dronesincoming4" );
    wait 3;
    maps\_utility::smart_radio_dialogue( "crsh_crmk_useemps" );
    level.cormack.ignoreall = 0;
    level.ilana.ignoreall = 0;

    foreach ( var_1 in self )
    {
        if ( isdefined( var_1 ) )
        {
            var_1.ignoreme = 0;
            var_1.ignoreall = 0;
        }
    }
}

exo_temp_overlook_lake()
{
    level endon( "lake_start" );
    level.player thread maps\crash_utility::exo_temp_outdoor();

    for (;;)
    {
        wait 0.05;
        common_scripts\utility::flag_wait_either( "combat_cave_outdoors", "lake_begin_outdoors" );
        common_scripts\utility::flag_clear( "combat_cave_indoors" );
        common_scripts\utility::flag_clear( "lake_begin_indoors" );
        common_scripts\utility::flag_clear( "hide_player_snow_footprints" );
        common_scripts\utility::flag_set( "outdoors" );
        level.player thread maps\crash_exo_temperature::set_external_temperature_over_time( level.temperature_outdoor, 3.0 );
        common_scripts\utility::flag_wait_either( "combat_cave_indoors", "lake_begin_indoors" );
        common_scripts\utility::flag_clear( "combat_cave_outdoors" );
        common_scripts\utility::flag_clear( "lake_begin_outdoors" );
        common_scripts\utility::flag_set( "hide_player_snow_footprints" );
        common_scripts\utility::flag_set( "indoors" );
        level.player thread maps\crash_exo_temperature::set_external_temperature_over_time( level.temperature_indoor, 3.0 );
    }
}

overlook_anim()
{
    common_scripts\utility::flag_wait( "overlook_start_slide" );
    level.slide_dampening = 0.075;
    var_0 = common_scripts\utility::getstruct( "csh_overlook_anim", "targetname" );
    var_1 = [];
    var_1[0] = level.cormack;
    var_1[1] = level.ilana;
    level.ilana maps\_utility::disable_ai_color();
    level.cormack maps\_utility::disable_ai_color();

    if ( !common_scripts\utility::flag( "FLAG_overlook_traversing" ) )
        var_0 maps\_anim::anim_reach_together( var_1, "overlook_intro" );

    common_scripts\_exploder::exploder( 4333 );

    if ( !common_scripts\utility::flag( "FLAG_overlook_traversing" ) )
    {
        level.cormack thread overlook_slide_fx();
        level.ilana thread overlook_slide_fx();
        level.cormack _meth_81A3( 1 );
        level.ilana _meth_81A3( 1 );
        thread overlook_override_anim();
        var_0 maps\_anim::anim_single( var_1, "overlook_intro" );
        level notify( "overlook_intro_done" );
        level.cormack _meth_81A3( 0 );
        level.ilana _meth_81A3( 0 );
    }

    common_scripts\utility::flag_set( "obj_start_overlook_run" );

    if ( !common_scripts\utility::flag( "FLAG_overlook_traversing" ) )
        thread maps\_utility::autosave_by_name( "overlook_anim_over" );

    level.ilana maps\_utility::set_force_color( "g" );
    level.cormack maps\_utility::set_force_color( "r" );
    level.cormack maps\_utility::set_moveplaybackrate( 1 );
    level.ilana maps\_utility::set_moveplaybackrate( 1 );
    thread overlook_dialogue_2();
    common_scripts\utility::flag_set( "overlook_done" );
}

overlook_slide_fx()
{
    self waittillmatch( "single anim", "start_slide" );
    playfxontag( common_scripts\utility::getfx( "ai_slide_snow" ), self, "j_ball_le" );
    self waittillmatch( "single anim", "end_slide" );
    stopfxontag( common_scripts\utility::getfx( "ai_slide_snow" ), self, "j_ball_le" );
}

overlook_override_anim()
{
    level endon( "overlook_intro_done" );
    common_scripts\utility::flag_wait( "obj_end_overlook_run" );
    level.cormack maps\_utility::anim_stopanimscripted();
    level.ilana maps\_utility::anim_stopanimscripted();
}

overlook_dialogue_1()
{
    level endon( "lake_begin_outdoors" );
    level.ilana maps\_utility::smart_dialogue( "crsh_iln_thatsmoke" );
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_howcopy2" );
    maps\_utility::smart_radio_dialogue( "crsh_grdn5_wherethehell" );
    level.cormack maps\_utility::smart_dialogue( "crsh_crmk_weneedtomove" );
}

overlook_dialogue_2()
{
    level endon( "lake_begin_outdoors" );
    wait 3;
    level.cormack maps\_utility::smart_dialogue( "crsh_crmk_footing" );
    level.ilana maps\_utility::smart_dialogue( "crsh_iln_winds" );
    wait 3;
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_locatedbox" );
    maps\_utility::smart_radio_dialogue( "crsh_so_attemptingtorarally" );
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_sayagain" );
    maps\_utility::smart_radio_dialogue( "crsh_so_multiplefootmobiles" );
    level.ilana maps\_utility::smart_dialogue( "crsh_iln_almostthere" );
}

overlook_continue()
{
    maps\_utility::trigger_wait_targetname( "TRIG_move_overlook_1" );
    level.cormack maps\_utility::clear_run_anim();
    level.ilana maps\_utility::clear_run_anim();
}

overlook_kill_player()
{
    common_scripts\utility::flag_wait( "FLAG_overlook_death" );
    setdvar( "ui_deadquote", &"CRASH_FAIL_FALL" );
    maps\_utility::missionfailedwrapper();
    level.player thread maps\_player_exo::player_exo_deactivate();
}

overlook_wind()
{
    common_scripts\utility::flag_wait( "FLAG_overlook_start_dialogue" );
    var_0 = anglestoforward( common_scripts\utility::getstruct( "overlook_wind_struct", "targetname" ).angles );
    thread heavy_wind();

    while ( !common_scripts\utility::flag( "lake_start" ) )
    {
        wait(randomfloatrange( 4.0, 7.0 ));
        soundscripts\_snd::snd_message( "wind_warning", level.player _meth_80A8() );

        if ( common_scripts\utility::flag( "FLAG_overlook_traversing" ) )
            earthquake( 0.1, 5, level.player.origin, 10000 );

        wait(randomfloatrange( 3.0, 5.0 ));
        level.player _meth_80AD( "light_2s" );
        soundscripts\_snd::snd_message( "wind_gust", level.player _meth_80A8() );
        common_scripts\_exploder::exploder( 4555 );
        var_1 = randomfloatrange( 5.0, 10.0 );
        var_2 = randomintrange( 10, 20 );

        for ( var_3 = 0; var_3 < var_2; var_3++ )
        {
            if ( common_scripts\utility::flag( "FLAG_overlook_traversing" ) )
            {
                level.player _meth_83D7( var_0 * ( var_1 + 0.5 * var_3 ), 0 );
                earthquake( 0.15, 0.1, level.player.origin, 1000 );
            }
            else
                level.player _meth_83D7( ( 0, 0, 0 ), 0 );

            wait 0.1;
        }

        for ( var_3 = var_2; var_3 > 0; var_3-- )
        {
            if ( common_scripts\utility::flag( "FLAG_overlook_traversing" ) )
            {
                level.player _meth_83D7( var_0 * ( var_1 + 0.5 * var_3 ), 0 );
                earthquake( 0.15, 0.1, level.player.origin, 1000 );
            }
            else
                level.player _meth_83D7( ( 0, 0, 0 ), 0 );

            wait 0.1;
        }

        level.player _meth_83D7( ( 0, 0, 0 ), 0 );
    }
}

heavy_wind()
{
    for (;;)
    {
        common_scripts\_exploder::exploder( 4555 );
        wait(randomfloatrange( 1.0, 2.0 ));
    }
}

overlook_land()
{
    self endon( "death" );
    level endon( "lake_begin_indoors" );
    common_scripts\utility::flag_wait( "FLAG_overlook_traversing" );

    while ( !common_scripts\utility::flag( "lake_start" ) )
    {
        common_scripts\utility::flag_waitopen( "overlook_save" );
        var_0 = level.player _meth_83B3();

        if ( isdefined( var_0 ) && var_0 )
        {
            var_1 = gettime();
            waitframe();
            var_2 = level.player _meth_8341();

            while ( isdefined( var_2 ) && !var_2 )
            {
                waitframe();
                var_2 = level.player _meth_8341();

                if ( common_scripts\utility::flag( "overlook_save" ) )
                    break;
            }

            if ( common_scripts\utility::flag( "overlook_save" ) )
                continue;

            var_3 = gettime();
            var_4 = var_3 - var_1;
            var_5 = var_4 / 3000;
            var_5 = clamp( var_5, 0, 0.4 );

            if ( var_5 < 0.21 )
            {
                var_6 = 1;
                var_7 = "heavy_1s";
            }
            else if ( var_5 < 0.35 )
            {
                var_6 = 1;
                var_7 = "heavy_2s";
            }
            else
            {
                var_6 = 1.5;
                var_7 = "heavy_3s";
            }

            maps\_utility::_earthquake( var_5, var_6, level.player.origin, 500 );
            level.player _meth_80AD( var_7 );
            playfx( level._effect["snow_impact"], level.player.origin );
            soundscripts\_snd::snd_message( "overlook_land" );
        }

        waitframe();
    }
}

overlook_grab_save()
{
    var_0 = getentarray( "overlook_grab_trigger", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread overlook_grab_save_individual();
}

overlook_grab_save_individual()
{
    var_0 = common_scripts\utility::getstruct( self.target, "targetname" );
    var_1 = common_scripts\utility::getstruct( var_0.target, "targetname" );

    for (;;)
    {
        self waittill( "trigger", var_2 );

        if ( isdefined( var_2 ) && isplayer( var_2 ) && !common_scripts\utility::flag( "overlook_save" ) )
        {
            common_scripts\utility::flag_set( "overlook_save" );
            level.player _meth_817D( "stand" );
            level.player _meth_8119( 0 );
            level.player _meth_811A( 0 );
            level.player _meth_8482();
            level.player _meth_831D();
            level.player _meth_80AD( "heavy_1s" );
            soundscripts\_snd::snd_message( "overlook_fall" );
            waitframe();
            var_3 = maps\_utility::spawn_anim_model( "rig_hands1", level.player.origin, level.player.angles );
            var_3 hide();
            var_1 thread maps\_anim::anim_single_solo( var_3, "fall_grab" );
            var_3 thread play_falling_snow();
            level.player _meth_8080( var_3, "tag_player", 0.15 );
            wait 0.15;
            level.player _meth_807D( var_3, "tag_player", 1, 30, 30, 30, 5, 1 );
            var_3 show();
            var_3 waittillmatch( "single anim", "end" );
            var_1 thread maps\_anim::anim_loop_solo( var_3, "fall_loop" );
            thread should_break_recover_hint_command();
            thread should_break_recover_hint_movement();
            level.player thread maps\_utility::hintdisplayhandler( "player_crash_falloff" );
            level.player waittill( "playerjump" );
            level.player _meth_80AD( "damage_heavy" );
            soundscripts\_snd::snd_message( "overlook_recover" );
            level.player.recover = undefined;
            level.player _meth_807D( var_3, "tag_player", 1, 0, 0, 0, 0, 1 );
            var_1 maps\_anim::anim_single_solo( var_3, "fall_recover" );
            waitframe();
            level.player _meth_80AD( "damage_heavy" );
            level.player _meth_8119( 1 );
            level.player _meth_811A( 1 );
            level.player _meth_8481();
            level.player _meth_831E();
            level.player _meth_804F();
            var_3 delete();
            waitframe();
            common_scripts\utility::flag_clear( "overlook_save" );
        }
    }
}

play_falling_snow()
{
    var_0 = self;
    wait 0.45;
    var_1 = playfxontag( level._effect["snow_grab"], var_0, "ringplate_tr" );
}

overlook_force_stand()
{
    var_0 = getent( "overlook_player_stand", "targetname" );

    for (;;)
    {
        var_0 waittill( "trigger", var_1 );

        if ( var_1 == level.player )
            level.player _meth_817D( "stand" );

        waitframe();
    }
}

overlook_to_lake_teleport()
{
    common_scripts\utility::flag_wait( "overlook_done" );
    var_0 = common_scripts\utility::getstruct( "lake_player_teleport_pre", "targetname" );
    var_1 = common_scripts\utility::getstruct( "lake_player_teleport", "targetname" );
    var_2 = maps\_utility::spawn_anim_model( "rig_hands1" );
    var_2 hide();
    var_0 maps\_anim::anim_first_frame_solo( var_2, "control_fall" );
    var_3 = maps\_utility::spawn_anim_model( "rig_hands1" );
    var_1 maps\_anim::anim_first_frame_solo( var_3, "control_fall" );
    common_scripts\utility::flag_wait( "lake_begin_indoors" );
    common_scripts\utility::flag_set( "obj_lake_enter" );
    level.player _meth_8482();
    level.player _meth_831D();
    soundscripts\_snd::snd_message( "enter_lake_cave" );
    level.player _meth_8080( var_2, "tag_player", 0.35 );
    level.player _meth_817D( "stand" );
    level.player _meth_8119( 0 );
    level.player _meth_811A( 0 );
    wait 0.3;
    var_0 thread maps\_anim::anim_single_solo( var_2, "control_fall" );
    var_1 thread maps\_anim::anim_single_solo( var_3, "control_fall" );
    var_2 show();
    wait 0.7;
    level.player maps\_hud_util::fade_out( 0.05, "black" );
    waitframe();
    level.player _meth_807F( var_3, "tag_player" );
    thread handle_teleport( var_1 );
    level.player _meth_80AD( "heavy_1s" );
    var_3 waittillmatch( "single anim", "end" );
    var_2 delete();
    var_3 delete();
    level.player _meth_804F();
    level.player _meth_8119( 1 );
    level.player _meth_811A( 1 );
    level.player _meth_8481();
    level.player _meth_831E();
}

handle_teleport( var_0 )
{
    waitframe();
    var_1 = common_scripts\utility::getstruct( "lake_cormack", "targetname" );
    var_2 = common_scripts\utility::getstruct( "lake_ilana", "targetname" );
    level.cormack maps\_utility::disable_ai_color();
    level.ilana maps\_utility::disable_ai_color();
    level.cormack _meth_81C6( var_1.origin, var_1.angles );
    level.ilana _meth_81C6( var_2.origin, var_2.angles );
    waitframe();
    level.player maps\_hud_util::fade_in( 0.05, "black" );
    level.cormack _meth_8092();
    level.ilana _meth_8092();
    level.cormack.goalradius = 0;
    level.ilana.goalradius = 0;
    waitframe();
    level.cormack maps\_utility::enable_ai_color();
    level.ilana maps\_utility::enable_ai_color();
}

begin_lake()
{
    overlook_to_lake_teleport();
    common_scripts\utility::flag_wait( "lake_start" );
    level notify( "moved_indoors" );
    level.player thread maps\crash_exo_temperature::set_external_temperature_over_time( level.temperature_indoor, 3.0 );
    level.underwater_visionset_callback = ::ic_underwater_visionset_change;
    var_0 = _func_0D6( "axis" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && isalive( var_2 ) )
        {
            if ( isdefined( var_2.magic_bullet_shield ) && var_2.magic_bullet_shield )
                var_2 maps\_utility::stop_magic_bullet_shield();

            var_2 delete();
        }
    }

    thread lake_autosave();
    thread lake_dialogue();
    thread lake_upper_deck();
    thread maps\crash_exfil::vtol_takedown_cormack_stinger();
    thread friendly_bias();
    level.player thread sniper_rifle_objective_logic();
    level.player thread play_railgun_fx();

    if ( level.currentgen )
    {
        var_4 = [ "ice_attack_wave_1_noDelete" ];
        thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor( "", undefined, 15, 0, var_4 );
    }

    thread ice_lake_chopper();
    thread ice_lake_wave_0();
    thread ice_lake_wave_1();
    thread ice_lake_wave_2();
    thread ice_lake_wave_3();
    thread maps\crash_exfil::dead_stinger_guy();
    common_scripts\utility::flag_wait( "chopper_found" );
    soundscripts\_snd::snd_message( "lake_events" );
    common_scripts\utility::flag_set( "obj_end_locate_chopper" );
    thread lake_fall_in();
    common_scripts\utility::flag_wait( "lake_done" );
}

lake_autosave()
{
    common_scripts\utility::flag_wait( "FLAG_lake_start_save" );
    thread maps\_utility::autosave_by_name( "entered_lake_area" );
}

lake_drown()
{
    common_scripts\utility::flag_wait( "lake_drown" );
    setdvar( "ui_deadquote", &"CRASH_FAIL_DROWN" );
    maps\_utility::missionfailedwrapper();
}

sniper_rifle_objective_logic()
{
    for (;;)
    {
        var_0 = self _meth_830C();

        foreach ( var_2 in var_0 )
        {
            if ( var_2 == "s1_railgun" )
            {
                self _meth_830F( "s1_railgun" );
                self _meth_830E( "s1_railgun+morsscope" );
                self _meth_8315( "s1_railgun+morsscope" );
                break;
            }
        }

        wait 0.05;
    }
}

friendly_bias()
{
    createthreatbiasgroup( "squad" );
    createthreatbiasgroup( "pilots" );
    createthreatbiasgroup( "enemies" );
    level.ilana _meth_8177( "squad" );
    level.cormack _meth_8177( "squad" );
    setthreatbias( "enemies", "squad", -900 );
    setthreatbias( "enemies", "pilots", 90000000 );
    common_scripts\utility::flag_wait( "start_shooting_at_squad" );
    maps\_utility::clearthreatbias( "enemies", "squad" );
    maps\_utility::clearthreatbias( "enemies", "pilots" );
}

lake_upper_deck()
{
    var_0 = level.cormack.accuracy;
    var_1 = level.cormack.baseaccuracy;
    level.player.ignoreme = 1;
    level.ilana.ignoreall = 1;
    level.cormack.ignoreall = 1;
    level.cormack.accuracy = 100000;
    level.cormack.baseaccuracy = 10000;
    level.ilana.accuracy = 100000;
    level.ilana.baseaccuracy = 10000;
    common_scripts\utility::flag_wait( "ice_lake_start_combat" );
    wait 2;
    common_scripts\utility::flag_set( "obj_start_recover_cargo" );
    level.ilana.ignoreme = 0;
    level.ilana.ignoreall = 0;
    level.ilana.accuracy = var_0;
    level.ilana.baseaccuracy = var_1;
    level.cormack.baseaccuracy = var_1;
    level.cormack.ignoreme = 0;
    level.cormack.ignoreall = 0;
    level.cormack.accuracy = var_0;
    common_scripts\utility::flag_wait( "ice_lake_new_move_up" );
    level.player.ignoreme = 0;
}

ice_lake_wave_0()
{
    thread ice_lake_wave_0_crate();
    thread ice_lake_wave_0_amb();
    thread ice_lake_wave_0_patrol();
}

ice_lake_wave_0_crate()
{
    var_0 = undefined;

    if ( level.nextgen )
        var_0 = maps\_utility::array_spawn_targetname( "ice_attack_initial_crate", 1 );
    else
        var_0 = maps\_utility::array_spawn_targetname_cg( "ice_attack_initial_crate", 1, 0.1 );

    var_1 = getent( "NODE_lake_scene_vtol", "targetname" );

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        if ( isdefined( var_0[var_2] ) && isalive( var_0[var_2] ) )
        {
            var_0[var_2].ignoreall = 0;
            var_0[var_2].animname = "enemy" + ( var_2 + 1 );
        }
    }

    if ( isdefined( var_0[0] ) && isalive( var_0[0] ) )
        var_1 thread maps\_anim::anim_loop_solo( var_0[0], "lake_idle", "crate_stop" );

    if ( isdefined( var_0[1] ) && isalive( var_0[1] ) )
        var_1 thread maps\_anim::anim_loop_solo( var_0[1], "lake_idle", "crate_stop" );

    common_scripts\utility::flag_wait( "ice_lake_start_scene" );

    foreach ( var_4 in var_0 )
    {
        if ( isdefined( var_4 ) && isalive( var_4 ) )
        {
            var_4 thread ice_lake_wakeup();
            var_4 thread ice_lake_kill();
        }
    }

    common_scripts\utility::flag_wait_or_timeout( "ice_lake_start_combat", 20 );
    common_scripts\utility::flag_wait( "ice_lake_start_combat" );
    level.ilana.ignoreall = 0;

    if ( !common_scripts\utility::flag( "ice_lake_start_combat" ) )
    {
        wait 1;
        common_scripts\utility::flag_set( "ice_lake_start_combat" );
    }

    var_1 notify( "crate_stop" );

    if ( isdefined( var_0[0] ) && isalive( var_0[0] ) )
        var_1 thread maps\_anim::anim_single_solo( var_0[0], "lake_idle_run" );

    if ( isdefined( var_0[1] ) && isalive( var_0[1] ) )
        var_1 thread maps\_anim::anim_single_solo( var_0[1], "lake_idle_run" );
}

ice_lake_wave_0_amb()
{
    var_0 = undefined;

    if ( level.nextgen )
        var_0 = maps\_utility::array_spawn_targetname( "ice_attack_initial", 1 );
    else
        var_0 = maps\_utility::array_spawn_targetname_cg( "ice_attack_initial", 1, 0.1 );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( isdefined( var_0[var_1] ) && isalive( var_0[var_1] ) )
        {
            var_0[var_1].ignoreall = 0;
            var_0[var_1].animname = "lakeguy";
            var_0[var_1].animation = "lake_ambience" + var_1;
            var_0[var_1].reactionanim = "lake_sniped" + var_1;
            var_0[var_1].canjumppath = 5;
            var_2 = getent( "NODE_lake_scene_vtol", "targetname" );
            var_2 thread maps\_anim::anim_loop_solo( var_0[var_1], var_0[var_1].animation, "crate_stop" );
        }
    }

    common_scripts\utility::flag_wait( "ice_lake_start_scene" );

    foreach ( var_4 in var_0 )
    {
        if ( isdefined( var_4 ) && isalive( var_4 ) )
        {
            var_4 thread ice_lake_wakeup_noreaction();
            var_4 thread ice_lake_kill();
        }
    }
}

ice_lake_wave_0_patrol()
{
    var_0 = undefined;

    if ( level.nextgen )
        var_0 = maps\_utility::array_spawn_targetname( "ice_lake_patrol", 1 );
    else
        var_0 = maps\_utility::array_spawn_targetname_cg( "ice_lake_patrol", 1, 0.1 );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( isdefined( var_0[var_1] ) && isalive( var_0[var_1] ) )
        {
            var_0[var_1].ignoreall = 1;
            var_0[var_1].ignoresuppression = 1;
            var_0[var_1].goalradius = 32;
            var_0[var_1].animname = "generic";
            var_0[var_1].canjumppath = 5;
            var_0[var_1].reactionanim = "lake_sniped" + var_1;
            maps\_utility::set_generic_idle_anim( "casual_walk_idle" );
            var_0[var_1].customarrivalfunc = ::custom_idle_trans_function;
            var_0[var_1].startidletransitionanim = level.scr_anim["generic"]["casual_walk_in"];
            self.permanentcustommovetransition = 1;
            self.custommovetransition = animscripts\cover_arrival::custommovetransitionfunc;
            self.startmovetransitionanim = level.scr_anim["generic"]["casual_walk_out"];
            var_0[var_1] thread maps\_utility::set_run_anim( "casual_walk" );
            var_0[var_1] thread maps\_utility::follow_path( getnode( var_0[var_1].target, "targetname" ) );
        }
    }

    common_scripts\utility::flag_wait( "ice_lake_start_scene" );

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3 ) && isalive( var_3 ) )
        {
            var_3 thread ice_lake_wakeup_reaction();
            var_3 thread ice_lake_kill();
        }
    }
}

#using_animtree("generic_human");

custom_idle_trans_function()
{
    if ( !isdefined( self.startidletransitionanim ) )
        return;

    var_0 = self.approachnumber;
    var_1 = self.startidletransitionanim;

    if ( !isdefined( self.heat ) )
        thread animscripts\cover_arrival::abortapproachifthreatened();

    self _meth_8142( %body, 0.2 );
    self _meth_8113( "coverArrival", var_1, 1, 0.2, self.movetransitionrate );
    animscripts\face::playfacialanim( var_1, "run" );
    animscripts\shared::donotetracks( "coverArrival", animscripts\cover_arrival::handlestartaim );
    var_2 = anim.arrivalendstance[self.approachtype];

    if ( isdefined( var_2 ) )
        self.a.pose = var_2;

    self.a.movement = "stop";
    self.a.arrivaltype = self.approachtype;
    self _meth_8142( %root, 0.3 );
    self.lastapproachaborttime = undefined;
    var_3 = self.origin - self.goalpos;
}

clear_custom_patrol_anim_set()
{
    maps\_utility::clear_generic_run_anim();
    maps\_utility::clear_generic_idle_anim();
    self.permanentcustommovetransition = undefined;
    self.custommovetransition = undefined;
    self.startmovetransitionanim = undefined;
    self.customarrivalfunc = undefined;
    self.startidletransitionanim = undefined;
    self _meth_81CA( "stand", "crouch", "prone" );

    if ( isdefined( self.oldcombatmode ) )
        self.combatmode = self.oldcombatmode;
}

ice_lake_wakeup()
{
    self endon( "death" );
    self _meth_8041( "grenade danger" );
    self _meth_8041( "silenced_shot" );
    self _meth_8041( "gunshot" );
    self _meth_8041( "explode" );
    self waittill( "ai_event", var_0 );
    common_scripts\utility::flag_set( "ice_lake_start_combat" );
    self.ignoreall = 0;
}

ice_lake_wakeup_noreaction()
{
    self endon( "death" );
    thread ice_lake_wakeup_play_reaction();
    self _meth_8041( "grenade danger" );
    self _meth_8041( "projectile_impact" );
    self _meth_8041( "silenced_shot" );
    self _meth_8041( "bulletwhizby" );
    self _meth_8041( "gunshot" );
    self _meth_8041( "gunshot_teammate" );
    self _meth_8041( "explode" );
    self waittill( "ai_event", var_0 );
    common_scripts\utility::flag_set( "ice_lake_start_combat" );
}

ice_lake_wakeup_reaction()
{
    self endon( "death" );
    self _meth_8041( "grenade danger" );
    self _meth_8041( "projectile_impact" );
    self _meth_8041( "silenced_shot" );
    self _meth_8041( "bulletwhizby" );
    self _meth_8041( "gunshot" );
    self _meth_8041( "gunshot_teammate" );
    self _meth_8041( "explode" );
    self waittill( "ai_event", var_0 );
    common_scripts\utility::flag_set( "ice_lake_start_combat" );
    self.ignoreall = 0;
    clear_custom_patrol_anim_set();
    maps\_utility::clear_run_anim();
    self notify( "_utility::follow_path" );
    waitframe();
    thread maps\_anim::anim_single_solo( self, self.reactionanim );
    thread lake_handle_vol_movement();
}

ice_lake_wakeup_play_reaction()
{
    self endon( "death" );
    var_0 = getent( "NODE_lake_scene_vtol", "targetname" );
    common_scripts\utility::flag_wait( "ice_lake_start_combat" );
    self.ignoreall = 0;
    maps\_utility::anim_stopanimscripted();
    waitframe();
    var_0 thread maps\_anim::anim_single_solo( self, self.reactionanim );
}

ice_lake_kill()
{
    self endon( "death" );
    self waittill( "damage" );
    common_scripts\utility::flag_set( "ice_lake_start_combat" );
    maps\_utility::anim_stopanimscripted();
    self _meth_8052();
}

ice_lake_wave_1()
{
    level endon( "ice_lake_new_move_up" );
    common_scripts\utility::flag_wait( "ice_lake_start_combat" );
    level endon( "player_advanced_ahead" );
    wait 5;
    var_0 = getent( "VOL_ice_lake_wave_1", "targetname" );
    var_1 = undefined;

    if ( level.nextgen )
        var_1 = maps\_utility::array_spawn_targetname( "ice_attack_wave_1", 1 );
    else
        var_1 = maps\_utility::array_spawn_targetname_cg( "ice_attack_wave_1", 1, 0.1 );

    var_2 = zippers_spawner( "ice_attack_wave_1_zipline" );
    var_3 = undefined;

    if ( level.nextgen )
        var_3 = maps\_utility::array_spawn_targetname( "ice_attack_wave_1_cover", 1 );
    else
        var_3 = maps\_utility::array_spawn_targetname_cg( "ice_attack_wave_1_cover", 1, 0.1 );

    var_4 = common_scripts\utility::array_combine( var_1, var_2 );
    var_4 = common_scripts\utility::array_combine( var_4, var_3 );

    foreach ( var_6 in var_4 )
    {
        if ( isdefined( var_6 ) && isalive( var_6 ) )
        {
            var_6.script_noteworthy = "ice_attack_wave_1";
            var_6.ignoresuppression = 1;
            var_6.canjumppath = 5;
            var_6 _meth_8177( "enemies" );
            var_6 thread lake_handle_vol_movement();
        }
    }

    foreach ( var_9 in var_3 )
    {
        if ( isdefined( var_9 ) && isalive( var_9 ) )
        {
            var_9.goalradius = 0;
            var_9 thread maps\_deployablecoverai::handle_deployable_cover( "lake_deployablecover" );
            var_9 thread handle_volume_assign();
            wait 1;
        }
    }

    var_4 = maps\_utility::remove_dead_from_array( var_4 );
    maps\_utility::waittill_dead_or_dying( var_4, 2 );
    var_11 = maps\crash_utility::spawn_wave_stagger( "ice_attack_wave_support", 1, var_0 );
    var_12 = undefined;

    if ( level.nextgen )
        var_12 = maps\_utility::array_spawn_targetname( "ice_attack_wave_support_cover", 1 );
    else
        var_12 = maps\_utility::array_spawn_targetname_cg( "ice_attack_wave_support_cover", 1, 0.1 );

    var_13 = common_scripts\utility::array_combine( var_11, var_12 );
    var_14 = getent( "VOL_ice_lake_wave_3", "targetname" );

    foreach ( var_6 in var_13 )
    {
        if ( isdefined( var_6 ) && isalive( var_6 ) )
        {
            var_6.script_noteworthy = "ice_attack_wave_1_back";
            var_6.ignoresuppression = 1;
            var_6.canjumppath = 5;
            var_6 _meth_8177( "enemies" );
            var_6 thread lake_handle_vol_movement();
        }
    }

    foreach ( var_9 in var_12 )
    {
        if ( isdefined( var_9 ) && isalive( var_9 ) )
        {
            var_9.goalradius = 0;
            var_9 thread maps\_deployablecoverai::handle_deployable_cover( "lake_deployablecover" );
            var_9 thread handle_volume_assign();
            wait 1;
        }
    }

    thread wave_1_logic();
    var_19 = common_scripts\utility::array_combine( var_4, var_13 );
    var_19 = maps\_utility::array_removedead( var_19 );
    maps\_utility::waittill_dead_or_dying( var_19, 5 );
    maps\_utility::activate_trigger( "ice_lake_cormack_moveup1", "targetname" );
    common_scripts\utility::flag_wait( "obj_start_recover_cargo" );
    common_scripts\utility::flag_set( "ice_lake_wave_1_done" );
}

handle_volume_assign()
{
    self waittill( "deployable_finished" );
    thread lake_handle_vol_movement();
}

zippers_spawner( var_0 )
{
    var_1 = getentarray( var_0, "targetname" );
    var_2 = [];
    wait 0.5;

    foreach ( var_4 in var_1 )
    {
        var_5 = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( var_4, common_scripts\utility::getstruct( var_4.target, "targetname" ) );
        var_2[var_2.size] = var_5;
        var_5.ignoresuppression = 1;
        var_5.canjumppath = 5;
        var_5 _meth_8177( "enemies" );
        var_5 thread lake_handle_vol_movement();
        wait(randomfloatrange( 0.1, 0.25 ));
    }

    return var_2;
}

wave_1_logic()
{
    level endon( "ice_lake_new_move_up" );
    var_0 = getent( "VOL_ice_lake_wave_1", "targetname" );
    var_1 = 1;

    while ( var_1 )
    {
        var_2 = maps\_utility::get_living_ai_array( "ice_attack_wave_1", "script_noteworthy" );
        var_3 = maps\_utility::get_living_ai_array( "ice_attack_wave_1_back", "script_noteworthy" );

        if ( var_3.size == 0 )
            var_1 = 0;

        if ( var_2.size < var_3.size )
        {
            if ( isalive( var_3[0] ) )
                var_3[0].script_noteworthy = "ice_attack_wave_1";
        }

        wait 2;
    }
}

ice_lake_wave_2()
{
    level endon( "ice_lake_new_move_up" );
    common_scripts\utility::flag_wait( "ice_lake_wave_1_done" );
    var_0 = getent( "VOL_ice_lake_wave_2", "targetname" );
    var_1 = maps\crash_utility::spawn_wave_stagger( "ice_attack_wave_support", 1, var_0 );
    createthreatbiasgroup( "enemies_2" );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3 ) && isalive( var_3 ) )
        {
            var_3.script_noteworthy = "ice_attack_wave_2";
            var_3.ignoresuppression = 1;
            var_3.canjumppath = 5;
            var_3 _meth_8177( "enemies_2" );
            var_3 thread lake_handle_vol_movement();
        }
    }

    createthreatbiasgroup( "player" );
    level.player _meth_8177( "player" );
    setthreatbias( "enemies_2", "player", -9000 );
    thread ice_lake_clear();
    maps\_utility::waittill_dead_or_dying( var_1, 3 );
    common_scripts\utility::flag_wait( "ice_lake_new_move_up" );
    common_scripts\utility::flag_set( "ice_lake_wave_2_done" );
}

ice_lake_clear()
{
    level endon( "ice_lake_new_move_up" );
    var_0 = _func_0D6( "axis" );
    maps\_utility::waittill_dead_or_dying( var_0, var_0.size - 5 );
    var_0 = _func_0D6( "axis" );
    var_1 = getent( "VOL_ice_lake_wave_cargo", "targetname" );

    foreach ( var_3 in var_0 )
    {
        var_3 _meth_81A9( var_1 );
        randomfloatrange( 0.2, 0.5 );
    }

    level.cormack thread maps\_utility::smart_radio_dialogue( "crsh_crmk_jumpdown3" );
    var_0 = _func_0D6( "axis" );
    maps\_utility::waittill_dead_or_dying( var_0, var_0.size );
    common_scripts\utility::flag_clear( "ice_lake_callout_pause" );
    maps\_utility::smart_radio_dialogue( "crsh_iln_targetdown2" );
    maps\_utility::activate_trigger( "ice_lake_cormack_moveup1", "targetname" );
    maps\_utility::disable_trigger_with_targetname( "ice_lake_cormack_moveup1" );
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_getdownhere" );
    var_5 = maps\_utility::make_array( "crsh_crmk_needtoadvance", "crsh_crmk_getdownhere" );
    thread maps\crash_utility::nag_until_flag( var_5, "ice_lake_start_timer", 2, 3, 10 );
    common_scripts\utility::flag_wait( "ice_lake_start_timer" );
    maps\_utility::activate_trigger( "ice_lake_moveup1", "targetname" );
    cormack_lake_callout_coverme();
    var_5 = maps\_utility::make_array( "crsh_crmk_needtogetthatcargo", "crsh_crmk_securecargo", "crsh_iln_securecargo2" );
    thread maps\crash_utility::nag_until_flag( var_5, "ice_lake_new_move_up", 2, 3, 10 );
}

lake_reinforcements_1()
{
    level endon( "ice_lake_new_move_up" );

    for (;;)
    {
        var_0 = maps\_utility::get_living_ai_array( "ice_attack_wave_1", "script_noteworthy" );

        if ( var_0.size < 3 )
        {
            var_1 = undefined;

            if ( level.nextgen )
                var_1 = maps\_utility::array_spawn_targetname( "ice_attack_support_1", 1 );
            else
                var_1 = maps\_utility::array_spawn_targetname_cg( "ice_attack_support_1", 1, 0.1 );

            foreach ( var_3 in var_1 )
            {
                if ( isdefined( var_3 ) && isalive( var_3 ) )
                {
                    var_3.ignoresuppression = 1;
                    var_3.script_noteworthy = "ice_attack_wave_1";
                }
            }

            wait 4;
        }

        wait 0.05;
    }
}

lake_reinforcements_2()
{
    level endon( "ice_lake_new_move_up" );

    for (;;)
    {
        var_0 = maps\_utility::get_living_ai_array( "ice_attack_wave_2", "script_noteworthy" );

        if ( var_0.size < 2 )
        {
            var_1 = undefined;

            if ( level.nextgen )
                var_1 = maps\_utility::array_spawn_targetname( "ice_attack_support_2", 1 );
            else
                var_1 = maps\_utility::array_spawn_targetname_cg( "ice_attack_support_2", 1, 0.1 );

            foreach ( var_3 in var_1 )
            {
                if ( isdefined( var_3 ) && isalive( var_3 ) )
                {
                    var_3.ignoresuppression = 1;
                    var_3.script_noteworthy = "ice_attack_wave_2";
                }
            }

            wait 4;
        }

        wait 0.05;
    }
}

ice_lake_wave_3()
{
    level endon( "lake_start_collapse" );
    common_scripts\utility::flag_wait_either( "ice_lake_wave_2_done", "ice_lake_new_move_up" );
    common_scripts\utility::flag_set( "cargo_captured" );
    common_scripts\utility::flag_set( "obj_end_lake_sniper_rifle" );
    var_0 = getent( "VOL_ice_lake_wave_3a", "targetname" );
    var_1 = zippers_spawner( "ice_attack_wave_2_zipline" );
    wait 3;
    var_2 = undefined;

    if ( level.nextgen )
        var_3 = maps\_utility::array_spawn_targetname( "ice_attack_final", 1 );
    else
        var_3 = maps\_utility::array_spawn_targetname_cg( "ice_attack_final", 1, 0.1 );

    foreach ( var_5 in var_3 )
    {
        if ( isdefined( var_5 ) && isalive( var_5 ) )
        {
            var_5.ignoresuppression = 1;
            var_5.script_noteworthy = "ice_attack";
            var_5.canjumppath = 5;
            var_5 thread lake_handle_vol_movement();
        }
    }

    wait 5;
    var_7 = undefined;

    if ( level.nextgen )
        var_7 = maps\_utility::array_spawn_targetname( "ice_attack_final_back", 1 );
    else
        var_7 = maps\_utility::array_spawn_targetname( "ice_attack_final_back", 1, 0.1 );

    foreach ( var_5 in var_7 )
    {
        if ( isdefined( var_5 ) && isalive( var_5 ) )
        {
            var_5.ignoresuppression = 1;
            var_5.script_noteworthy = "ice_attack";
            var_5.canjumppath = 5;
            var_5 thread lake_handle_vol_movement();
        }
    }

    var_2 = _func_0D6( "axis" );
    maps\_utility::waittill_dead_or_dying( var_2, var_2.size - 5 );
    var_0 = getent( "VOL_ice_lake_wave_cargo", "targetname" );
    var_2 = maps\_utility::remove_dead_from_array( var_2 );

    foreach ( var_11 in var_2 )
    {
        var_11 _meth_81A9( var_0 );
        randomfloatrange( 0.2, 0.5 );
    }

    level.ilana maps\_utility::smart_radio_dialogue( "crsh_iln_securecargo2" );
    var_2 = _func_0D6( "axis" );
    maps\_utility::waittill_dead_or_dying( var_2, var_2.size );
    common_scripts\utility::flag_clear( "ice_lake_callout_pause" );
    maps\_utility::smart_radio_dialogue( "crsh_iln_allclear3" );
    common_scripts\utility::flag_set( "ice_lake_wave_3_done" );
}

lake_reinforcements_final()
{
    level endon( "lake_start_left" );
    var_0 = getent( "VOL_ice_lake_wave_3", "targetname" );
    wait 10;

    for (;;)
    {
        var_1 = maps\_utility::get_living_ai_array( "ice_attack", "script_noteworthy" );

        if ( var_1.size < 4 )
        {
            var_2 = undefined;

            if ( level.nextgen )
                var_2 = maps\_utility::array_spawn_targetname( "ice_attack_wave_support", 1 );
            else
                var_2 = maps\_utility::array_spawn_targetname_cg( "ice_attack_wave_support", 1, 0.1 );

            foreach ( var_4 in var_2 )
            {
                if ( isdefined( var_4 ) && isalive( var_4 ) )
                {
                    var_4.ignoresuppression = 1;
                    var_4.script_noteworthy = "ice_attack";
                    var_4 _meth_81A9( var_0 );
                }
            }

            wait 4;
        }

        wait 0.05;
    }
}

lake_handle_vol_movement()
{
    if ( isdefined( self.target ) )
    {
        var_0 = strtok( self.target, "VOL_ice_lake_wave_3" );

        if ( isdefined( var_0 ) && isdefined( var_0[0] ) )
        {
            if ( var_0[0] == "1" || var_0[0] == "2" || var_0[0] == "3" )
                thread lake_vol_movement();
        }
    }
}

lake_vol_movement()
{
    self endon( "death" );
    var_0 = getent( "VOL_ice_lake_wave_3a", "targetname" );
    var_1 = getent( "VOL_ice_lake_wave_3b", "targetname" );
    var_2 = getent( "VOL_ice_lake_wave_3c", "targetname" );

    for (;;)
    {
        wait 10;
        var_3 = randomintrange( 0, 3 );

        if ( var_3 == 0 )
        {
            self _meth_81A9( var_0 );
            continue;
        }

        if ( var_3 == 1 )
        {
            self _meth_81A9( var_1 );
            continue;
        }

        self _meth_81A9( var_2 );
    }
}

lake_fall_in( var_0 )
{
    common_scripts\utility::flag_wait( "lake_start_left" );

    if ( !isdefined( var_0 ) )
    {
        thread maps\_utility::autosave_now_silent();
        level.player _meth_80EF();
        level.player maps\_player_high_jump::disable_high_jump();
        level.player _meth_8485( 0 );
        level.player _meth_848D( 0 );
        level.player maps\crash_utility::disable_exo_melee();
        level.cormack thread maps\_utility::smart_radio_dialogue( "crsh_crmk_missilesfired" );
        var_1 = 400;
        var_2 = 150;
        var_3 = level.lake_chopper.origin - ( 0, 0, 32 );
        level.lake_chopper.old_contents = level.lake_chopper setcontents( 0 );
        var_4 = level.player common_scripts\utility::spawn_tag_origin();
        var_5 = level.player.origin;
        var_6 = level.player getangles();
        var_7 = var_6[1];
        var_4.origin = ( var_2 * cos( var_7 ) + var_5[0], var_2 * sin( var_7 ) + var_5[1], var_5[2] );
        var_8 = common_scripts\utility::getstruct( "csh_lake_repulsor", "targetname" );
        var_9 = common_scripts\utility::getstruct( "csh_lake_repulsor2", "targetname" );
        var_10 = missile_createrepulsororigin( var_8.origin, 10000, 500 );
        var_11 = missile_createrepulsororigin( var_9.origin, 100000, 75 );
        var_12 = missile_createattractororigin( common_scripts\utility::drop_to_ground( var_4.origin - ( 0, 0, 100 ) ), 20000, 1000 );
        waitframe();
        var_13 = level.lake_chopper gettagorigin( "jnt_launcherbracket_l" );
        var_14 = level.lake_chopper gettagorigin( "jnt_launcherbracket_r" );
        var_15 = magicbullet( "iw5_mahemstraight_sp", var_13, var_4.origin );
        var_16 = magicbullet( "iw5_mahemstraight_sp", var_14, var_4.origin );
        thread vtol_fire_late_rpgs( var_4 );
        soundscripts\_snd::snd_message( "missile_fire", var_15, var_16, var_4.origin );
        wait 0.1;
        var_16 common_scripts\utility::waittill_notify_or_timeout( "death", 2 );
        soundscripts\_snd::snd_message( "lake_fall_in" );
        level notify( "player_fell_in_lake" );
        level.player maps\_player_high_jump::enable_high_jump();
        level.player _meth_8485( 1 );
        level.player _meth_848D( 1 );
    }

    common_scripts\utility::flag_set( "lake_done" );
    wait 0.25;
    common_scripts\utility::flag_set( "go_gideon_moment" );
    common_scripts\utility::flag_set( "obj_lake_fall" );
    wait 2;
    var_17 = _func_0D6( "axis" );

    foreach ( var_19 in var_17 )
    {
        if ( isdefined( var_19 ) && isalive( var_19 ) )
        {
            if ( isdefined( var_19.magic_bullet_shield ) && var_19.magic_bullet_shield )
                var_19 maps\_utility::stop_magic_bullet_shield();

            var_19.dontdropweapon = 1;
            var_19 delete();
        }
    }

    maps\crash_utility::cleanup_enemies( "ice_attack", 1 );
    maps\crash_utility::cleanup_enemies( "ice_attack_wave_1_back", 1 );

    if ( level.currentgen )
        maps\crash_utility::cleanup_enemies( "ice_attack_wave_1_noDelete", 1 );

    maps\crash_utility::cleanup_enemies( "ice_attack_wave_1", 1 );
    maps\crash_utility::cleanup_enemies( "ice_attack_wave_2", 1 );
    maps\crash_utility::cleanup_enemies( "ice_attack_goliath", 1 );
    maps\crash_utility::cleanup_enemies( "ice_attack_bonus", 1 );
    clearallcorpses();
    maps\crash_utility::cleanupweaponsonground();
}

vtol_fire_late_rpgs( var_0 )
{
    wait 0.75;
    var_1 = level.lake_chopper gettagorigin( "jnt_launcherbracket_l" );
    var_2 = level.lake_chopper gettagorigin( "jnt_launcherbracket_r" );
    var_3 = level.player.origin;
    var_4 = level.player getangles();
    var_5 = var_4[1];
    var_6 = 150;
    var_0.origin = ( var_6 * cos( var_5 ) + var_3[0], var_6 * sin( var_5 ) + var_3[1], var_3[2] );
    magicbullet( "iw5_mahemstraight_sp", var_1, var_0.origin - ( 0, 0, 100 ) );
    magicbullet( "iw5_mahemstraight_sp", var_2, var_0.origin - ( 0, 0, 100 ) );
    wait 0.75;
    var_1 = level.lake_chopper gettagorigin( "jnt_launcherbracket_l" );
    var_2 = level.lake_chopper gettagorigin( "jnt_launcherbracket_r" );
    var_3 = level.player.origin;
    var_4 = level.player getangles();
    var_5 = var_4[1];
    var_6 = 150;
    var_0.origin = ( var_6 * cos( var_5 ) + var_3[0], var_6 * sin( var_5 ) + var_3[1], var_3[2] );
    magicbullet( "iw5_mahemstraight_sp", var_1, var_0.origin - ( 0, 0, 200 ) );
    magicbullet( "iw5_mahemstraight_sp", var_2, var_0.origin - ( 0, 0, 200 ) );
    wait 2;
    level.player _meth_80F0();
}

ice_lake_chopper()
{
    var_0 = getent( "NODE_lake_scene_vtol", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "vtol" );
    level.lake_chopper = var_1;
    var_2 = maps\_utility::spawn_anim_model( "pulley" );
    var_2 _meth_82BF();
    var_3 = maps\_utility::spawn_anim_model( "crate" );
    var_3 _meth_82BF();
    level.cargo = var_3;
    var_0 thread maps\_anim::anim_loop_solo( var_3, "lake_loop", "stop_wait_loop" );
    var_0 thread handle_cargo_shut( var_3 );
    common_scripts\utility::flag_wait( "ice_lake_start_timer" );
    thread lake_scene_fail_timeout();
    common_scripts\utility::flag_wait_any( "lake_lift_off", "lake_player_fail" );
    soundscripts\_snd::snd_message( "lake_warbird_approaches" );
    var_4 = undefined;

    if ( level.nextgen )
        var_4 = maps\_utility::array_spawn_targetname( "ice_attack_hookup_crate", 1 );
    else
        var_4 = maps\_utility::array_spawn_targetname( "ice_attack_hookup_crate", 1, 0.1 );

    for ( var_5 = 0; var_5 < var_4.size; var_5++ )
    {
        if ( isdefined( var_4[var_5] ) && isalive( var_4[var_5] ) )
        {
            var_4[var_5].ignoreall = 0;
            var_4[var_5].animname = "enemy" + ( var_5 + 1 );
            var_4[var_5] thread ice_lake_kill();
            var_0 thread maps\_anim::anim_single_solo( var_4[var_5], "lake_hookup" );
        }
    }

    var_6 = [ var_1, var_2 ];
    var_0 maps\_anim::anim_single( var_6, "lake_hookup" );
    var_6 = [ var_1, var_2, var_3 ];
    var_0 thread maps\_anim::anim_loop( var_6, "lake_loop", "stop_wait_loop" );
    maps\_utility::activate_trigger( "ice_lake_moveup1", "targetname" );
    var_0 notify( "stop_wait_loop" );
    var_0 thread maps\_anim::anim_loop_solo( var_3, "lake_hookup_loop", "stop_wait_loop" );
    var_0 thread maps\_anim::anim_single_solo( var_1, "lake_turn" );
    var_0 maps\_anim::anim_single_solo( var_2, "lake_turn" );
    var_0 notify( "stop_wait_loop" );
    var_0 thread maps\_anim::anim_loop( var_6, "lake_hookup_loop", "stop_wait_loop" );
    common_scripts\utility::flag_wait_any( "lake_start_left", "lake_player_fail" );
    waitframe();

    if ( common_scripts\utility::flag( "lake_player_fail" ) )
    {
        var_0 notify( "stop_wait_loop" );
        var_0 thread maps\_anim::anim_single( var_6, "lake_takeoff" );
        wait 3;
        setdvar( "ui_deadquote", &"CRASH_FAIL_CARGO" );
        maps\_utility::missionfailedwrapper();
    }
    else
    {
        wait 3;
        var_7 = getent( "ice_lake_crate_clip", "targetname" );
        var_7 delete();
        var_1 delete();
        var_2 delete();
        var_3 delete();
    }
}

handle_cargo_shut( var_0 )
{
    common_scripts\utility::flag_wait( "ice_lake_start_combat" );
    self notify( "stop_wait_loop" );
    maps\_anim::anim_single_solo( var_0, "lake_shut" );
    thread maps\_anim::anim_loop_solo( var_0, "lake_hookup_loop", "stop_wait_loop" );
}

lake_scene_fail_timeout()
{
    wait 60;
    common_scripts\utility::flag_set( "lake_lift_off" );
    wait 45;
    common_scripts\utility::flag_set( "lake_player_fail" );
}

ic_underwater_visionset_change( var_0 )
{
    if ( var_0 )
    {
        var_1 = 1;
        level.player maps\_utility::vision_set_fog_changes( "crash_lake_underwater", 2 );
        level.player _meth_8490( "clut_crash_underwater", 2 );
        setsunflareposition( ( -31, -169, 0 ) );
        level.player _meth_84A9();
        level.player _meth_84AB( 4.32, 40.9, 1, 1 );
        maps\_water::set_light_set_for_player( "crash_lake_fallin_02" );

        if ( isdefined( level.dofunderwater ) )
            thread maps\_water::setdof( level.dofunderwater );

        playfx( common_scripts\utility::getfx( "water_screen_plunge" ), self.origin );
        self _meth_8218( 0 );
        maps\_water::setunderwateraudiozone();
        self playlocalsound( "underwater_enter" );
    }
    else
    {
        maps\_water::revertvisionsetforplayer( 0 );
        maps\_water::set_light_set_for_player( "crash_avalanche" );

        if ( isdefined( level.dofdefault ) )
            thread maps\_water::setdof( level.dofdefault );

        level.player maps\_utility::vision_set_fog_changes( "crash_avalanche_cinematic", 2 );
        level.player _meth_8490( "clut_crash_crash_site", 2 );
        level.player _meth_84AA();
        playfx( common_scripts\utility::getfx( "water_screen_emerge" ), self.origin );
        self _meth_8218( 1, 1 );
        maps\_water::clearunderwateraudiozone();
        self playlocalsound( "breathing_better" );
        self playlocalsound( "underwater_exit" );
        var_2 = undefined;

        if ( isdefined( self.water_trigger_current ) )
            var_2 = maps\_water::getwaterline( self.water_trigger_current );

        if ( isdefined( var_2 ) )
        {
            var_3 = ( self.origin[0], self.origin[1], var_2 );
            playfx( level._effect["water_splash_emerge"], var_3, anglestoforward( ( 0, self.angles[1], 0 ) + ( 270, 180, 0 ) ) );
        }
    }
}

lake_dialogue()
{
    level endon( "lake_start_left" );
    maps\_utility::battlechatter_off( "allies" );
    thread lake_dialogue_start();
    common_scripts\utility::flag_wait( "ice_lake_start_combat" );
    soundscripts\_snd::snd_music_message( "lake_combat" );
    wait 1;
    thread maps\_utility::autosave_by_name( "ice_lake_combat_start" );
    maps\_utility::smart_radio_dialogue( "crsh_crmk_openfire7" );
    common_scripts\utility::flag_set( "ice_lake_cormack_movedown" );
    thread maps\_utility::activate_trigger( "lake_cormack_move_down", "targetname" );
    thread lake_callouts();
    maps\_utility::smart_radio_dialogue( "crsh_crmk_needcargo3" );
    common_scripts\utility::flag_wait( "lake_lift_off" );
    thread maps\_utility::autosave_by_name( "lake_lift_off" );
    level.player.ignoreme = 0;
    maps\_utility::smart_radio_dialogue( "crsh_iln_vtolincoming" );
    maps\_utility::smart_radio_dialogue( "crsh_crmk_needtogetthatcargo" );
    wait 3;
    maps\_utility::smart_radio_dialogue( "crsh_crmk_hookingupcargo" );
    common_scripts\utility::flag_set( "ice_lake_callout_pause" );
    wait 12;
    maps\_utility::smart_radio_dialogue( "crsh_iln_vtoltakeoff" );
    var_0 = maps\_utility::make_array( "crsh_crmk_needtogetthatcargo", "crsh_crmk_securecargo", "crsh_iln_vtoltakeoff", "crsh_iln_securecargo2" );
    thread maps\crash_utility::nag_until_flag( var_0, "lake_start_left", 10, 15, 10 );
}

lake_dialogue_start()
{
    level endon( "ice_lake_start_combat" );
    common_scripts\utility::flag_wait( "lake_vo_start" );
    maps\_utility::smart_radio_dialogue( "crsh_crmk_deadahead" );
    maps\_utility::smart_radio_dialogue( "crsh_iln_gotcargo5" );
    maps\_utility::smart_radio_dialogue( "crsh_crmk_intercept" );
    maps\_utility::smart_radio_dialogue( "crsh_kp_sendingexfil" );
    common_scripts\utility::flag_set( "ice_lake_cormack_movedown" );
    thread maps\_utility::activate_trigger( "lake_cormack_move_down", "targetname" );
    maps\_utility::smart_radio_dialogue( "crsh_crmk_drawthemout" );
    maps\_utility::smart_radio_dialogue( "crsh_crmk_inposition" );
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_onyourshot" );
    var_0 = maps\_utility::make_array( "crsh_crmk_takeshot", "crsh_crmk_onyourshot" );
    thread maps\crash_utility::nag_until_flag( var_0, "ice_lake_start_combat", 10, 15, 10 );
}

lake_callouts()
{
    level endon( "lake_start_left" );
    common_scripts\utility::flag_set( "ice_lake_callout_pause" );
    wait 3;
    var_0 = getent( "ice_lake_callout_cargo_VOL", "targetname" );
    var_1 = getent( "ice_lake_callout_left_VOL", "targetname" );
    var_2 = getent( "ice_lake_callout_right_VOL", "targetname" );
    var_3 = getent( "ice_lake_callout_front_VOL", "targetname" );
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = undefined;

    for (;;)
    {
        var_8 = var_0 maps\_utility::get_ai_touching_volume( "axis" );
        var_9 = var_3 maps\_utility::get_ai_touching_volume( "axis" );
        var_10 = var_1 maps\_utility::get_ai_touching_volume( "axis" );
        var_11 = var_2 maps\_utility::get_ai_touching_volume( "axis" );
        common_scripts\utility::flag_wait( "ice_lake_callout_pause" );

        if ( isdefined( var_8 ) && !isdefined( var_4 ) )
        {
            var_4 = 1;
            var_12 = randomint( 3 );

            if ( var_12 == 0 )
                ilana_lake_callout_cargo();
            else if ( var_12 == 1 )
            {
                if ( common_scripts\utility::cointoss() )
                    cormack_lake_callout_cargo();
            }
            else if ( var_12 == 2 )
                cormack_lake_callout_stop();
        }
        else if ( isdefined( var_9 ) && !isdefined( var_5 ) )
        {
            var_5 = 1;
            var_12 = randomint( 3 );

            if ( var_12 == 0 )
                cormack_lake_callout_cover();
            else if ( var_12 == 1 )
                cormack_lake_callout_coverme();
            else if ( var_12 == 2 )
                cormack_lake_callout_pin();

            if ( common_scripts\utility::cointoss() )
                ilana_lake_callout_shot();
        }
        else if ( isdefined( var_10 ) && !isdefined( var_6 ) )
        {
            var_6 = 1;

            if ( common_scripts\utility::cointoss() )
                ilana_lake_callout_left();

            var_4 = undefined;
            var_5 = undefined;
            var_7 = undefined;
        }
        else if ( isdefined( var_11 ) && !isdefined( var_7 ) )
        {
            var_7 = 1;

            if ( common_scripts\utility::cointoss() )
                ilana_lake_callout_right();

            var_4 = undefined;
            var_5 = undefined;
            var_6 = undefined;
        }

        var_8 = undefined;
        var_9 = undefined;
        var_10 = undefined;
        var_11 = undefined;
        wait(randomfloatrange( 4, 10 ));
    }
}

cormack_lake_callout_cargo()
{
    level endon( "lake_start_collapse" );
    maps\_utility::smart_radio_dialogue( "crsh_crmk_needtogetthatcargo" );
}

cormack_lake_callout_downhere()
{
    level endon( "lake_start_collapse" );
    maps\_utility::smart_radio_dialogue( "crsh_crmk_getdownhere" );
}

cormack_lake_callout_goliath()
{
    level endon( "lake_start_collapse" );
    maps\_utility::smart_radio_dialogue( "crsh_crmk_keephitting" );
}

cormack_lake_callout_coverme()
{
    level endon( "lake_start_collapse" );
    maps\_utility::smart_radio_dialogue( "crsh_crmk_movingpos" );
}

cormack_lake_callout_stop()
{
    level endon( "lake_start_collapse" );
    maps\_utility::smart_radio_dialogue( "crsh_crmk_getthecargo" );
}

cormack_lake_callout_pin()
{
    level endon( "lake_start_collapse" );
    maps\_utility::smart_radio_dialogue( "crsh_crmk_pinemdown" );
}

cormack_lake_callout_cover()
{
    level endon( "lake_start_collapse" );
    maps\_utility::smart_radio_dialogue( "crsh_crmk_coverfire" );
}

cormack_lake_callout_rpg()
{
    level.cormack maps\_utility::smart_dialogue( "crsh_crmk_caveentrance" );
}

ilana_lake_callout_right()
{
    maps\_utility::smart_radio_dialogue( "crsh_iln_totheright" );
}

ilana_lake_callout_cave()
{
    maps\_utility::smart_radio_dialogue( "crsh_iln_caveentrance" );
}

ilana_lake_callout_left()
{
    maps\_utility::smart_radio_dialogue( "crsh_iln_lookleft" );
}

ilana_lake_callout_shot()
{
    maps\_utility::smart_radio_dialogue( "crsh_iln_takingtheshot" );
}

ilana_lake_callout_goliath()
{
    maps\_utility::smart_radio_dialogue( "crsh_iln_goliaths_incoming" );
}

ilana_lake_callout_cargo()
{
    maps\_utility::smart_radio_dialogue( "crsh_iln_moreofthem" );
}

begin_lake_cinema()
{
    level.lake_scene_anim_node = getent( "NODE_lake_scene", "targetname" );
    thread ice_lake_cinema_heli();
    thread lake_cinema_player();
    maps\_utility::battlechatter_off( "axis" );
    maps\_utility::battlechatter_off( "allies" );
    thread ignore_friendlies();
    level waittill( "start_lake_npcs" );
    level.gideon = maps\crash_utility::spawn_ally( "gideon", "gideon_gideon" );
    level.gideon.canjumppath = 1;
    level.gideon thread lake_cinema_gideon();
    level.cormack thread lake_cinema_cormack();
    level.ilana thread lake_cinema_ilona();
    thread lake_cinema_enemies();
    common_scripts\utility::flag_wait( "lake_cinema_done" );
}

lake_cinema_player()
{
    common_scripts\utility::flag_wait( "go_gideon_moment" );
    common_scripts\utility::flag_set( "lake_underwater_lighting" );
    level.player _meth_8482();
    level.player _meth_831D();
    maps\_shg_utility::disable_features_entering_cinema( 1 );
    waitframe();
    var_0 = maps\_utility::spawn_anim_model( "rig_hands", level.player.origin, level.player.angles );
    var_1 = level.player common_scripts\utility::spawn_tag_origin();
    var_2 = common_scripts\utility::getstruct( "lake_fall_water_struct", "targetname" );
    level.player _meth_807D( var_0, "tag_player", 1, 0, 0, 0, 0 );
    level.player maps\_utility::delaythread( 1, maps\_hud_util::fade_out, 0.2, "black" );
    level.player _meth_817D( "stand" );
    level.player _meth_8119( 0 );
    level.player _meth_811A( 0 );
    var_1 maps\_anim::anim_single_solo( var_0, "lake_fall" );
    var_0 delete();
    var_3 = level.player common_scripts\utility::spawn_tag_origin();
    var_3.origin = ( var_2.origin[0], var_2.origin[1], var_3.origin[2] );
    level.player _meth_807D( var_3, "tag_origin", 1, 25, 25, 25, 0 );
    var_3 _meth_82B5( var_2.angles, 0.1 );
    thread falling_bits_fx();
    playfxontag( level._effect["player_bubbles"], var_3, "tag_origin" );
    playfx( level._effect["water_splash_enter"], var_3.origin, anglestoforward( ( 0, level.player.angles[1], 0 ) + ( 270, 180, 0 ) ) );
    playfx( level._effect["water_screen_plunge"], var_3.origin, anglestoforward( ( 0, level.player.angles[1], 0 ) + ( 270, 180, 0 ) ) );
    wait 0.1;
    var_3 _meth_82AE( var_2.origin, 1.5, 0, 0.5 );
    playfxontag( level._effect["player_bubbles"], var_3, "tag_origin" );
    playfx( level._effect["water_splash_enter"], var_3.origin, anglestoforward( ( 0, level.player.angles[1], 0 ) + ( 270, 180, 0 ) ) );
    level.player thread maps\_hud_util::fade_in( 0.25, "black" );
    wait 0.5;
    playfxontag( level._effect["player_bubbles"], var_3, "tag_origin" );
    playfx( level._effect["water_splash_enter"], var_3.origin, anglestoforward( ( 0, level.player.angles[1], 0 ) + ( 270, 180, 0 ) ) );
    level.player thread maps\crash_exo_temperature::set_external_temperature_over_time( level.temperature_water, 6.5 );
    level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( 40, 6.5 );
    level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time( 91.5, 6.5 );
    level.player.underwater = 1;
    thread player_swim_hint();
    wait 1;
    stopfxontag( level._effect["player_bubbles"], var_1, "tag_origin" );
    level.player_breath_amount_use_rate = 4.0;
    level.player _meth_804F();
    _func_0D3( "compass", "1" );
    wait 2;
    stopfxontag( level._effect["player_bubbles"], var_3, "tag_origin" );
    var_1 delete();
    var_3 delete();
    common_scripts\utility::flag_wait( "lake_underwater_exit_flag" );
    soundscripts\_snd::snd_message( "lake_exit" );
    common_scripts\utility::flag_set( "go_gideon_moment_save" );
    common_scripts\utility::flag_set( "obj_lake_gideon_save" );
    thread maps\_utility::autosave_by_name( "gideon_save" );
    var_0 = maps\_utility::spawn_anim_model( "rig2" );
    var_0 hide();
    thread falling_bits_fx();
    var_4 = getent( "NODE_water_fx", "targetname" ) common_scripts\utility::spawn_tag_origin();
    var_5 = playfxontag( level._effect["player_bubbles"], var_0, "tag_origin" );
    playfxontag( level._effect["water_splash_enter"], var_0, "tag_origin" );
    common_scripts\utility::flag_clear( "hide_player_snow_footprints" );
    common_scripts\utility::flag_set( "outdoors" );
    level notify( "start_lake_npcs" );
    level.lake_scene_anim_node thread maps\_anim::anim_single_solo( var_0, "gideon_scene" );
    level.player thread maps\crash_exo_temperature::set_external_temperature_over_time( level.temperature_outdoor, 1.5 );
    level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( level.exo_max, 1.5 );
    level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time( 98.6, 1.5 );
    level.player _meth_8080( var_0, "tag_origin", 0.75 );
    wait 0.5;
    level.player maps\_utility::ent_flag_set( "water_trigger_paused" );
    level.player notify( "out_of_water" );
    level.player maps\_water::disable_swim_or_underwater_walk();
    level.player shellshock( "crash_goliath_hit", 0.25 );
    level.player _meth_807D( var_0, "tag_player", 1, 10, 10, 10, 5, 1 );
    var_0 show();
    var_6 = level.player maps\_utility::get_storable_weapons_list_primaries();
    level.player _meth_8310();
    stopfxontag( level._effect["player_bubbles"], var_0, "tag_origin" );
    wait 1;
    common_scripts\utility::flag_set( "go_lighting_gideon" );
    var_0 waittillmatch( "single anim", "end" );
    common_scripts\utility::flag_set( "gideon_lighting_unlock" );
    _func_0D3( "ammoCounterHide", 0 );
    _func_0D3( "actionSlotsHide", 0 );
    level.player _meth_804F();
    var_0 delete();
    level.player _meth_8119( 1 );
    level.player _meth_811A( 1 );

    foreach ( var_8 in var_6 )
    {
        if ( !issubstr( tolower( var_8 ), "s1_railgun" ) )
        {
            level.player _meth_830E( var_8 );
            continue;
        }

        level.player _meth_830E( "iw5_kf5_sp" );
    }

    level.player _meth_8315( var_6[0] );
    level.player _meth_8481();
    level.player _meth_831E();
    level.player maps\_utility::blend_movespeedscale( 0.5, 0.5 );
    thread maps\crash_exfil::vtol_takedown_failure();
    common_scripts\utility::flag_set( "gideon_frees_you" );
    level.player maps\_utility::ent_flag_clear( "water_trigger_paused" );
    wait 1;
    maps\_shg_utility::enable_features_exiting_cinema( 1 );
}

delayplayfx( var_0, var_1, var_2, var_3 )
{
    wait(var_0);
    playfxontag( var_1, var_2, var_3 );
}

falling_bits_fx()
{
    var_0 = common_scripts\utility::getstructarray( "NODE_falling_fx", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2 common_scripts\utility::spawn_tag_origin();
        var_4 = playfxontag( level._effect["sinky_bits"], var_3, "tag_origin" );
        wait 0.5;
    }
}

player_swim_hint()
{
    wait 4;
    thread maps\_utility::hintdisplayhandler( "player_lake_swim" );
}

should_break_swim_hint()
{
    return isdefined( level.player.swimming ) && ( level.player _meth_82F3()[0] > 0.25 || level.player _meth_82F3()[1] > 0.25 );
}

should_break_recover_hint()
{
    return isdefined( level.player.recover );
}

should_break_recover_hint_command()
{
    var_0 = "playerjump";
    level.player _meth_82DD( var_0, "+gostand" );
    level.player _meth_82DD( var_0, "+usereload" );
    level.player _meth_82DD( var_0, "+stance" );
    level.player waittill( var_0 );
    level.player.recover = 1;
}

should_break_recover_hint_movement()
{
    for (;;)
    {
        if ( level.player _meth_82F3()[0] > 0.1 || level.player _meth_82F3()[1] > 0.1 )
        {
            level.player.recover = 1;
            level.player notify( "playerjump" );
            return;
        }

        waitframe();
    }
}

get_forward_movement()
{
    level endon( "player_normal_movement" );
    level.input_bool = 0;
    var_0 = 0;
    var_1 = 2;

    for (;;)
    {
        var_2 = level.player _meth_82F3();
        var_0 = var_2[0];

        while ( var_0 <= 0 )
        {
            var_2 = level.player _meth_82F3();
            var_0 = var_2[0];

            if ( level.input_bool )
            {
                level thread input_hint( 0.05 );
                level.input_bool = 0;
            }

            wait 0.05;
        }

        level notify( "stop_hint" );
        level thread maps\_utility::hint_fade();
        level.input_bool = 0;
        var_1 = 5;
        common_scripts\utility::flag_clear( "waiting_for_input" );
        wait 0.05;
    }
}

input_hint( var_0 )
{
    level endon( "player_normal_movement" );
    level endon( "stop_hint" );
    wait(var_0);
    level thread maps\_utility::hint( &"CRASH_HINT_CAVE_MOVEMENT" );
}

lake_cinema_gideon()
{
    level.lake_scene_anim_node maps\_anim::anim_single_solo( self, "gideon_scene" );
    thread maps\crash_exfil::vtol_takedown_gideon();
}

lake_cinema_cormack()
{
    thread maps\crash_utility::cormack_helmet_open( self );
    level.lake_scene_anim_node maps\_anim::anim_single_solo( self, "gideon_scene" );
    common_scripts\utility::flag_set( "cormack_start_vtol" );
    thread maps\crash_exfil::vtol_takedown_cormack();
}

lake_cinema_ilona()
{
    level.lake_scene_anim_node maps\_anim::anim_single_solo( self, "gideon_scene" );
    thread maps\crash_exfil::vtol_takedown_ilona();
    level.player maps\_utility::blend_movespeedscale( 1, 0.5 );
    thread maps\_utility::autosave_by_name( "gideon_moment" );
    common_scripts\utility::flag_set( "lake_cinema_done" );
    level.player notify( "HintDisplayHandlerEnd" );
}

lake_cinema_enemies()
{
    common_scripts\utility::flag_wait( "lake_underwater_exit_flag" );
    var_0 = maps\_utility::array_spawn_targetname( "gideon_enemy", 1 );
    var_1 = [];
    var_1[0] = var_0[0];
    var_1[1] = var_0[1];
    var_1[0].ignoreme = 1;
    var_1[0].ignoreall = 1;
    var_1[0] maps\_utility::gun_remove();
    var_1[0] thread maps\crash_utility::disable_awareness();
    var_1[0] maps\_utility::set_battlechatter( 0 );
    var_1[0].animname = "lake_enemy_0";
    var_1[1].ignoreme = 1;
    var_1[1].ignoreall = 1;
    var_1[1] maps\_utility::gun_remove();
    var_1[1] thread maps\crash_utility::disable_awareness();
    var_1[1] maps\_utility::set_battlechatter( 0 );
    var_1[1].animname = "lake_enemy_1";
    level.lake_scene_anim_node maps\_anim::anim_single( var_1, "gideon_scene" );
    var_1[0] _meth_8171();
    var_1[0] _meth_84ED( "disable" );
    var_1[0] _meth_8052();
    var_1[1] _meth_8171();
    var_1[1] _meth_84ED( "disable" );
    var_1[1] _meth_8052();
}

ignore_friendlies()
{
    level.cormack.ignoreme = 1;
    level.ilana.ignoreme = 1;
    level.player.ignoreme = 1;
    common_scripts\utility::flag_wait( "gideon_frees_you" );
    level.player.ignoreme = 0;
}

ice_lake_cinema_heli()
{

}

play_railgun_fx()
{
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0 _meth_80A6( self, "tag_flash", ( 0, 0, -2 ), ( 0, 0, 0 ), 0 );

    for (;;)
    {
        self waittill( "weapon_fired", var_1 );

        if ( !issubstr( tolower( var_1 ), "s1_railgun" ) )
            continue;

        var_2 = self _meth_80A8();
        var_3 = tag_project_player( 999999 );
        var_4 = bullettrace( var_2, var_3, 1, self );
        var_5 = var_4["surfacetype"];
        var_6 = isdefined( var_4["entity"] );
        var_7 = -1 * anglestoforward( self _meth_80A8() );
        var_8 = vectortoangles( var_4["normal"] );
        var_9 = 500;
        physicsexplosionsphere( var_4["position"], var_9 + 300, var_9 * 0.25, 1 );
        var_0 _meth_80A7( self );
        var_0 _meth_8092();
        var_10 = vectortoangles( var_4["position"] - ( var_2 - ( 0, 0, 2 ) ) );
        var_0 _meth_80A6( self, "tag_flash", ( 0, 0, -2 ), ( 0, 0, 0 ), 0 );
        playfx( common_scripts\utility::getfx( "railgun_tracer" ), var_0.origin, anglestoforward( var_10 ), anglestoup( var_10 ) );
        playfx( common_scripts\utility::getfx( "railgun_blast_snow" ), var_4["position"], anglestoforward( var_8 ), anglestoup( var_8 ) );
    }
}

tag_project_player( var_0 )
{
    var_1 = self _meth_80A8();
    var_2 = self getangles();
    var_3 = anglestoforward( var_2 );
    var_3 = vectornormalize( var_3 ) * var_0;
    return var_1 + var_3;
}
