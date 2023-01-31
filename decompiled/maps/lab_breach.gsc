// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init_facility_breach()
{
    common_scripts\utility::flag_init( "breach_done" );
    common_scripts\utility::flag_init( "lab_breach_all_guys_dead" );
    common_scripts\utility::flag_init( "flag_burke_kills_guy" );
    common_scripts\utility::flag_init( "burke_is_in_position_for_facility_breach" );
    level.breachfriendlies = [];
    level.breachfriendlies[level.breachfriendlies.size] = level.burke;
    level.breachfriendlies[level.breachfriendlies.size] = level.cormack;
    level.breachfriendlies[level.breachfriendlies.size] = level.knox;
    var_0 = "none";

    if ( level.currentgen )
    {
        if ( _func_21E( "lab_intro_tr" ) )
            var_0 = "intro";
        else if ( _func_21E( "lab_middle_tr" ) )
            var_0 = "middle";
        else if ( _func_21E( "lab_outro_tr" ) )
            var_0 = "outro";
    }

    init_facility_breach_anims( var_0 );

    if ( level.currentgen )
    {
        if ( var_0 == "intro" )
            thread notetrack_setup_middle();

        if ( var_0 == "intro" || var_0 == "middle" )
            thread notetrack_setup_outro();
    }
}

init_facility_breach_anims( var_0 )
{
    init_facility_breach_model_anims( var_0 );
    init_facility_breach_npc_anims( var_0 );
    init_facility_breach_view_model_anims( var_0 );
}

#using_animtree("script_model");

init_facility_breach_model_anims( var_0 )
{
    level.scr_animtree["facility_breach_charge"] = #animtree;
    level.scr_model["facility_breach_charge"] = "breach_charge";
    level.scr_anim["facility_breach_charge"]["facility_breach"] = %lab_breachroom_breach_charge;
    level.scr_animtree["facility_breach_mute_device"] = #animtree;
    level.scr_model["facility_breach_mute_device"] = "muteCharge";
    level.scr_anim["facility_breach_mute_device"]["facility_breach"] = %lab_breachroom_breach_mute;

    if ( level.nextgen || var_0 == "middle" )
        maps\_anim::addnotetrack_customfunction( "facility_breach_mute_device", "vfx_mute_device_plant", maps\lab_fx::mute_device_plant_fx, "facility_breach" );

    level.scr_animtree["facility_breach_crate"] = #animtree;
    level.scr_model["facility_breach_crate"] = "genericProp";
    level.scr_anim["facility_breach_crate"]["facility_breach"] = %lab_breachroom_breach_box;
}

#using_animtree("generic_human");

init_facility_breach_npc_anims( var_0 )
{
    level.scr_anim["burke"]["facility_breach"] = %lab_breachroom_breach_hero_01;
    level.scr_anim["burke"]["facility_breach_idle"][0] = %lab_breachroom_breach_hero_01_idle;
    level.scr_anim["burke"]["facility_breach_end"] = %lab_breachroom_breach_hero_01_exit;

    if ( level.nextgen || var_0 == "middle" )
    {
        maps\_anim::addnotetrack_customfunction( "burke", "interrupt_anim", ::no_interrupt, "facility_breach" );
        maps\_anim::addnotetrack_customfunction( "burke", "glass_break", ::break_glass, "facility_breach" );
    }

    level.facility_breach_guys = [];
    level.facility_breach_guys[0] = getent( "facility_breach_guy_01", "targetname" );
    level.facility_breach_guys[0].animname = "facility_breach_guy_01";
    level.scr_anim["facility_breach_guy_01"]["facility_breach"] = %lab_breachroom_breach_guy_01;
    level.facility_breach_guys[1] = getent( "facility_breach_guy_02", "targetname" );
    level.facility_breach_guys[1].animname = "facility_breach_guy_02";
    level.scr_anim["facility_breach_guy_02"]["facility_breach"] = %lab_breachroom_breach_guy_02;
    level.facility_breach_guys[2] = getent( "facility_breach_guy_03", "targetname" );
    level.facility_breach_guys[2].animname = "facility_breach_guy_03";
    level.scr_anim["facility_breach_guy_03"]["facility_breach"] = %lab_breachroom_breach_guy_03;
    level.facility_breach_guys[3] = getent( "facility_breach_guy_04", "targetname" );
    level.facility_breach_guys[3].animname = "facility_breach_guy_04";
    level.scr_anim["facility_breach_guy_04"]["facility_breach"] = %lab_breachroom_breach_guy_04;
    level.facility_breach_guys[4] = getent( "facility_breach_guy_05", "targetname" );
    level.facility_breach_guys[4].animname = "facility_breach_guy_05";
    level.scr_anim["facility_breach_guy_05"]["facility_breach"] = %lab_breachroom_breach_guy_05;

    if ( level.nextgen || var_0 == "middle" )
        maps\_anim::addnotetrack_customfunction( "facility_breach_guy_05", "start_ragdoll", maps\lab_anim::ai_kill, "facility_breach" );
}

#using_animtree("player");

init_facility_breach_view_model_anims( var_0 )
{
    level.scr_anim["player_rig"]["facility_breach"] = %lab_breachroom_breach_vm;

    if ( level.nextgen || var_0 == "middle" )
    {
        maps\_anim::addnotetrack_customfunction( "player_rig", "Start_slowdown", ::breach_slow_down, "facility_breach" );
        maps\_anim::addnotetrack_customfunction( "player_rig", "Blow_charge", ::blow_door, "facility_breach" );
        maps\_anim::addnotetrack_customfunction( "player_rig", "enable_player_control", ::enable_player_control, "facility_breach" );
    }
}

notetrack_setup_middle()
{
    level waittill( "tff_post_intro_to_middle" );
    maps\_anim::addnotetrack_customfunction( "facility_breach_mute_device", "vfx_mute_device_plant", maps\lab_fx::mute_device_plant_fx, "facility_breach" );
    maps\_anim::addnotetrack_customfunction( "burke", "interrupt_anim", ::no_interrupt, "facility_breach" );
    maps\_anim::addnotetrack_customfunction( "burke", "glass_break", ::break_glass, "facility_breach" );
    maps\_anim::addnotetrack_customfunction( "facility_breach_guy_05", "start_ragdoll", maps\lab_anim::ai_kill, "facility_breach" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "Start_slowdown", ::breach_slow_down, "facility_breach" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "Blow_charge", ::blow_door, "facility_breach" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "enable_player_control", ::enable_player_control, "facility_breach" );
}

notetrack_setup_outro()
{
    level waittill( "tff_post_middle_to_outro" );
}

facility_breach_get_burke_into_position()
{
    var_0 = getnode( "node_burke_facility_breach", "targetname" );
    level.burke _meth_81A5( var_0 );
    var_1 = level.burke.goalradius;
    level.burke.goalradius = 16;
    level.burke waittill( "goal" );
    level.burke.goalradius = var_1;
    common_scripts\utility::flag_set( "burke_is_in_position_for_facility_breach" );
}

facility_breach_spawn_bad_guys( var_0 )
{
    level.facility_breach_guys = [];
    level.facility_breach_guys[0] = getent( "facility_breach_guy_01", "targetname" ) maps\_utility::spawn_ai( 1 );
    level.facility_breach_guys[0].animname = "facility_breach_guy_01";
    level.facility_breach_guys[1] = getent( "facility_breach_guy_02", "targetname" ) maps\_utility::spawn_ai( 1 );
    level.facility_breach_guys[1].animname = "facility_breach_guy_02";
    level.facility_breach_guys[2] = getent( "facility_breach_guy_03", "targetname" ) maps\_utility::spawn_ai( 1 );
    level.facility_breach_guys[2].animname = "facility_breach_guy_03";
    level.facility_breach_guys[3] = getent( "facility_breach_guy_04", "targetname" ) maps\_utility::spawn_ai( 1 );
    level.facility_breach_guys[3].animname = "facility_breach_guy_04";
    level.facility_breach_guys[4] = getent( "facility_breach_guy_05", "targetname" ) maps\_utility::spawn_ai( 1 );
    level.facility_breach_guys[4].animname = "facility_breach_guy_05";
    var_0 maps\_anim::anim_first_frame( level.facility_breach_guys, "facility_breach" );

    foreach ( var_2 in level.facility_breach_guys )
    {
        level thread breach_enemy_track_status( var_2 );
        var_2.allowdeath = 1;
        var_2.health = 10;
        var_2 maps\_utility::disable_surprise();
        var_2.ignoresonicaoe = 1;
    }
}

facility_breach()
{
    common_scripts\utility::flag_wait( "burke_is_in_position_for_facility_breach" );
    var_0 = getent( "facility_breach_trigger", "targetname" );
    var_0 thread maps\_utility::addhinttrigger( &"LAB_PLANT_MUTE_HINT", &"LAB_PLANT_MUTE_HINT_PC" );
    var_0 thread maps\lab_utility::disable_trigger_while_player_animating( "breaching" );
    var_1 = var_0 maps\_shg_utility::hint_button_trigger( "x" );

    for (;;)
    {
        var_0 waittill( "trigger" );

        if ( !isdefined( var_0.trigger_off ) )
            break;
    }

    var_0 delete();
    var_1 maps\_shg_utility::hint_button_clear();
    common_scripts\utility::flag_set( "breach_start" );
    var_2 = getent( "facility_breach_animation_origin", "targetname" );
    level.breachenemies_active = 0;
    level.breachenemies_alive = 0;
    level.player_rig = maps\lab_utility::spawn_player_rig();
    level.player_rig hide();
    var_3 = getent( "facility_breach_crate_model", "targetname" );
    var_4 = getent( "facility_breach_crate_clip", "targetname" );
    var_4 _meth_804D( var_3 );
    level.facility_breach_crate = maps\_utility::spawn_anim_model( "facility_breach_crate", var_3.origin );
    soundscripts\_snd::snd_message( "lab_mute_gun_holster" );
    var_2 maps\_anim::anim_first_frame_solo( level.facility_breach_crate, "facility_breach" );
    var_3 _meth_804D( level.facility_breach_crate, "tag_origin_animated", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.facility_breach_charge = maps\_utility::spawn_anim_model( "facility_breach_charge", var_2.origin );
    level.facility_breach_charge hide();
    var_2 maps\_anim::anim_first_frame_solo( level.facility_breach_charge, "facility_breach" );
    level.facility_breach_mute_device = maps\_utility::spawn_anim_model( "facility_breach_mute_device", var_2.origin );
    level.facility_breach_mute_device hide();
    var_2 maps\_anim::anim_first_frame_solo( level.facility_breach_mute_device, "facility_breach" );
    level notify( "breaching" );
    breach_friendlies_take_grenades();
    level.player freezecontrols( 1 );
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    maps\_player_exo::player_exo_deactivate();
    thread facility_breach_setup_player();
    var_5 = 0.4;
    var_2 maps\_anim::anim_first_frame_solo( level.player_rig, "facility_breach" );
    level.player _meth_8080( level.player_rig, "tag_player", var_5 );
    level.burke.animname = "burke";
    var_6 = [ level.facility_breach_charge, level.facility_breach_mute_device, level.player_rig, level.facility_breach_crate ];
    wait(var_5);
    level.facility_breach_mute_device soundscripts\_snd::snd_message( "aud_facility_breach_start" );
    level.facility_breach_charge show();
    level.facility_breach_mute_device show();
    level.player_rig show();
    var_2 thread maps\_anim::anim_single( var_6, "facility_breach" );
    level.burke thread burke_breach( var_2 );
    facility_breach_spawn_bad_guys( var_2 );
    var_2 thread maps\_anim::anim_single( level.facility_breach_guys, "facility_breach" );
    thread burke_breach_interrupt();
    level.facility_breach_guys[0] maps\_utility::delaythread( 15, maps\lab_utility::bloody_death, 1, level.burke );
    level.facility_breach_guys[1] maps\_utility::delaythread( 15, maps\lab_utility::bloody_death, 1, level.burke );
    level.facility_breach_guys[2] maps\_utility::delaythread( 15, maps\lab_utility::bloody_death, 1, level.burke );
    level.facility_breach_guys[3] maps\_utility::delaythread( 15, maps\lab_utility::bloody_death, 1, level.burke );
    maps\_utility::delaythread( 15, common_scripts\utility::flag_set, "lab_breach_all_guys_dead" );
    level.player thread breach_top_off_weapon();
    var_4 _meth_8057();

    for (;;)
    {
        if ( level.breachenemies_alive <= 0 )
            break;

        wait 0.05;
    }

    common_scripts\utility::flag_set( "breach_done" );
}

burke_breach( var_0 )
{
    var_0 maps\_anim::anim_single_solo( self, "facility_breach" );

    if ( common_scripts\utility::flag( "flag_burke_kills_guy" ) )
    {
        var_0 thread maps\_anim::anim_loop_solo( self, "facility_breach_idle", "ender" );
        common_scripts\utility::flag_wait( "flag_breach_patrol_01_clear" );
        var_0 notify( "ender" );
        self _meth_8141();
        var_0 maps\_anim::anim_single_solo_run( self, "facility_breach_end" );
    }
}

burke_breach_interrupt()
{
    level endon( "burke_breach_uninterruptable" );
    level.facility_breach_guys[4] waittill( "death" );
    level.burke notify( "single anim", "end" );
    level.burke _meth_8141();
}

facility_breach_setup_player()
{
    level.player _meth_80EF();
    level.player _meth_8321();
    level.player _meth_831F();
    level.player _meth_8119( 0 );
    level.player _meth_811A( 0 );
    level.player _meth_8304( 0 );
    level.player _meth_8301( 0 );
}

facility_breach_cleanup_player()
{
    level.player _meth_80F0();
    level.player _meth_8322();
    level.player _meth_8320();
    level.player _meth_8119( 1 );
    level.player _meth_811A( 1 );
    level.player _meth_8301( 1 );
}

breach_top_off_weapon( var_0 )
{
    var_0 = self _meth_8311();

    if ( should_topoff_breach_weapon() )
    {
        var_1 = weaponclipsize( var_0 );

        if ( self _meth_82F8( var_0 ) < var_1 )
            self _meth_82F6( var_0, var_1 );
    }
}

should_topoff_breach_weapon()
{
    if ( level.gameskill > 1 )
        return 0;

    return 1;
}

breach_slow_down( var_0 )
{
    thread slowmo_begins( 1.0 );
}

enable_player_control( var_0 )
{
    level.player _meth_804F();
    level.player_rig delete();
    maps\_player_exo::player_exo_activate();
    thread facility_breach_cleanup_player();
}

blow_door( var_0 )
{
    level.facility_breach_charge hide();
    var_1 = getent( "facility_breach_door", "targetname" );
    var_2 = getent( "facility_breach_door_clip", "targetname" );
    var_2 _meth_8058();
    var_1 delete();
    var_2 delete();
    level thread maps\lab_fx::mute_breach_explosion();
    level notify( "breach_explosion" );
    level.player_rig hide();
    level.player _meth_831E();
    level.player freezecontrols( 0 );
    _func_0D3( "ammoCounterHide", 0 );
}

slowmo_begins( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.25;

    level.slomobreachduration = 3.5;
    var_1 = 0.5;
    var_2 = 0.75;

    if ( isdefined( level.breaching ) && level.breaching == 1 )
        return;

    level.breaching = 1;
    var_3 = 0.2;

    if ( isdefined( level.slomobreachplayerspeed ) )
        var_3 = level.slomobreachplayerspeed;

    var_4 = level.player;
    common_scripts\utility::flag_clear( "can_save" );
    var_4 _meth_8130( 0 );
    maps\_utility::slowmo_setspeed_slow( var_0 );
    maps\_utility::slowmo_setlerptime_in( var_1 );
    maps\_utility::slowmo_lerp_in();
    var_4 _meth_81E1( var_3 );
    var_5 = gettime();
    var_6 = var_5 + level.slomobreachduration * 1000;
    var_4 thread catch_weapon_switch();
    var_4 thread catch_mission_failed();
    var_7 = 500;
    var_8 = 1000;

    for (;;)
    {
        if ( isdefined( level.forced_slowmo_breach_slowdown ) )
        {
            if ( !level.forced_slowmo_breach_slowdown )
            {
                if ( isdefined( level.forced_slowmo_breach_lerpout ) )
                    var_2 = level.forced_slowmo_breach_lerpout;

                break;
            }

            wait 0.05;
            continue;
        }

        if ( gettime() >= var_6 )
            break;

        if ( level.breachenemies_active <= 0 )
        {
            var_2 = 1.15;
            break;
        }

        if ( !maps\_utility::is_coop() )
        {
            if ( var_4.lastreloadstarttime >= var_5 + var_7 )
                break;

            if ( var_4.switchedweapons && gettime() - var_5 > var_8 )
                break;
        }

        if ( maps\_utility::is_specialop() && common_scripts\utility::flag( "special_op_terminated" ) )
            break;

        if ( var_4.breach_missionfailed )
        {
            var_2 = 0.5;
            break;
        }

        wait 0.05;
    }

    level notify( "slowmo_breach_ending", var_2 );
    level notify( "stop_player_heartbeat" );
    var_4 thread maps\_utility::play_sound_on_entity( "slomo_whoosh" );
    maps\_utility::slowmo_setlerptime_out( var_2 );
    maps\_utility::slowmo_lerp_out();
    var_4 _meth_8130( 1 );
    maps\_utility::slowmo_end();
    common_scripts\utility::flag_set( "can_save" );
    level.player_one_already_breached = undefined;
    var_4 slowmo_player_cleanup();
    var_4 _meth_8304( 1 );
    level notify( "slomo_breach_over" );
    level.breaching = 0;
    _func_0D3( "objectiveHide", 0 );
}

slowmo_player_cleanup()
{
    if ( isdefined( level.playerspeed ) )
        self _meth_81E1( level.playerspeed );
    else
        self _meth_81E1( 1 );
}

breach_enemy_waitfor_death( var_0 )
{
    self endon( "breach_status_change" );
    var_0 waittill( "death" );
    self notify( "breach_status_change", "death" );
}

breach_enemy_waitfor_death_counter( var_0 )
{
    level.breachenemies_alive++;
    var_0 waittill( "death" );
    level.breachenemies_alive--;

    if ( level.breachenemies_alive <= 0 )
        breach_friendlies_restore_grenades();

    level notify( "breach_all_enemies_dead" );
}

breach_enemy_catch_exceptions( var_0 )
{
    self endon( "breach_status_change" );

    while ( isalive( var_0 ) )
        wait 0.05;

    self notify( "breach_status_change", "exception" );
}

breach_enemy_waitfor_breach_ending()
{
    self endon( "breach_status_change" );
    level waittill( "slowmo_breach_ending" );
    self notify( "breach_status_change", "breach_ending" );
}

breach_enemy_track_status( var_0 )
{
    level.breachenemies_active++;
    var_1 = spawnstruct();
    var_1.enemy = var_0;
    var_1 thread breach_enemy_waitfor_death( var_0 );
    var_1 thread breach_enemy_waitfor_death_counter( var_0 );
    var_1 thread breach_enemy_catch_exceptions( var_0 );
    var_1 thread breach_enemy_waitfor_breach_ending();
    var_1 waittill( "breach_status_change", var_2 );
    level.breachenemies_active--;
    var_1 = undefined;
}

catch_mission_failed()
{
    level endon( "slowmo_breach_ending" );
    self.breach_missionfailed = 0;
    level waittill( "mission failed" );
    self.breach_missionfailed = 1;
}

catch_weapon_switch()
{
    level endon( "slowmo_breach_ending" );
    self.switchedweapons = 0;
    common_scripts\utility::waittill_any( "weapon_switch_started", "night_vision_on", "night_vision_off" );
    self.switchedweapons = 1;
}

breach_friendlies_take_grenades()
{
    if ( !isdefined( level.breachfriendlies ) )
        return;

    level.breachfriendlies_grenades_empty = 1;

    foreach ( var_1 in level.breachfriendlies )
    {
        var_1.grenadeammo_prebreach = var_1.grenadeammo;
        var_1.grenadeammo = 0;
    }
}

breach_friendlies_restore_grenades()
{
    if ( !isdefined( level.breachfriendlies ) )
        return;

    if ( !isdefined( level.breachfriendlies_grenades_empty ) )
        return;

    foreach ( var_1 in level.breachfriendlies )
    {
        var_1.grenadeammo = var_1.grenadeammo_prebreach;
        var_1.grenadeammo_prebreach = undefined;
    }

    level.breachfriendlies_grenades_empty = undefined;
}

no_interrupt( var_0 )
{
    level notify( "burke_breach_uninterruptable" );
    common_scripts\utility::flag_set( "flag_burke_kills_guy" );
    level.facility_breach_guys[4].allowdeath = 0;
}

break_glass( var_0 )
{
    glassradiusdamage( var_0.origin, 100, 300, 100 );
}
