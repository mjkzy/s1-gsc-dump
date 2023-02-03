// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

pre_load()
{

}

post_load()
{
    if ( isdefined( common_scripts\utility::getstruct( "struct_playerstart_incinerator", "targetname" ) ) )
    {
        thread setup_spawners();
        level.rh_exit_door = getent( "rh_exit_door", "targetname" );
    }
    else
        iprintln( "Warning: S3 Exterior may be compiled out!" );

    common_scripts\utility::flag_init( "flag_incinerator_start" );
    common_scripts\utility::flag_init( "flag_incinerator_fires_start" );
    common_scripts\utility::flag_init( "flag_incinerator_last_fire_loop" );
    common_scripts\utility::flag_init( "flag_incinerator_push_start" );
    common_scripts\utility::flag_init( "flag_incinerator_push_done" );
    common_scripts\utility::flag_init( "flag_incinerator_crawl_start" );
    common_scripts\utility::flag_init( "flag_incinerator_crawl_pull" );
    common_scripts\utility::flag_init( "flag_inc_pipe_break" );
    common_scripts\utility::flag_init( "flag_incinerator_player_saved" );
    common_scripts\utility::flag_init( "flag_incinerator_player_pipe_grab" );
    common_scripts\utility::flag_init( "lgt_flag_inc_near_miss" );
    common_scripts\utility::flag_init( "flag_incinerator_saved" );
    common_scripts\utility::flag_init( "flag_pushing_cart" );
    common_scripts\utility::flag_init( "flag_bh_intro_start" );
    common_scripts\utility::flag_init( "flag_bh_intro_start_scene" );
    common_scripts\utility::flag_init( "flag_bh_intro_caught" );
    common_scripts\utility::flag_init( "flag_bh_intro_caught_late" );
    common_scripts\utility::flag_init( "flag_bh_pit" );
    common_scripts\utility::flag_init( "flag_bh_pit_end" );
    common_scripts\utility::flag_init( "flag_bh_pit_all_clear" );
    common_scripts\utility::flag_init( "flag_bh_yard" );
    common_scripts\utility::flag_init( "flag_bh_back" );
    common_scripts\utility::flag_init( "flag_bh_runaway" );
    common_scripts\utility::flag_init( "flag_player_and_ally_at_window" );
    common_scripts\utility::flag_init( "flag_bh_run_ally_ready" );
    common_scripts\utility::flag_init( "flag_bh_run_start_scene" );
    common_scripts\utility::flag_init( "flag_bh_run_manticore_done" );
    common_scripts\utility::flag_init( "flag_bh_run" );
    common_scripts\utility::flag_init( "flag_bh_helo_opfor_killed" );
    common_scripts\utility::flag_init( "flag_battle_to_heli_end" );
    common_scripts\utility::flag_init( "flag_bh_open_yard_doors_in" );
    common_scripts\utility::flag_init( "flag_bh_open_yard_doors_out" );
    common_scripts\utility::flag_init( "gps_bh_mech_loader_room" );
    var_0 = getentarray( "trig_start_off", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 thread common_scripts\utility::trigger_off();

    if ( isdefined( level.rh_exit_door ) )
    {
        level.rh_exit_door.animname = "runtoheli_door";
        level.rh_exit_door maps\_anim::setanimtree();
        level.rh_exit_door.col = getent( "door_bh_heli_link", "targetname" );
        level.rh_exit_door.col linkto( level.rh_exit_door, "j_bone_door_right", ( 28, 1.5, 48 ), ( 0, 0, 0 ) );
        common_scripts\utility::getstruct( "struct_run_to_heli_manticore", "targetname" ) maps\_anim::anim_first_frame_solo( level.rh_exit_door, "runtoheli_door_kick" );
    }

    level._facility = spawnstruct();
    precacherumble( "steady_rumble" );
    precacherumble( "tank_rumble" );
}

start( var_0 )
{
    level.player maps\captured_util::warp_to_start( var_0 );

    if ( issubstr( level.start_point, "heliride" ) )
    {
        var_1 = getent( "vehicle_warbird", "targetname" );
        var_2 = var_1 maps\_utility::spawn_vehicle();

        if ( level.currentgen )
            var_2 thread maps\captured_util::tff_cleanup_vehicle( "helipad" );

        var_2 thread setup_warbird();
        var_2 thread vehicle_scripts\_xh9_warbird::open_left_door();
    }
}

setup_warbird()
{
    self.animname = "vtol";
    maps\_vehicle::godon();
    self makeunusable();
    var_0 = spawn( "script_model", self.origin );
    var_0 setmodel( "vehicle_xh9_warbird_interior_collision" );
    var_0 linkto( self, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.heli_collision = var_0;
    level._facility.warbird = self;
    var_1 = getent( "refl_probe_heli_open", "targetname" );
    level._facility.warbird overridereflectionprobe( var_1.origin );
    var_0 hide();
    level waittill( "heliride_blood" );
    var_0 show();
    common_scripts\utility::flag_wait( "flag_heliride_end" );
    var_0 delete();
}

start_incinerator()
{
    setsaveddvar( "g_friendlyNameDist", 0 );
    maps\captured_util::warp_allies( "struct_anim_incinerator" );
    level.player thread maps\_utility::blend_movespeedscale( 0.8 );
    level.player maps\captured_util::warp_to_start( "struct_playerstart_incinerator" );
    level.player takeallweapons();
    level.player allowmelee( 0 );
    var_0 = getent( "aut_doctor_hatch", "targetname" );
    var_0 delete();
}

main_incinerator()
{
    common_scripts\utility::flag_wait( "flag_incinerator_start" );
    maps\_utility::autosave_by_name( "incinerator" );
    wait 0.05;
    common_scripts\utility::flag_set( "flag_incinerator_saved" );
    level.player common_scripts\utility::delaycall( 0.6, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 0.6, ::playrumbleonentity, "heavy_1s" );
    maps\_player_exo::player_exo_deactivate();
    var_0 = common_scripts\utility::getstruct( "struct_anim_incinerator", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "player_rig" );
    var_2 = maps\_utility::spawn_anim_model( "cart_1" );
    var_3 = maps\_utility::spawn_anim_model( "cart_2" );
    var_4 = maps\_utility::spawn_anim_model( "grate" );
    var_1 hide();
    incinerator_intro( var_0, var_1, var_2, var_3, var_4 );
    incinerator_cart_push( var_0, var_1, var_2, var_3, var_4 );
    incinerator_crawl( var_0, var_1 );
}

incinerator_intro( var_0, var_1, var_2, var_3, var_4 )
{
    soundscripts\_snd::snd_message( "start_incinerator" );
    var_5 = maps\_hud_util::create_client_overlay( "black", 1, level.player );

    if ( level.currentgen )
    {
        if ( !istransientloaded( "captured_incinerator_tr" ) )
        {
            level notify( "tff_pre_autopsy_to_incinerator" );
            unloadtransient( "captured_autopsy_tr" );
            loadtransient( "captured_incinerator_tr" );

            while ( !istransientloaded( "captured_incinerator_tr" ) )
                wait 0.05;

            level notify( "tff_post_autopsy_to_incinerator" );
        }
    }

    var_0 maps\_anim::anim_first_frame( [ var_2, var_3, var_4 ], "incinerator_push" );
    level.ally show();
    level.player freezecontrols( 1 );
    level.player allowprone( 0 );
    level.player allowcrouch( 1 );
    level.player allowstand( 0 );
    level.player allowjump( 0 );
    level.player allowsprint( 0 );
    level.player thread maps\_utility::blend_movespeedscale( 0.2 );
    thread maps\captured_util::smooth_player_link( var_1, 0.4 );
    thread incinerator_player_damage();
    var_0 = common_scripts\utility::getstruct( "struct_anim_incinerator", "targetname" );
    var_0 thread maps\_anim::anim_single( [ var_1, level.ally ], "incinerator_intro" );
    wait 0.05;
    var_0 maps\captured_util::anim_set_real_time( [ var_1, level.ally ], "incinerator_intro", 2.8 );
    var_0 maps\_utility::delaythread( getanimlength( level.ally maps\_utility::getanim( "incinerator_intro" ) ) - 2.8, maps\_anim::anim_loop_solo, level.ally, "incinerator_intro_wait_loop", "started_pushing_cart" );
    var_6 = getanimlength( var_1 maps\_utility::getanim( "incinerator_intro" ) ) - 2.7;
    level.player common_scripts\utility::delaycall( var_6, ::freezecontrols, 0 );
    level.player maps\_utility::delaythread( var_6, maps\_utility::blend_movespeedscale, 0.5, 5.0 );
    level.player maps\_utility::delaythread( var_6, ::incinerator_stance );
    level.player common_scripts\utility::delaycall( var_6, ::unlink );
    var_1 common_scripts\utility::delaycall( var_6, ::hide );
    wait 8.3;
    common_scripts\utility::flag_set( "flag_incinerator_fires_start" );
    var_5 fadeovertime( 0.05 );
    var_5.alpha = 0;
}

incinerator_cart_push( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = maps\_utility::get_rumble_ent();
    var_5 maps\_utility::rumble_ramp_to( 0, 0.05 );
    var_6 = getent( "use_incinerator_cart", "targetname" );
    level.pipe = maps\_utility::spawn_anim_model( "incinerator_pipe" );
    var_7 = spawn( "script_model", ( 7959, -13466, -1773 ) );
    var_7 setmodel( "tag_origin" );
    level.pipe retargetscriptmodellighting( var_7 );
    var_0 maps\_anim::anim_first_frame_solo( level.pipe, "incinerator_crawl" );
    wait 21.0;
    var_6 makeusable();
    var_6 maps\_utility::addhinttrigger( &"CAPTURED_HINT_PUSH_CONSOLE", &"CAPTURED_HINT_PUSH_PC" );
    level notify( "incineratory_usable" );
    maps\captured_actions::incinerator_push_action( var_6, var_0 );
    soundscripts\_snd::snd_message( "aud_incin_cart_start" );
    var_6 delete();
    level.player thread maps\_utility::blend_movespeedscale( 0.8 );
    level.player thread still_pressing_use_button();
    level.player freezecontrols( 1 );
    level.player allowstand( 1 );
    level.player allowprone( 0 );
    level.player allowcrouch( 0 );
    common_scripts\utility::flag_set( "flag_incinerator_push_start" );
    level.ally setanim( level.ally maps\_utility::getanim( "incinerator_push_stop_1" )[0], 0.9, 0.5 );
    var_0 thread maps\_anim::anim_single_solo( var_1, "incinerator_push_start" );
    level.player playerlinktoblend( var_1, "tag_player", 0.5 );
    wait 0.5;
    var_1 show();
    level.player playerlinktodelta( var_1, "tag_player", 1, 0, 0, 0, 0, 1 );
    var_8 = getanimlength( var_1 maps\_utility::getanim( "incinerator_push_start" ) );
    wait(var_8 - 0.5);
    var_9 = 0;
    var_10 = [ var_1, level.ally, var_2, var_3, var_4 ];
    var_0 notify( "started_pushing_cart" );
    common_scripts\utility::flag_set( "flag_pushing_cart" );
    soundscripts\_snd::snd_message( "aud_incin_cart_push" );
    var_0 thread maps\_anim::anim_single( var_10, "incinerator_push" );

    while ( var_9 < 0.38 )
    {
        wait 0.05;
        var_0 notify( "started_pushing_cart" );
        var_11 = level.player getnormalizedmovement();
        var_12 = max( var_11[0], -1.0 * var_11[1] );
        var_13 = var_1 maps\_utility::getanim( "incinerator_push" );
        var_14 = getanimlength( var_13 );
        var_9 = ( var_1 getanimtime( var_13 ) * var_14 + 0.05 ) / var_14;

        if ( 0.2 > var_9 || var_9 > 0.28 )
        {
            if ( var_12 > 0.5 && !common_scripts\utility::flag( "flag_pushing_cart" ) )
            {
                common_scripts\utility::flag_set( "flag_pushing_cart" );
                maps\_anim::anim_set_rate( var_10, "incinerator_push", 1 );
                soundscripts\_snd::snd_message( "aud_incin_cart_push" );
                level.ally thread incinerator_ally_push( var_0, var_9 );
                continue;
            }

            if ( var_12 < 0.5 && common_scripts\utility::flag( "flag_pushing_cart" ) )
            {
                common_scripts\utility::flag_clear( "flag_pushing_cart" );
                maps\_anim::anim_set_rate( var_10, "incinerator_push", 0 );
                soundscripts\_snd::snd_message( "aud_incin_cart_push_stop" );
                level.ally thread incinerator_ally_push_stop( var_0, var_9 );
            }
        }
    }

    soundscripts\_snd::snd_message( "aud_incin_cart_done" );
    level.ally stopanimscripted();
    common_scripts\utility::flag_set( "flag_pushing_cart" );
    common_scripts\utility::flag_set( "flag_incinerator_push_done" );
    maps\_anim::anim_set_rate( var_10, "incinerator_push", 1 );
    level.ally notify( "started_pushing_cart" );
    var_0 maps\_utility::delaythread( 0.05, maps\_anim::anim_set_time, [ level.ally ], "incinerator_push", var_9 );
    var_0 thread maps\captured_anim::anim_single_to_loop_solo( level.ally, "incinerator_push", "incinerator_crawl_wait_loop", "ally_pull_player" );
    var_0 waittill( "incinerator_push" );
}

incinerator_crawl( var_0, var_1 )
{
    common_scripts\utility::flag_set( "flag_incinerator_crawl_start" );
    maps\_utility::autosave_by_name_silent( "incinerator_crawl" );
    var_2 = 0;
    var_3 = [ var_1, level.pipe ];
    thread incinerator_player_end_anim_and_cleanup( var_0, var_3 );
    level.player enableslowaim( 0.3, 0.15 );
    level.player playerlinktodelta( var_1, "tag_player", 0.5, 20, 30, 15, 0, 1 );

    while ( !common_scripts\utility::flag( "flag_incinerator_player_pipe_grab" ) )
    {
        wait 0.05;
        var_4 = level.player getnormalizedmovement()[0];
        var_2 = var_1 getanimtime( var_1 maps\_utility::getanim( "incinerator_crawl" ) );

        if ( var_4 > 0.5 && !common_scripts\utility::flag( "flag_pushing_cart" ) )
        {
            common_scripts\utility::flag_set( "flag_pushing_cart" );
            maps\_anim::anim_set_rate( var_3, "incinerator_crawl", 1 );
            continue;
        }

        if ( var_4 < 0.5 && common_scripts\utility::flag( "flag_pushing_cart" ) )
        {
            common_scripts\utility::flag_clear( "flag_pushing_cart" );
            maps\_anim::anim_set_rate( var_3, "incinerator_crawl", 0 );
        }
    }

    common_scripts\utility::flag_set( "flag_incinerator_crawl_pull" );
    maps\_anim::anim_set_rate( var_3, "incinerator_crawl", 1 );
    common_scripts\utility::flag_wait( "flag_incinerator_player_saved" );
    level.player playerlinktoblend( var_1, "tag_player", 1.0 );
    var_0 notify( "ally_pull_player" );
    var_0 thread maps\_anim::anim_single_solo( level.ally, "incinerator_crawl_pull", undefined, 0.2 );
}

incinerator_player_end_anim_and_cleanup( var_0, var_1 )
{
    level.player thread maps\_utility::blend_movespeedscale( 0.2 );
    var_0 maps\_anim::anim_single( var_1, "incinerator_crawl" );
    setsaveddvar( "g_friendlyNameDist", level.friendlynamedist );
    level.player unlink();
    level.player freezecontrols( 0 );
    level.player allowstand( 1 );
    level.player allowprone( 1 );
    level.player allowjump( 1 );
    level.player allowcrouch( 1 );
    level.player enableweapons();
    level.player allowsprint( 1 );
    level.player allowmelee( 1 );
    level.player disableslowaim();
    level.player enableoffhandweapons();
    var_1[0] delete();
    level.player thread incinerator_player_wobble();
    level.player thread maps\captured_util::start_one_handed_gunplay( "iw5_titan45pickup_sp_xmags" );
    level.player maps\_utility::blend_movespeedscale( 0.33, 5.95 );
    level.player maps\_utility::delaythread( 6.0, maps\_utility::blend_movespeedscale, 0.8, 8.0 );
    maps\_player_exo::player_exo_activate();
}

incinerator_stance()
{
    level endon( "flag_pushing_cart" );

    while ( !common_scripts\utility::flag( "flag_between_carts_end" ) )
    {
        level.player setstance( "crouch" );
        level.player allowstand( 0 );
        common_scripts\utility::flag_wait_either( "flag_between_carts", "flag_between_carts_end" );
        level.player setstance( "stand" );
        level.player allowstand( 1 );

        if ( common_scripts\utility::flag( "flag_between_carts" ) )
            level.player forcemantle();

        common_scripts\utility::flag_waitopen( "flag_between_carts" );
    }
}

incinerator_ally_push( var_0, var_1 )
{
    self notify( "started_pushing_cart" );
    self endon( "started_pushing_cart" );
    self setanim( maps\_utility::getanim( "incinerator_push_stop_1" )[0], 0, 0.5 );
}

incinerator_ally_push_stop( var_0, var_1 )
{
    if ( var_1 < 0.22 )
        self setanim( maps\_utility::getanim( "incinerator_push_stop_1" )[0], 0.99, 0.5 );
    else
        self setanim( maps\_utility::getanim( "incinerator_push_stop_2" )[0], 0.99, 0.5 );
}

still_pressing_use_button()
{
    self endon( "death" );
    self endon( "started_pushing_cart" );
    self.still_pressing_use = 1;

    while ( self usebuttonpressed() )
        wait 0.05;

    self.still_pressing_use = undefined;
}

usebuttonrepressed()
{
    if ( isdefined( self.still_pressing_use ) )
        return 0;

    return self usebuttonpressed();
}

incinerator_player_damage()
{
    level.player endon( "death" );
    var_0 = common_scripts\utility::getstruct( "incinerator_fire_damage_source", "targetname" );
    common_scripts\utility::flag_wait( "flag_incinerator_fires_start" );
    var_1 = 0;
    var_2 = 1;

    for ( var_3 = 0; var_3 < 4; var_3++ )
    {
        level waittill( "incinerator_flame_on" );

        for ( var_4 = 0; var_4 < var_2; var_4++ )
        {
            if ( !common_scripts\utility::flag( "flag_incinerator_push_done" ) )
            {
                wait 0.05;
                level.player dodamage( var_1, var_0.origin );
                continue;
            }

            thread incinerator_rumble_hold( 3 );
            break;
        }

        var_1 += 5;
        var_2 += 3;
    }

    for ( var_1 = 0; !common_scripts\utility::flag( "flag_incinerator_push_done" ); var_1 += 0.1 )
    {
        wait 0.5;
        level.player dodamage( var_1, var_0.origin );
    }

    common_scripts\utility::flag_wait( "lgt_flag_inc_near_miss" );

    while ( !common_scripts\utility::flag( "flag_incinerator_crawl_start" ) )
    {
        level.player playrumbleonentity( "tank_rumble" );
        wait 1.0;
    }

    stopallrumbles();
    var_2 = 1.0;

    while ( !common_scripts\utility::flag( "flag_incinerator_player_pipe_grab" ) )
    {
        wait(var_2);
        level.player dodamage( var_1, var_0.origin );
        var_1 += 0.5;

        if ( var_2 > 0.05 )
        {
            var_5 = randomfloatrange( 0.04, 0.06 );
            var_2 -= var_5;
        }
    }

    common_scripts\utility::flag_wait( "flag_incinerator_player_saved" );
    wait 2.0;
    level.player thread incinerator_player_blur();
    level.player playrumbleonentity( "damage_heavy" );

    for ( var_3 = 0; var_3 < 4; var_3++ )
    {
        level.player playrumbleonentity( "tank_rumble" );
        wait 1.0;
    }
}

incinerator_rumble_hold( var_0 )
{
    level.player endon( "death" );
    level endon( "flag_incinerator_crawl_start" );

    for ( var_1 = 0; var_1 < var_0; var_1++ )
    {
        level.player playrumbleonentity( "tank_rumble" );
        wait 1.0;
    }
}

incinerator_player_blur()
{
    self endon( "death" );

    for ( var_0 = 6; var_0 > 1; var_0 -= 1.2 )
    {
        var_1 = randomfloatrange( 1, 2 );
        setblur( randomfloatrange( 0.666667 * var_0, var_0 ), var_1 );
        wait(var_1);
        setblur( 0, var_1 );
        wait(var_1);
        wait(randomfloatrange( 2, 4 ));
    }
}

incinerator_player_wobble()
{
    self endon( "death" );
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_1 = ( randomfloatrange( -6, 6 ), randomfloatrange( -6, 6 ), randomfloatrange( -6, 6 ) );
    self playersetgroundreferenceent( var_0 );
    var_0 rotateto( var_1, 3, randomfloatrange( 0.75, 1.5 ), randomfloatrange( 0.75, 1.5 ) );
    wait 3.0;
    var_0 rotateto( ( 0, 0, 0 ), 3, randomfloatrange( 0.75, 1.5 ), randomfloatrange( 0.75, 1.5 ) );
    wait 3.0;
    self playersetgroundreferenceent( undefined );
    var_0 delete();
}

nt_incinerator_player_saved( var_0 )
{
    common_scripts\utility::flag_set( "flag_incinerator_player_saved" );
}

nt_incinerator_player_pipe_grab( var_0 )
{
    soundscripts\_snd::snd_message( "aud_incin_pipe_grab" );
    common_scripts\utility::flag_set( "flag_incinerator_player_pipe_grab" );
}

start_battle_to_heli()
{
    maps\captured_util::warp_allies( "struct_allystart_battle_to_heli" );
    level.player thread maps\_utility::blend_movespeedscale( 0.8 );
    level.player maps\captured_util::warp_to_start( "struct_playerstart_battle_to_heli" );
    level.player thread maps\captured_util::start_one_handed_gunplay( "iw5_titan45pickup_sp_xmags" );
    maps\_player_exo::player_exo_activate();
    soundscripts\_snd::snd_message( "start_battle_to_heli" );
    thread maps\_utility::battlechatter_off( "allies" );
    thread maps\_utility::battlechatter_off( "axis" );
}

main_battle_to_heli()
{
    level thread bh_intro();

    if ( level.currentgen )
    {
        if ( !istransientloaded( "captured_helipad_tr" ) )
            level waittill( "tff_post_incinerator_to_helipad" );
    }

    thread maps\captured_util::captured_caravan_spawner( "s3_exterior_trucks", undefined, 3.5, 7, "helipad" );
    thread bh_yard_doors();
    level bh_pit();
    level bh_yard();
    level bh_yard_exit();
    level thread run_to_heli_heli_landing();
    common_scripts\utility::flag_wait( "flag_bh_run_manticore_done" );
}

bh_intro()
{
    level.ally thread maps\_utility::set_force_color( "r" );
    var_0 = maps\_utility::spawn_targetname( "opfor_bh_intro_alarm", 1 );
    var_0 maps\captured_util::ignore_everything();
    var_0.allowdeath = 1;
    var_1 = common_scripts\utility::getstruct( "struct_scene_battle_to_heli_alarm_guard", "targetname" );
    var_1 thread maps\_anim::anim_loop( [ var_0 ], "alarm_start_loop", "stop_alarm_loop" );
    common_scripts\utility::flag_wait( "flag_bh_intro_start_scene" );

    if ( level.nextgen )
        maps\_utility::autosave_by_name( "bh_intro" );
    else
        thread bh_intro_autosave();

    var_1 notify( "stop_alarm_loop" );
    var_0.allowdeath = 1;
    var_1 thread maps\captured_anim::anim_single_to_loop( [ var_0 ], "alarm_push", "alarm_end_loop", "stop_alarm_loop" );
    soundscripts\_snd::snd_message( "start_outdoor_alarms" );
    maps\_utility::delaythread( 2.4, common_scripts\utility::flag_set, "flag_bh_intro_caught" );
    maps\_utility::delaythread( 2.9, common_scripts\utility::flag_set, "flag_bh_intro_caught_late" );
}

bh_intro_autosave()
{
    common_scripts\utility::flag_wait( "flag_bh_intro_currentgen_autosave" );
    maps\_utility::autosave_by_name( "bh_intro" );
}

bh_pit()
{
    common_scripts\utility::flag_wait( "flag_bh_pit" );
    thread maps\_utility::battlechatter_on( "allies" );
    thread maps\_utility::battlechatter_on( "axis" );
    level.nextgrenadedrop = 573000;
    thread bh_helo_flyby();
    maps\_utility::flood_spawn( getentarray( "opfor_bh_pit", "targetname" ) );
    maps\captured_util::delay_retreat( "opfor_bh", 30, -2, "flag_bh_pit_end", "color_bh_pit_end", 1 );
    thread maps\_spawner::killspawner( 1300 );
    level thread bh_pit_exit( getent( "color_bh_yard_start", "targetname" ), -1 * maps\_utility::get_ai_group_sentient_count( "opfor_bh" ) );
}

bh_pit_exit( var_0, var_1 )
{
    level endon( "bh_pit_all_clear" );
    var_2 = getnodearray( "traverse_bh_disconnect", "script_noteworthy" );
    disconnectnodepair( var_2[0], var_2[1] );
    level thread bh_pit_yard_visblock( getent( "visblock_bh_pit_end", "targetname" ) );
    maps\_utility::flood_spawn( getentarray( "opfor_bh_pit_exit", "targetname" ) );
    thread maps\captured_util::delay_retreat( "opfor_bh", 20, var_1 - 1, "flag_bh_pit_all_clear", "color_bh_yard_start", 1 );

    while ( !common_scripts\utility::flag( "flag_bh_yard" ) && !common_scripts\utility::flag( "flag_bh_pit_all_clear" ) )
    {
        var_3 = level.player getcurrentweapon();

        if ( var_3 != "none" && var_3 != "iw5_kvahazmatknifeonearm_sp" && level.player getammocount( var_3 ) / weaponclipsize( var_3 ) >= 0.5 )
            break;

        wait 0.05;
    }

    if ( common_scripts\utility::flag( "flag_bh_yard" ) || common_scripts\utility::flag( "flag_bh_pit_all_clear" ) )
        level bh_pit_cleanup();

    while ( !common_scripts\utility::flag( "flag_bh_yard" ) && !common_scripts\utility::flag( "flag_bh_pit_all_clear" ) && !maps\_utility::player_can_see_ai( level.ally ) )
        wait 0.05;

    if ( common_scripts\utility::flag( "flag_bh_yard" ) || common_scripts\utility::flag( "flag_bh_pit_all_clear" ) )
        level bh_pit_cleanup();

    var_0 common_scripts\utility::trigger_on();
    var_0 waittill( "trigger" );
    level bh_pit_cleanup();
}

bh_yard()
{
    level.one_handed_help = 1;
    maps\_utility::flood_spawn( getentarray( "opfor_bh_yard_ar", "targetname" ) );
    maps\_utility::flagwaitthread( "flag_bh_yard", maps\_utility::flood_spawn, getentarray( "opfor_bh_yard_smg", "targetname" ) );
    maps\_utility::flagwaitthread( "flag_bh_runaway", common_scripts\utility::flag_set, "flag_bh_back" );
    maps\captured_util::delay_retreat( "opfor_bh", 120, [ -9, 3 ], "flag_bh_back", "color_bh_back", 1 );
    getent( "color_bh_yard", "targetname" ) delete();
    thread maps\_spawner::killspawner( 1302 );
    maps\_utility::flood_spawn( getentarray( "opfor_bh_yard_exit", "targetname" ) );
    maps\captured_util::delay_retreat( "opfor_bh", 90, 0, "flag_bh_runaway", "color_bh_runaway", 1 );
    level.player thread maps\captured_util::one_handed_modify_threatbias( "standard" );
    var_0 = getent( "trig_bh_open_yard_doors", "targetname" );
    var_0 maps\_utility::flagwaitthread( "gps_bh_mech_loader_room", common_scripts\utility::trigger_on );
    level.player maps\_utility::flagwaitthread( "gps_bh_mech_loader_room", maps\captured_util::one_handed_modify_threatbias, "aggro" );
    thread bh_run_mechs();
    level.one_handed_help = undefined;
    thread maps\_spawner::killspawner( 1303 );
}

bh_yard_exit()
{
    var_0 = getentarray( "door_bh_yard", "targetname" );
    level.ally maps\_utility::disable_ai_color();
    level.ally maps\_utility::follow_path( getnode( "node_bh_yard_exit", "targetname" ) );
    wait 0.5;

    while ( distance2d( level.ally.origin, level.player.origin ) > 160 && !common_scripts\utility::flag( "gps_bh_mech_loader_room" ) )
        wait 0.05;

    level.player notify( "gps_bh_mech_loader_room_stop_flagWaitThread" );
    level.player thread maps\captured_util::one_handed_modify_threatbias( "default" );
    level notify( "bh_doors_manual" );
    soundscripts\_snd::snd_message( "aud_door", "yard_doors", "open" );

    foreach ( var_2 in var_0 )
    {
        var_2 moveto( var_2.open, 1.25, 0.2, 0.5 );
        var_2.link common_scripts\utility::delaycall( 0.75, ::connectpaths );
    }

    level.ally maps\_utility::enable_cqbwalk();
    var_4 = common_scripts\utility::getstruct( "struct_run_to_heli_manticore", "targetname" );
    var_4 maps\_anim::anim_reach_solo( level.ally, "runtoheli_window_start" );
    level notify( "bh_ally_start_manticore_anims" );
    var_4 thread maps\captured_anim::anim_single_to_loop( level.ally, "runtoheli_window_start", "runtoheli_window_loop", "runtoheli_window_ender" );
    thread rh_loader_movement();
    thread maps\_utility::battlechatter_off( "allies" );
    thread maps\_utility::battlechatter_off( "axis" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "gps_bh_mech_loader_room" );
        soundscripts\_snd::snd_message( "aud_door", "yard_doors", "close" );

        foreach ( var_2 in var_0 )
        {
            var_2 moveto( var_2.close, 1.25, 0.2, 0.5 );
            var_2.link common_scripts\utility::delaycall( 0.5, ::disconnectpaths );
            var_2.link common_scripts\utility::delaycall( 0.75, ::disconnectpaths );
        }

        wait 1.25;

        if ( common_scripts\utility::flag( "gps_bh_mech_loader_room" ) )
            break;

        soundscripts\_snd::snd_message( "aud_door", "yard_doors", "open" );
        wait 0.25;

        foreach ( var_2 in var_0 )
        {
            var_2 moveto( var_2.open, 1.25, 0.2, 0.5 );
            var_2.link common_scripts\utility::delaycall( 0.5, ::connectpaths );
        }

        wait 1.25;
    }

    var_9 = getent( "gps_bh_mech_loader_room", "targetname" );
    var_10 = maps\_utility::get_ai_group_ai( "opfor_bh" );

    foreach ( var_12 in var_10 )
    {
        if ( !var_12 istouching( var_9 ) )
        {
            var_12 notify( "stop_opfor_one_handed" );
            var_12 delete();
        }
    }
}

bh_helo_flyby()
{
    var_0 = getent( "vehicle_bh_warbird_ambient", "targetname" );
    var_1 = var_0 maps\_vehicle::spawn_vehicle_and_gopath();
    var_1 soundscripts\_snd::snd_message( "aud_heli_battle_flyover" );

    if ( level.currentgen )
        var_1 thread maps\captured_util::tff_cleanup_vehicle( "helipad" );

    var_1 maps\_vehicle::godon();
    thread maps\captured_fx::fx_heli_flyby_dust( var_1 );
}

bh_pit_yard_visblock( var_0 )
{
    var_0 movez( 256, 0.05 );
    common_scripts\utility::flag_wait( "flag_bh_pit_all_clear" );
    var_0 maps\_utility::delaythread( 30, maps\_utility::_delete );
    var_0 maps\_utility::flagwaitthread( [ "flag_bh_yard", 15 ], maps\_utility::_delete );

    while ( isdefined( var_0 ) )
    {
        level waittill( "ai_killed", var_1 );

        if ( isdefined( var_1.script_noteworthy ) && var_1.script_noteworthy == "opfor_bh_pit" )
            continue;

        if ( isdefined( var_1.lastattacker ) && isplayer( var_1.lastattacker ) )
            break;
    }

    if ( isdefined( var_0 ) )
        var_0 delete();
}

bh_yard_doors()
{
    level endon( "bh_doors_manual" );
    var_0 = common_scripts\utility::getstruct( "door_bh_yard_close", "targetname" );
    var_1 = getentarray( "door_bh_yard", "targetname" );

    foreach ( var_3 in var_1 )
    {
        var_4 = getent( var_3.target, "targetname" );
        var_4 linkto( var_3 );
        var_3.link = var_4;
        var_3.open = var_3.origin;
        var_3.close = var_0.origin;
        var_3 moveto( var_3.close, 0.05 );
    }

    for (;;)
    {
        common_scripts\utility::flag_wait_either( "flag_bh_open_yard_doors_in", "flag_bh_open_yard_doors_out" );
        soundscripts\_snd::snd_message( "aud_door", "yard_doors", "open" );

        foreach ( var_3 in var_1 )
        {
            var_3 moveto( var_3.open, 1.25, 0.2, 0.5 );
            var_3.link common_scripts\utility::delaycall( 0.5, ::connectpaths );
        }

        wait 1.5;

        while ( common_scripts\utility::flag( "flag_bh_open_yard_doors_in" ) || common_scripts\utility::flag( "flag_bh_open_yard_doors_out" ) )
            wait 0.05;

        soundscripts\_snd::snd_message( "aud_door", "yard_doors", "close" );

        foreach ( var_3 in var_1 )
        {
            var_3 moveto( var_3.close, 1.25, 0.2, 0.5 );
            var_3.link common_scripts\utility::delaycall( 0.5, ::disconnectpaths );
        }
    }
}

bh_pit_cleanup()
{
    thread maps\_spawner::killspawner( 1301 );
    maps\_utility::autosave_by_name( "bh_yard" );
    var_0 = maps\_utility::get_living_ai_array( "opfor_bh_pit_exit_AI", "targetname" );
    maps\_utility::delaythread( randomfloat( 1.0 ), common_scripts\utility::array_thread, var_0, maps\_utility::follow_path, getnode( "cover_bh_yard", "targetname" ) );

    if ( !common_scripts\utility::flag( "flag_bh_pit_all_clear" ) )
        common_scripts\utility::flag_set( "flag_bh_pit_all_clear" );

    wait 0.05;

    if ( common_scripts\utility::flag( "flag_bh_yard" ) )
        getent( "color_bh_yard", "targetname" ) notify( "trigger" );

    level notify( "bh_pit_all_clear" );
}

start_run_to_heli()
{
    maps\captured_util::warp_allies( "struct_allystart_run_to_heli" );
    level.ally thread maps\_utility::set_force_color( "r" );
    getent( "color_bh_runaway", "targetname" ) notify( "trigger" );
    thread bh_run_mechs();
    thread rh_loader_movement();
    level.ally maps\_utility::enable_cqbwalk();
    var_0 = common_scripts\utility::getstruct( "struct_run_to_heli_manticore", "targetname" );
    var_0 maps\_anim::anim_reach_solo( level.ally, "runtoheli_window_start" );
    level notify( "bh_ally_start_manticore_anims" );
    var_0 thread maps\captured_anim::anim_single_to_loop( level.ally, "runtoheli_window_start", "runtoheli_window_loop", "runtoheli_window_ender" );
    level.player thread maps\_utility::blend_movespeedscale( 0.8 );
    level.player maps\captured_util::warp_to_start( "struct_playerstart_run_to_heli" );
    level.player thread maps\captured_util::start_one_handed_gunplay( "iw5_titan45pickup_sp_xmags" );
    maps\_player_exo::player_exo_activate();
    thread maps\_utility::battlechatter_off( "allies" );
    thread maps\_utility::battlechatter_off( "axis" );
    level thread maps\captured_util::captured_caravan_spawner( "s3_exterior_trucks", undefined, 3.5, 7, "helipad" );
    level thread run_to_heli_heli_landing();
}

main_run_to_heli()
{
    run_to_heli_manticore_scene( level.rh_exit_door );
    thread bh_attacker_accuracy_increaser();
    var_0 = maps\_utility::spawn_targetname( "opfor_bh_helo_stairs" );
    level.ally maps\_utility::disable_cqbwalk();
    level.ally.ignoreall = 0;
    thread bh_run_civilians();
    common_scripts\utility::flag_set( "flag_bh_run" );
    level.ally maps\_utility::disable_ai_color();
    level.ally thread maps\_utility::follow_path( getnode( "node_bh_run", "targetname" ) );
    setsaveddvar( "player_sprintUnlimited", "1" );
    level notify( "stop_caravan_spawner" );
    var_1 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "veh_bh_explo" );
    var_2 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "veh_bh_mid" );
    var_1 soundscripts\_snd::snd_message( "aud_cap_escape_to_heli_truck_1" );
    var_2 soundscripts\_snd::snd_message( "aud_cap_escape_to_heli_truck_2" );

    if ( level.currentgen )
    {
        var_1 thread maps\captured_util::tff_cleanup_vehicle( "helipad" );
        var_2 thread maps\captured_util::tff_cleanup_vehicle( "helipad" );
    }

    wait 1.5;

    if ( !common_scripts\utility::flag( "flag_bh_helo_opfor_stairs" ) )
    {
        level.ally shoot();
        maps\_utility::kill_deathflag( "flag_bh_helo_opfor_stairs" );
    }

    wait 2.2;
    level.ally shoot();
    common_scripts\utility::flag_wait( "flag_battle_to_heli_end" );
}

run_to_heli_heli_landing()
{
    common_scripts\_exploder::exploder( "fx_heli_flyby_dust_settle" );
    var_0 = getent( "vehicle_bh_warbird", "targetname" );
    var_1 = var_0 maps\_vehicle::spawn_vehicle_and_gopath();
    var_1 soundscripts\_snd::snd_message( "aud_heli_manticore_flyover" );
    var_1 soundscripts\_snd::snd_message( "aud_heli_escape_idle_sfx" );

    if ( level.currentgen )
        var_1 thread maps\captured_util::tff_cleanup_vehicle( "helipad" );

    var_1 thread setup_warbird();
    thread maps\captured_fx::fx_heli_manticore_dust( var_1 );
}

run_to_heli_manticore_scene( var_0 )
{
    level endon( "run_to_heli_failed" );
    level notify( "lgt_dof_run_to_heli" );
    level.ally maps\captured_util::ignore_everything();
    level.player.ignoreme = 1;
    var_1 = common_scripts\utility::getstruct( "struct_run_to_heli_manticore", "targetname" );
    common_scripts\utility::flag_wait( "flag_player_and_ally_at_window" );
    var_2 = maps\_utility::array_spawn_targetname( "opfor_bh_at_helo", 1 );
    common_scripts\utility::array_thread( var_2, maps\_utility::set_baseaccuracy, 0.01 );
    thread bh_heli_enemy_killer( var_2, var_1 );
    common_scripts\utility::flag_waitopen( "flag_currently_nagging" );
    wait 1.0;
    var_3 = getanimlength( level.ally maps\_utility::getanim( "runtoheli_window_start" ) );
    var_4 = level.ally getanimtime( level.ally maps\_utility::getanim( "runtoheli_window_start" ) );

    if ( var_4 > 0 )
        wait(var_3 - var_4 * var_3);

    var_1 notify( "runtoheli_window_ender" );
    var_1 maps\_anim::anim_single_solo( level.ally, "runtoheli_window" );
    var_1 thread maps\captured_anim::anim_single_to_loop( level.ally, "runtoheli_door_start", "runtoheli_door_loop", "runtoheli_door_ender" );
    var_5 = getanimlength( level.ally maps\_utility::getanim( "runtoheli_door_start" ) );
    wait(var_5);
    common_scripts\utility::flag_set( "flag_bh_run_ally_ready" );

    for ( var_6 = 0; var_6 < 15; var_6++ )
    {
        if ( maps\_utility::player_can_see_ai( level.ally ) )
            break;

        wait 0.5;
    }

    thread maps\_utility::autosave_now();
    var_1 notify( "runtoheli_door_ender" );
    var_1 thread maps\_anim::anim_single_solo( level.ally, "runtoheli_door_kick" );
    var_1 thread maps\_anim::anim_single_solo( var_0, "runtoheli_door_kick" );
    var_0.col connectpaths();
    level notify( "stop_caravan_spawner" );
}

bh_attacker_accuracy_increaser()
{
    level.player endon( "death" );
    level endon( "flag_heliride_warbird_mount" );
    level.player maps\_utility::set_player_attacker_accuracy( 0.01 );
    common_scripts\utility::flag_wait( "flag_bh_run" );
    var_0 = 0.01;
    var_1 = 0.01;
    var_2 = 1;
    var_3 = 1.0;

    for (;;)
    {
        if ( common_scripts\utility::flag( "flag_runtoheli_player_bounds" ) )
            var_2 += 3;
        else
            var_2 = 0.25;

        if ( var_2 > 10 )
            level.player dodamage( 500, ( 12248, -12629, -1948 ) );

        if ( var_0 > 0.01 )
            var_1 *= var_2;

        level.player maps\_utility::set_player_attacker_accuracy( var_1 );
        var_0 += 0.01;
        var_1 = var_0;

        if ( level.player maps\_player_exo::overdrive_is_on() && common_scripts\utility::flag( "flag_runtoheli_player_bounds" ) )
            var_3 = 0.2;
        else
            var_3 = 0.4;

        wait(var_3);

        if ( var_0 > 0.4 )
            break;
    }

    var_4 = getent( "trigger_battle_to_heli_end", "targetname" );
    var_4 delete();
    level notify( "run_to_heli_failed" );
    level._facility.warbird maps\_vehicle::godoff();
    level._facility.warbird.perferred_crash_location = level._facility.warbird;
    level._facility.warbird maps\_utility::destructible_force_explosion();
    level.ally maps\_utility::stop_magic_bullet_shield();
    level.ally kill();
    setdvar( "ui_deadquote", &"CAPTURED_FAIL_GIDEON_KILLED" );
    thread maps\_utility::missionfailedwrapper();
}

bh_run_civilians()
{
    level endon( "run_to_heli_failed" );
    wait 1.0;
    var_0 = maps\_utility::array_spawn_targetname( "run_to_heli_civilians" );

    foreach ( var_2 in var_0 )
    {
        var_2.team = "allies";
        var_2.diequietly = 1;
    }

    common_scripts\utility::array_thread( var_0, maps\captured_util::ignore_everything );
    common_scripts\utility::flag_wait( "flag_heliride_warbird_mount" );
    var_0 = maps\_utility::remove_dead_from_array( var_0 );
    maps\_utility::array_kill( var_0 );
}

bh_run_mechs()
{
    level endon( "run_to_heli_failed" );
    var_0 = maps\_utility::array_spawn( getentarray( "opfor_bh_mech", "targetname" ), 1 );
    common_scripts\utility::array_thread( var_0, maps\captured_util::ignore_everything );
    var_1 = getdvarfloat( "ai_eventDistGunshot" );
    setsaveddvar( "ai_eventDistGunshot", 0 );
    var_2 = maps\_utility::array_spawn( getentarray( "run_to_heli_mechanic", "targetname" ), 1 );
    common_scripts\utility::array_thread( var_2, maps\captured_util::ignore_everything );
    var_2[0].animname = "worker_1";
    var_2[1].animname = "worker_2";
    var_3 = common_scripts\utility::getstruct( "struct_runtoheli_mech_worker_1", "targetname" );
    var_4 = common_scripts\utility::getstruct( "struct_runtoheli_mech_worker_2", "targetname" );
    var_3 thread maps\_anim::anim_loop_solo( var_2[0], "runtoheli_worker_window_loop_1" );
    var_4 thread maps\_anim::anim_loop_solo( var_2[1], "runtoheli_worker_window_loop_2" );
    maps\_utility::trigger_wait_targetname( "run_to_heli_exited_door" );
    maps\_utility::array_delete( var_2 );
    var_5 = getent( "door_bh_mech", "targetname" );
    var_6 = getent( "door_bh_mech_door_cover", "targetname" );
    var_6 hide();
    var_6 notsolid();
    var_5 movez( 100, 6, 0, 0.5 );
    var_7 = getnodearray( "bh_run_mech_node", "targetname" );
    wait 3.0;
    common_scripts\utility::array_thread( var_0, maps\captured_util::unignore_everything );
    setsaveddvar( "ai_eventDistGunshot", var_1 );
    wait 3.0;
    var_8 = 0;

    foreach ( var_10 in var_0 )
    {
        if ( isalive( var_10 ) )
        {
            var_10 notify( "stop_hunting" );
            var_10 thread maps\_mech::mech_generic_attacking_behavior();
            var_10.walkdist = 999999;
            var_10.walkdistfacingmotion = var_10.walkdist;
            var_10.goalradius = 80;
            var_10 thread maps\_utility::follow_path( var_7[var_8] );
            var_8 += 1;
            wait(randomfloatrange( 1, 3 ));
        }
    }
}

bh_heli_enemy_killer( var_0, var_1 )
{
    level endon( "run_to_heli_failed" );
    level._facility.warbird thread vehicle_scripts\_xh9_warbird::open_left_door();
    var_1 waittill( "runtoheli_door_ender" );
    wait 4.0;
    level.player.ignoreme = 0;

    foreach ( var_3 in var_0 )
    {
        if ( isalive( var_3 ) )
            var_3 maps\_utility::set_ignoresuppression( 1 );
    }

    wait 3.0;
    var_5 = 1;

    foreach ( var_3 in var_0 )
    {
        if ( isalive( var_3 ) )
        {
            level.ally shoot();
            level.ally shoot();
            maps\_utility::kill_deathflag( var_3.script_deathflag );
        }

        wait(randomfloatrange( 0.5, 1.5 ));
    }
}

bh_cleanup()
{
    var_0 = getentarray( "opfor_bh_helo", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 notify( "stop current floodspawner" );

    var_4 = getaiarray( "axis" );

    foreach ( var_6 in var_4 )
    {
        if ( isdefined( var_6.targetname ) )
        {
            if ( var_6.targetname != "actor_player_mech_AI" )
                var_6.diequietly = 1;
        }
    }

    maps\_utility::kill_deathflag( "flag_bh_helo_opfor_killed" );
    maps\_utility::kill_deathflag( "flag_bh_helo_opfor_killed_1" );
    maps\_utility::kill_deathflag( "flag_bh_helo_opfor_killed_2" );
    maps\_utility::kill_deathflag( "flag_bh_helo_opfor_killed_3" );
    maps\_utility::kill_deathflag( "flag_bh_opfor_killed" );

    foreach ( var_6 in var_4 )
    {
        if ( isdefined( var_6 ) && isalive( var_6 ) )
        {
            if ( !( var_6 == level.pilot || var_6 == level.mech_pilot ) )
            {
                if ( isdefined( self.magic_bullet_shield ) && self.magic_bullet_shield )
                    var_6 maps\_utility::stop_magic_bullet_shield();

                if ( isdefined( var_6.targetname ) )
                {
                    if ( var_6.targetname != "actor_player_mech_AI" )
                        var_6 delete();
                }
            }
        }
    }

    level.player notify( "stop_one_handed_gunplay" );
    setsaveddvar( "player_sprintUnlimited", "0" );
}

rh_loader_movement()
{
    level endon( "run_to_heli_failed" );
    level endon( "stop_caravan_spawner" );
    var_0 = undefined;
    var_1 = getent( "crane_straps", "targetname" );
    var_2 = getent( "rh_crane_front", "targetname" );
    var_3 = getentarray( "manticore_pallet_moving", "targetname" );

    foreach ( var_5 in var_3 )
    {
        if ( !isdefined( var_0 ) )
        {
            var_0 = var_5;
            continue;
        }

        var_5 linkto( var_0 );
    }

    var_7 = getent( "rh_crane_back", "targetname" );
    playfxontag( level._effect["cap_crane_light"], var_2, "crane_T" );
    playfxontag( level._effect["cap_crane_light"], var_7, "crane_T" );
    soundscripts\_snd::snd_message( "aud_manticore_crane" );
    var_2 movey( 240, 10, 2, 2 );
    var_1 movey( 240, 10, 2, 2 );
    var_0 movey( 240, 10, 2, 2 );
    wait 10.0;
    var_1 movez( -122, 8, 2, 2 );
    var_0 movez( -122, 8, 2, 2 );
    wait 9.0;
    var_1 movez( 60, 4, 2, 2 );
    wait 4.0;
    var_2 movey( -400, 15, 2, 2 );
    var_1 movey( -400, 15, 2, 2 );
    wait 15.0;
    var_7 movex( -460, 10, 2, 2 );
    wait 10.0;
    var_7 movex( 460, 10, 2, 2 );
}

setup_spawners()
{
    maps\_utility::array_spawn_function( getentarray( "opfor_bh_pit", "targetname" ), ::opfor_bh );
    maps\_utility::array_spawn_function( getentarray( "opfor_bh_pit_exit", "targetname" ), ::opfor_bh );
    maps\_utility::array_spawn_function( getentarray( "opfor_bh_yard_ar", "targetname" ), ::opfor_bh );
    maps\_utility::array_spawn_function( getentarray( "opfor_bh_yard_pyr_ar", "targetname" ), ::opfor_bh );
    maps\_utility::array_spawn_function( getentarray( "opfor_bh_yard_smg", "targetname" ), ::opfor_bh );
    maps\_utility::array_spawn_function( getentarray( "opfor_bh_yard_pyr_smg", "targetname" ), ::opfor_bh );
    maps\_utility::array_spawn_function( getentarray( "opfor_bh_yard_exit", "targetname" ), ::opfor_bh );
    maps\_utility::array_spawn_function( getentarray( "opfor_bh_helo", "targetname" ), ::opfor_bh );
    maps\_utility::array_spawn_function( getentarray( "opfor_bh_helo_stairs", "targetname" ), ::opfor_bh );
    maps\_utility::array_spawn_function( getentarray( "opfor_bh_at_helo", "targetname" ), ::opfor_bh );
    maps\_utility::array_spawn_function( getentarray( "cover_bh_run", "target" ), ::opfor_bh );
    maps\_utility::array_spawn_function( getentarray( "opfor_bh_intro_alarm", "targetname" ), ::actor_alarm_guard );
}

opfor_bh()
{
    self endon( "death" );
    level endon( "run_to_heli_failed" );
    thread maps\captured_util::opfor_death_mod();
    thread maps\captured_util::opfor_ammo_drop_mod();
    thread maps\_utility::set_grenadeammo( int( max( 0, randomintrange( -3, 3 ) ) ) );
    var_0 = undefined;

    if ( isdefined( self.target, "targetname" ) )
        var_0 = getentarray( self.target, "targetname" );

    while ( isdefined( var_0 ) && var_0.size > 0 )
    {
        var_1 = randomint( var_0.size );

        if ( isdefined( var_0[var_1].target ) && isdefined( var_0[var_1].script_flag_wait ) && common_scripts\utility::flag( var_0[var_1].script_flag_wait ) )
        {
            var_0 = getentarray( var_0[var_1].target, "targetname" );
            continue;
        }

        thread maps\_utility::follow_path( var_0[var_1] );
        break;
    }
}

actor_alarm_guard()
{
    self endon( "death" );
    self.no_friendly_fire_penalty = 1;
    self.animname = "op_alarm";
}

main_heliride()
{
    thread vtol_sequence();
    thread maps\_utility::battlechatter_off( "allies" );
    thread maps\_utility::battlechatter_off( "axis" );
    common_scripts\_exploder::exploder( "fx_heli_flyby_dust_settle" );
    common_scripts\_exploder::exploder( "fx_heli_dust_settle" );
    common_scripts\utility::flag_wait( "flag_heliride_warbird_mount" );
    setsaveddvar( "g_friendlyNameDist", 0 );
    common_scripts\utility::flag_set( "flag_battle_to_heli_end" );
    soundscripts\_snd::snd_message( "stop_post_courtyard_ext_alarms_2" );
    common_scripts\utility::array_thread( getentarray( "trig_mb1", "script_noteworthy" ), common_scripts\utility::trigger_off );
    common_scripts\utility::array_thread( getentarray( "trig_mb2", "script_noteworthy" ), common_scripts\utility::trigger_off );
    maps\_utility::flood_spawn( getentarray( "opfor_bh_helo", "targetname" ) );
    level thread maps\captured_fx::fx_heli_ride();
    common_scripts\utility::flag_wait( "flag_heliride_end" );
    common_scripts\utility::array_thread( getentarray( "trig_mb1", "script_noteworthy" ), common_scripts\utility::trigger_on );
    common_scripts\utility::array_thread( getentarray( "trig_mb2", "script_noteworthy" ), common_scripts\utility::trigger_on );
}

vtol_sequence()
{
    level endon( "run_to_heli_failed" );
    level.player endon( "death" );
    var_0 = level._facility.warbird;
    var_0.animname = "warbird";
    common_scripts\utility::flag_wait( "flag_heliride_warbird_mount" );
    level.player common_scripts\utility::delaycall( 6.25, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 9.45, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 12.45, ::playrumbleonentity, "light_2s" );
    level.player common_scripts\utility::delaycall( 15.0, ::playrumbleonentity, "heavy_3s" );
    level.player common_scripts\utility::delaycall( 18.0, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 19.75, ::playrumbleonentity, "light_1s" );
    level.player common_scripts\utility::delaycall( 21.0, ::playrumbleonentity, "heavy_3s" );
    level.player common_scripts\utility::delaycall( 25.25, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 26.4, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 26.75, ::playrumbleonentity, "heavy_3s" );
    setsaveddvar( "ammoCounterHide", "1" );
    level.player notify( "stop_one_handed_gunplay" );
    level.player stopsliding();
    level.player allowpowerslide( 0 );
    level.player setstance( "stand" );
    level.player freezecontrols( 1 );
    level.player allowcrouch( 0 );
    level.player allowjump( 0 );
    level.player allowmelee( 0 );
    level.player allowprone( 0 );
    level.player allowsprint( 0 );
    var_1 = spawnstruct();
    var_1.origin = ( 10401.9, -5807.3, 637.251 );
    level.glass = spawn( "script_model", var_1.origin );
    level.glass setmodel( "vehicle_xh9_warbird_interior_glass" );
    level.glass linkto( level._facility.warbird, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.glass hide();
    level.glass_broken = spawn( "script_model", var_1.origin );
    level.glass_broken setmodel( "vehicle_xh9_warbird_interior_glass_brkn" );
    level.glass_broken linkto( level._facility.warbird, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.glass_broken hide();
    maps\_player_exo::player_exo_deactivate();
    level.player maps\_utility::player_speed_default();
    level.ally maps\_utility::disable_heat_behavior();
    level.ally maps\captured_util::unignore_everything();
    level.player maps\_utility::set_player_attacker_accuracy( 1.0 );
    level.player enableinvulnerability();
    maps\_utility::autosave_by_name( "heliride" );
    level.player_rig = maps\_utility::spawn_anim_model( "player_rig" );
    level.player_rig hide();
    var_2 = getent( "heliride_mech_pilot", "targetname" );
    level.mech_pilot = var_2 maps\_utility::spawn_ai( 1 );
    level.mech_pilot.animname = "heli_mech_pilot";
    var_3 = getent( "heliride_pilot", "targetname" );
    level.pilot = var_3 maps\_utility::spawn_ai( 1 );
    level.pilot.animname = "heli_pilot";
    var_4 = maps\_utility::spawn_anim_model( "heli_mech" );
    var_5 = [ level.ally, var_0, level.pilot, var_4, level.mech_pilot ];
    var_1 thread maps\_anim::anim_single_solo( level.player_rig, "warbird_scene_begin" );
    thread heliride_rockets_and_slowmo();
    level.player disableweapons();
    level notify( "all_heliride_pieces_spawned" );
    level.player playerlinktoblend( level.player_rig, "tag_player", 0.5 );
    var_6 = getanimlength( level.player_rig maps\_utility::getanim( "warbird_scene_begin" ) );
    thread bh_cleanup();
    wait(var_6);
    level.player_rig show();
    var_1 thread warbird_anims( var_5 );
    var_1 maps\_anim::anim_single_solo( level.player_rig, "warbird_scene" );
    var_7 = maps\_hud_util::create_client_overlay( "black", 1, level.player );
    level notify( "heli_ride_crashed" );
    level.player showviewmodel();
    var_0 delete();
    level.player_rig delete();
    var_4 delete();
    level.pilot delete();
    level.mech_pilot delete();
    level.player disableinvulnerability();

    if ( isdefined( common_scripts\utility::getstruct( "struct_playerstart_mb1", "targetname" ) ) )
        level.player maps\captured_util::warp_to_start( "struct_playerstart_mb1" );

    if ( level.currentgen )
    {
        if ( !istransientloaded( "captured_mechbattle_tr" ) )
        {
            level notify( "tff_pre_helipad_to_mechbattle" );
            unloadtransient( "captured_helipad_tr" );
            loadtransient( "captured_mechbattle_tr" );

            while ( !istransientloaded( "captured_mechbattle_tr" ) )
                wait 0.05;

            level notify( "tff_post_helipad_to_mechbattle" );
        }
    }

    wait 5.1;
    var_7 fadeovertime( 5.0 );
    var_7.alpha = 0;
    thread maps\captured_fx::fx_heli_crash_hero_falling_dust();
    setsaveddvar( "ammoCounterHide", "0" );
    common_scripts\utility::flag_set( "flag_heliride_end" );
}

warbird_anims( var_0 )
{
    thread maps\_anim::anim_single( var_0, "warbird_scene" );
    level waittill( "heliride_blood" );
    level.glass show();
    level waittill( "heliride_punch" );
    level.glass hide();
    level.glass_broken show();
    common_scripts\utility::flag_wait( "flag_heliride_end" );
    level.glass delete();
    level.glass_broken delete();
}

heliride_rockets_and_slowmo()
{
    level endon( "run_to_heli_failed" );
    level.player endon( "death" );
    wait 4.0;
    var_0 = common_scripts\utility::getstruct( "heliride_rocket_start", "targetname" );
    var_1 = common_scripts\utility::getstruct( "heliride_rocket_end_01", "targetname" );
    var_2 = magicbullet( "iw5_mahemstraight_sp", var_0.origin, var_1.origin );
    wait 1.5;
    var_1 = common_scripts\utility::getstruct( "heliride_rocket_end_02", "targetname" );
    var_2 = magicbullet( "iw5_mahemstraight_sp", var_0.origin, var_1.origin );
    level waittill( "heliride_slowmo_start" );
    settimescale( 0.75 );
    level waittill( "heliride_slowmo_end" );
    settimescale( 1.0 );
}

nt_warbird_mech_link( var_0 )
{
    var_1 = var_0;
    var_1 vehicle_jetbikesethoverforcescale( level._facility.warbird, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

nt_warbird_anims_start( var_0 )
{
    level notify( "heliride_start" );
}

nt_helicrash_slowstart( var_0 )
{
    level notify( "heliride_slowmo_start" );
}

nt_helicrash_slowend( var_0 )
{
    level notify( "heliride_slowmo_end" );
}
