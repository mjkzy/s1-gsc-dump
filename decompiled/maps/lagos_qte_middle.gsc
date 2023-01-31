// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

anim_single_solo_d( var_0, var_1 )
{
    maps\_anim::anim_single_solo( var_0, var_1 );
}

anim_single_qte_middle( var_0, var_1, var_2 )
{
    var_3 = var_0[0];
    var_4 = var_0[1];
    thread anim_single_solo_d( var_1[0], var_2 );
    var_4.tag_driver thread anim_single_solo_d( var_1[1], var_2 );
    var_4.tag_driver thread anim_single_solo_d( var_1[2], var_2 );
    var_4.tag_driver thread anim_single_solo_d( var_1[3], var_2 );
    thread anim_single_solo_d( var_0[1], var_2 );

    if ( var_2 == "truck_middle_takedown_pt4" )
    {
        thread anim_single_solo_d( var_0[0], var_2 );
        var_5 = getanimlength( var_0[0] maps\_utility::getanim( var_2 ) );
        var_6 = int( var_5 * 20 );
        wait(var_6 / 20);
    }
    else
        anim_single_solo_d( var_0[0], var_2 );
}

anim_single_qte_middle_fail( var_0, var_1, var_2, var_3 )
{
    var_4 = var_0[0];
    var_5 = var_0[1];
    var_6 = var_1[0];
    var_5.tag_driver thread anim_single_solo_d( var_1[1], var_3 );
    var_5.tag_driver thread anim_single_solo_d( var_1[2], var_3 );
    var_5.tag_driver thread anim_single_solo_d( var_1[3], var_3 );
    thread anim_single_solo_d( var_0[0], var_3 );
    thread anim_single_solo_d( var_0[1], var_3 );
    var_6 _meth_804D( var_4.tag_driver );
    var_4.tag_driver anim_single_solo_d( var_6, var_2 );
}

takedown_qte_middle( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    maps\lagos_utility::start_middle_takedown_highway_path_player_side();
    maps\_utility::delaythread( 0.05, maps\_utility::autosave_now_silent );
    level.hint_nofadein = 1;
    maps\lagos_jump::exo_jump_end();
    common_scripts\utility::flag_set( "suv_takedown_lighting" );
    level.player.old_weapon = level.player _meth_8311();

    if ( level.player.old_weapon == "none" )
    {
        var_7 = level.player _meth_830C();
        level.player.old_weapon = var_7[0];
    }

    level.player _meth_8300( 1 );
    level.player maps\_shg_utility::setup_player_for_scene();
    maps\lagos_utility::disable_exo_for_highway();
    level.player maps\_utility::store_players_weapons( "traffic_weapons" );
    level.player _meth_8310();
    level.player _meth_8130( 0 );
    thread maps\_player_exo::player_exo_deactivate();
    var_0 maps\_anim::anim_first_frame_solo( var_4, "truck_middle_takedown_pt1" );
    level.player _meth_807D( var_4, "tag_player", 1, 7, 7, 5, 5, 1 );
    level.player _meth_80EF();
    level.player _meth_82DD( "gunFired", "+attack" );
    var_6.tag_driver = spawn( "script_origin", ( 0, 0, 0 ) );
    var_6.tag_driver.origin = var_6 gettagorigin( "tag_driver" );
    var_6.tag_driver.angles = var_6 gettagangles( "tag_driver" );
    var_6.tag_driver _meth_804D( var_6 );
    var_5.tag_driver = spawn( "script_origin", ( 0, 0, 0 ) );
    var_5.tag_driver.origin = var_5 gettagorigin( "tag_driver" );
    var_5.tag_driver.angles = var_5 gettagangles( "tag_driver" );
    var_5.tag_driver _meth_804D( var_5 );
    var_1 _meth_804D( var_6.tag_driver );
    var_2 _meth_804D( var_6.tag_driver );
    var_3 _meth_804D( var_6.tag_driver );
    var_8 = [ var_4, var_1, var_2, var_3 ];
    var_9 = [ var_5, var_6 ];
    var_1 maps\_utility::magic_bullet_shield();
    var_2 maps\_utility::magic_bullet_shield();
    var_3 maps\_utility::magic_bullet_shield();

    if ( !isdefined( level.debugstart_post_middle_takedown ) )
    {
        thread truck_middle_takedown_player_shot_enemy_check( "flag_player_shot_enemy", 4.55, var_1, var_2, var_3, var_6 );
        level.player _meth_80A2( 2, 0, 0, 20, 20, 10, -7 );
        thread truck_middle_takedown_middle_player_free_aim( var_4, var_5, var_0, var_9 );
        thread truck_middle_takedown_player_dodge_check( "flag_player_dodge" );
        thread truck_middle_takedown_player_shot_timer( var_9, var_8, "truck_middle_takedown_fail_pt1" );
        player_bus_anim_single_break_when_timeout_or_fail( var_0, var_9, var_8 );

        if ( !common_scripts\utility::flag( "flag_player_shot_enemy" ) )
        {
            truck_middle_takedown_failure();
            truck_middle_takedown_gameover();
            return;
        }

        if ( !common_scripts\utility::flag( "flag_player_dodge" ) )
        {
            truck_middle_takedown_failure();
            var_0 anim_single_qte_middle_fail( var_9, var_8, "truck_middle_takedown_fail_pt2", "truck_middle_takedown_pt2" );
            truck_middle_takedown_gameover();
            return;
        }

        level.player _meth_849C( "gunFired", "+attack" );
        thread truck_middle_takedown_player_jump( "flag_player_jump", 21 );
        var_0 anim_single_qte_middle( var_9, var_8, "truck_middle_takedown_pt2" );

        if ( !common_scripts\utility::flag( "flag_player_jump" ) )
        {
            truck_middle_takedown_failure();
            var_0 anim_single_qte_middle_fail( var_9, var_8, "truck_middle_takedown_fail_pt3", "truck_middle_takedown_pt3" );
            truck_middle_takedown_gameover();
            return;
        }

        var_10 = getnode( "cover_bus_traverse_3", "targetname" );
        level.burke maps\_utility::teleport_ai( var_10 );
        level.burke.ignoreall = 1;
        thread truck_middle_takedown_player_pull_windshield( "flag_player_pull_windshield", 21 );
        var_0 anim_single_qte_middle( var_9, var_8, "truck_middle_takedown_pt3" );

        if ( !common_scripts\utility::flag( "flag_player_pull_windshield" ) )
        {
            truck_middle_takedown_failure();
            var_0 anim_single_qte_middle_fail( var_9, var_8, "truck_middle_takedown_fail_pt4", "truck_middle_takedown_pt4" );
            truck_middle_takedown_gameover();
            return;
        }

        thread truck_middle_takedown_player_jump2( "flag_player_jump2", 21 );
        common_scripts\utility::delay_script_call( 4.5, maps\lagos_utility::post_middle_takedown_highway_path_player_side );
        var_0 thread anim_single_solo_d( level.hit_kva_bus, "truck_middle_takedown_pt5" );
        var_0 anim_single_qte_middle( var_9, var_8, "truck_middle_takedown_pt4" );

        if ( !common_scripts\utility::flag( "flag_player_jump2" ) )
        {
            truck_middle_takedown_failure();
            var_0 anim_single_qte_middle_fail( var_9, var_8, "truck_middle_takedown_fail_pt5", "truck_middle_takedown_pt5" );
            truck_middle_takedown_gameover();
            return;
        }
    }

    common_scripts\utility::flag_set( "flag_player_jump2" );
    soundscripts\_snd::snd_message( "truck_whipeout_anim_begin" );
    thread maps\lagos_utility::post_middle_takedown_highway_path_player_side();
    thread maps\lagos_code::traffic_camera_shake_after_middle_td();
    level.burke maps\lagos_utility::setup_ai_for_bus_sequence();
    level.burke animscripts\utility::setunstableground( 1 );
    level.burke maps\_utility::disable_pain();
    level.burke maps\_utility::disable_surprise();
    level.burke.grenadeammo = 0;
    level.burke.baseaccuracy = 0.15;
    level.burke thread maps\lagos_utility::keep_filling_clip_ammo( 1 );
    level.burke _meth_81A3( 1 );
    level.burke.pushable = 0;
    thread maps\lagos_code::start_bus_moving_before_anim_ends( level.player_bus, "start_bus_traverse_3", 3.7 );
    var_0 anim_single_qte_middle( var_9, var_8, "truck_middle_takedown_pt5" );
    level.kva_truck common_scripts\utility::delaycall( 15, ::delete );
    var_0 common_scripts\utility::delaycall( 15.1, ::delete );
    var_1 maps\_utility::stop_magic_bullet_shield();
    var_2 maps\_utility::stop_magic_bullet_shield();
    var_3 maps\_utility::stop_magic_bullet_shield();
    var_1 delete();
    var_2 delete();
    var_3 delete();
    level.hit_kva_bus delete();
    level.player _meth_807C( level.player_bus.script_origin_roof[1] );
    level.player _meth_83E8( undefined );
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player _meth_8130( 1 );
    level.player maps\_utility::restore_players_weapons( "traffic_weapons" );
    thread maps\_player_exo::player_exo_activate();
    level.player _meth_8481();
    level.player _meth_8300( 1 );
    level.player _meth_8316( level.player.old_weapon );
    level.player _meth_804F();
    var_11 = getvehiclenode( "start_bus_traverse_3", "targetname" );
    level.player_bus _meth_827F( var_11 );
    level.player notify( "qte_done" );
    waitframe();
    var_10 = getnode( "cover_bus_traverse_3", "targetname" );
    level.burke maps\_utility::teleport_ai( var_10 );
    level.burke.ignoreall = 0;
    maps\_utility::autosave_by_name();
    thread maps\lagos_jump::exo_jump_process();
    common_scripts\utility::flag_set( "flag_middle_takedown_complete" );
    common_scripts\utility::flag_set( "flag_player_traversing_traffic" );
    thread maps\lagos_code::traffic_traverse_fail_check();
    level.player _meth_80F0();
    var_4 delete();
    level.hint_nofadein = undefined;
    level.kva_dead_count = undefined;
    level.player.old_weapon = undefined;
}

player_bus_anim_single_break_when_timeout_or_fail( var_0, var_1, var_2 )
{
    level.player endon( "part1_done" );
    var_0 anim_single_qte_middle( var_1, var_2, "truck_middle_takedown_pt1" );
    level.player notify( "part1_done" );
}

truck_middle_takedown_player_shot_timer( var_0, var_1, var_2 )
{
    var_3 = var_0[0];
    var_4 = var_0[1];
    var_5 = var_1[0];
    wait 12.5;

    if ( level.kva_dead_count < 2 )
    {
        level.player notify( "part1_done" );
        earthquake( 0.5, 0.1, level.player.origin, 300000 );
        wait 0.1;
        level.player _meth_831D();
        var_5 _meth_804D( var_3.tag_driver );
        var_3.tag_driver anim_single_solo_d( var_5, var_2 );
        level.player _meth_8051( level.player.maxhealth, var_4.origin );
    }
}

truck_middle_takedown_player_shot_enemy_check( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    level.player endon( "part1_done" );
    var_3 thread maps\lagos_qte::kva_fake_death_checker( var_5, "truck_middle_takedown_death_guy1" );
    var_4 thread maps\lagos_qte::kva_fake_death_checker( var_5, "truck_middle_takedown_death_guy3" );
    thread truck_middle_takedown_set_normal_time_if_gun_fired();

    for (;;)
    {
        level.kva_dead_count = 0;

        if ( !isalive( var_3 ) || var_3.fake_death )
            level.kva_dead_count++;

        if ( !isalive( var_4 ) || var_4.fake_death )
            level.kva_dead_count++;

        if ( level.kva_dead_count >= 2 )
        {
            maps\lagos_qte::hostage_truck_slomo_end( 1 );
            common_scripts\utility::flag_set( var_0 );
            break;
        }

        waitframe();
    }

    level.player notify( "set_normal_time_if_gun_fired_kill_middle" );
}

truck_middle_takedown_set_normal_time_if_gun_fired()
{
    level.player endon( "part1_done" );

    for (;;)
    {
        level.player waittill( "gunFired" );
        maps\lagos_qte::hostage_truck_slomo_end( 1 );
        waitframe();
    }
}

doclamping_middle()
{
    wait 4;
    level.player _meth_80A2( 1, 0.25, 0.25, 0, 0, 0, 0 );
}

player_allow_damage( var_0 )
{
    level.player notify( "player_allow_damage_one_thread_only" );
    level.player endon( "player_allow_damage_one_thread_only" );

    if ( var_0 )
    {
        wait 1;

        for (;;)
        {
            level.player _meth_80F0();
            level.player _meth_80EC( 1 );
            wait(randomfloatrange( 0.25, 0.5 ));
            level.player _meth_80EF();
            level.player _meth_80EC( 0 );
            wait(randomfloatrange( 0.25, 0.5 ));
        }
    }
    else
    {
        level.player _meth_80EF();
        level.player _meth_80EC( 0 );
    }
}

truck_middle_takedown_middle_player_free_aim( var_0, var_1, var_2, var_3 )
{
    level.player endon( "qte_done" );
    level.player endon( "qte_fail" );
    thread doclamping_middle();
    common_scripts\utility::flag_set( "suv_takedown_shoot_lighting" );
    var_4 = 0.7;
    var_5 = "iw5_titan45lagostruckmiddletakedown_sp";

    for (;;)
    {
        level.player waittill( "do_viewmodel_swap" );
        var_0 _meth_804A();
        var_0.hidden = 1;
        level.player _meth_831E();
        level.player _meth_8482();
        level.player _meth_830E( var_5 );
        level.player _meth_8315( var_5 );
        wait 0.7;
        level.player _meth_8481();
        level.player thread player_allow_damage( 1 );
        level.player _meth_830E( var_5 );
        level.player _meth_8316( var_5 );
        level.player _meth_83E8( var_0 );
        level.player playerrecoilscaleon( 0 );
        level.player _meth_80A2( 0.05, 0.25, 0.25, 25, 40, 22.5, 22.5 );
        level.player _meth_8130( 0 );
        soundscripts\_snd::snd_message( "middle_takedown_gun_up" );
        level.player waittill( "do_viewmodel_swap" );
        level.player _meth_8130( 0 );
        level.player thread player_allow_damage( 0 );
        level.player _meth_80A2( 2, 0, 0, 20, 20, 10, -7 );
        level.player playerrecoilscaleon( 1 );
        level.player _meth_831D();
        wait(var_4);
        level.player _meth_8482();
        level.player _meth_830F( var_5 );
        var_0 _meth_804C();
        var_4 = 1.1;
        var_5 = "iw5_titan45lagostruckmiddletakedown2_sp";
    }
}

truck_middle_takedown_player_dodge_check( var_0 )
{
    level.player waittill( "qte_prompt" );

    if ( level.kva_dead_count < 2 )
        return;

    var_1 = level.kva_truck maps\_shg_utility::hint_button_tag( "a", "tag_headlight_right", 900, 900 );
    common_scripts\utility::flag_set( "suv_takedown_dodge_lighting" );
    maps\lagos_qte::wait_for_flag_or_player_command( "flag_truck_middle_takedown_is_failure", "+gostand" );
    var_1 maps\_shg_utility::hint_button_clear();

    if ( common_scripts\utility::flag( "flag_truck_middle_takedown_is_failure" ) )
        return;

    maps\lagos_qte::hostage_truck_slomo_end( 1 );
    common_scripts\utility::flag_set( var_0 );
    soundscripts\_snd::snd_message( "truck_middle_dodge_slowmo_end" );
}

truck_middle_takedown_player_jump( var_0, var_1 )
{
    level.player waittill( "qte_prompt" );
    var_2 = level.kva_truck maps\_shg_utility::hint_button_tag( "a", "tag_hood", 900, 900 );
    common_scripts\utility::flag_set( "suv_takedown_jump_lighting" );
    maps\lagos_qte::wait_for_flag_or_player_command( "flag_truck_middle_takedown_is_failure", "+gostand" );
    var_2 maps\_shg_utility::hint_button_clear();

    if ( common_scripts\utility::flag( "flag_truck_middle_takedown_is_failure" ) )
        return;

    maps\lagos_qte::hostage_truck_slomo_end( 1 );
    common_scripts\utility::flag_set( var_0 );
    soundscripts\_snd::snd_message( "truck_middle_jump_slowmo_end" );
}

truck_middle_takedown_player_pull_windshield( var_0, var_1 )
{
    level.player waittill( "qte_prompt" );
    var_2 = level.kva_truck maps\_shg_utility::hint_button_tag( "melee", "winsmash_l", 900, 900 );
    common_scripts\utility::flag_set( "suv_takedown_windshield_lighting" );
    var_3 = _func_2C6();
    var_4 = undefined;

    if ( issubstr( var_3, "buttons_default" ) || issubstr( var_3, "buttons_tactical" ) )
        var_4 = "+melee_zoom";
    else if ( issubstr( var_3, "buttons_lefty" ) || issubstr( var_3, "buttons_nomad" ) )
        var_4 = "+melee_breath";
    else if ( issubstr( var_3, "buttons_nomad_tactical" ) )
        var_4 = "+stance";

    maps\lagos_qte::wait_for_flag_or_player_command( "flag_truck_middle_takedown_is_failure", var_4 );
    var_2 maps\_shg_utility::hint_button_clear();

    if ( common_scripts\utility::flag( "flag_truck_middle_takedown_is_failure" ) )
        return;

    maps\lagos_qte::hostage_truck_slomo_end( 1 );
    common_scripts\utility::flag_set( var_0 );
    soundscripts\_snd::snd_message( "truck_middle_punch_slowmo_end" );
}

truck_middle_takedown_player_jump2( var_0, var_1 )
{
    level.player waittill( "qte_prompt" );
    var_2 = level.player_bus maps\_shg_utility::hint_button_tag( "a", "tag_roof_b", 900, 900 );
    common_scripts\utility::flag_set( "suv_takedown_jump2_lighting" );
    maps\lagos_qte::wait_for_flag_or_player_command( "flag_truck_middle_takedown_is_failure", "+gostand" );
    var_2 maps\_shg_utility::hint_button_clear();

    if ( common_scripts\utility::flag( "flag_truck_middle_takedown_is_failure" ) )
        return;

    maps\lagos_qte::hostage_truck_slomo_end( 1 );
    common_scripts\utility::flag_set( var_0 );
    soundscripts\_snd::snd_message( "truck_middle_jump2_slowmo_end" );
}

truck_middle_takedown_failure()
{
    level.player notify( "qte_fail" );
    common_scripts\utility::flag_set( "flag_truck_middle_takedown_is_failure" );
    maps\lagos_qte::hostage_truck_slomo_end();
    level.player _meth_83E8( undefined );
}

truck_middle_takedown_gameover()
{
    setdvar( "ui_deadquote", "" );
    maps\_utility::missionfailedwrapper();
    level waittill( "forever" );
}

#using_animtree("vehicles");

setup_vehicles_for_middle_takedown()
{
    level.player_bus.animname = "player_bus";
    level.player_bus _meth_8115( #animtree );
    level.kva_truck = getent( "kva_truck_middle_takedown", "targetname" );
    level.kva_truck.animname = "kva_truck";
    level.kva_truck _meth_8115( #animtree );
    level.hit_kva_bus = maps\_vehicle::spawn_vehicle_from_targetname( "hit_kva_bus" );
    level.hit_kva_bus.animname = "hit_kva_bus";
    level.hit_kva_bus _meth_8115( #animtree );
    level thread maps\lagos_fx::middle_takedown_tread_fx();
}

notify_qte_prompt_and_slowmo( var_0 )
{
    level.player endon( "qte_success_message" );

    if ( level.kva_dead_count < 2 )
        return;

    level.player notify( "qte_prompt" );
    waitframe();
    soundscripts\_snd::snd_message( "notify_qte_prompt_and_slowmo" );
    var_1 = 0.095;
    var_2 = 0.095;
    var_3 = 0.2;
    maps\lagos_qte::hostage_truck_slomo_start( var_1, var_2, var_3 );
}

player_bus_slomo_end_notetrack( var_0 )
{
    level.player notify( "slowmo_end" );
    maps\lagos_qte::hostage_truck_slomo_end( 0 );
}

player_bus_slomo_start_pt1( var_0 )
{
    soundscripts\_snd::snd_message( "player_bus_slomo_start_pt1" );
    var_1 = 0.095;
    var_2 = 0.095;
    var_3 = 0.2;
    maps\lagos_qte::hostage_truck_slomo_start( var_1, var_2, var_3 );
}

player_bus_slomo_start_pt2( var_0 )
{
    soundscripts\_snd::snd_message( "player_bus_slomo_start_pt2" );
    var_1 = 0.1;
    var_2 = 0.1;
    var_3 = 0.2;
    maps\lagos_qte::hostage_truck_slomo_start( var_1, var_2, var_3 );
}

player_bus_slomo_end_pt2( var_0 )
{
    soundscripts\_snd::snd_message( "player_bus_slomo_end_pt2" );
    player_bus_slomo_end_notetrack( var_0 );
}

player_bus_slomo_start_pt3( var_0 )
{
    soundscripts\_snd::snd_message( "player_bus_slomo_start_pt3" );
    var_1 = 0.095;
    var_2 = 0.095;
    var_3 = 0.2;
    maps\lagos_qte::hostage_truck_slomo_start( var_1, var_2, var_3 );
}

player_bus_slomo_start_pt4( var_0 )
{
    soundscripts\_snd::snd_message( "player_bus_slomo_start_pt4" );
    var_1 = 0.095;
    var_2 = 0.095;
    var_3 = 0.2;
    maps\lagos_qte::hostage_truck_slomo_start( var_1, var_2, var_3 );
}

player_bus_slomo_start_pt5( var_0 )
{
    soundscripts\_snd::snd_message( "player_bus_slomo_start_pt5" );
    var_1 = 0.095;
    var_2 = 0.095;
    var_3 = 0.2;
    maps\lagos_qte::hostage_truck_slomo_start( var_1, var_2, var_3 );
}

notetrack_unlink_and_start_ragdoll( var_0 )
{
    var_0 _meth_804F();
    var_0 _meth_8023();
}

notetrack_unlink( var_0 )
{
    var_0 _meth_804F();
    var_1 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_1.origin = level.player.origin;
    var_0 _meth_804D( var_1 );
}

qte_middle_shoot_off()
{
    var_0 = "BUTTON_RTRIG";

    if ( !level.console && !level.player common_scripts\utility::is_player_gamepad_enabled() )
        var_0 = "mouse1";

    if ( level.player _meth_824C( var_0 ) || isdefined( level.player.remove_hint ) && level.player.remove_hint == &"LAGOS_QTE_MIDDLE_SHOOT_KVA" )
        return 1;

    return 0;
}

qte_middle_dodge_off()
{
    if ( level.player usebuttonpressed() || isdefined( level.player.remove_hint ) && level.player.remove_hint == &"LAGOS_QTE_MIDDLE_DODGE" )
        return 1;

    return 0;
}

qte_middle_jump_off()
{
    if ( level.player _meth_83DE() || isdefined( level.player.remove_hint ) && level.player.remove_hint == &"LAGOS_QTE_MIDDLE_JUMP" )
        return 1;

    return 0;
}

qte_middle_pull_windshield_off()
{
    if ( level.player usebuttonpressed() || isdefined( level.player.remove_hint ) && level.player.remove_hint == &"LAGOS_QTE_MIDDLE_PULL_WINDSHIELD" )
        return 1;

    return 0;
}

qte_middle_pull_kva_off()
{
    var_0 = "BUTTON_RTRIG";

    if ( !level.console && !level.player common_scripts\utility::is_player_gamepad_enabled() )
        var_0 = "mouse1";

    if ( level.player _meth_824C( var_0 ) || isdefined( level.player.remove_hint ) && level.player.remove_hint == &"LAGOS_QTE_MIDDLE_PULL_KVA" )
        return 1;

    return 0;
}
