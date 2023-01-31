// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setup_vo();
    init_dialogue_flags();
    thread start_dialogue_threads();
    thread init_pcap_vo();
}

setup_vo()
{
    var_0 = "gideon_mech";
    var_1 = "gideon";
    level.scr_radio["fin_mchl_itwasaplanonlygideon"] = "fin_mchl_itwasaplanonlygideon";
    level.scr_radio["fin_kgn_sentineltwoonewearestill"] = "fin_kgn_sentineltwoonewearestill";
    level.scr_sound[var_0]["fin_gdn_copythatkingpin2"] = "fin_gdn_copythatkingpin2";
    level.scr_sound[var_0]["fin_gdn_whataboutdronesupport"] = "fin_gdn_whataboutdronesupport";
    level.scr_radio["fin_kgn_negativetwooneallunmannedassets"] = "fin_kgn_negativetwooneallunmannedassets";
    level.scr_sound[var_0]["fin_gdn_copythat"] = "fin_gdn_copythat";
    level.scr_radio["fin_iln1_youvegotattackboatsclosing"] = "fin_iln1_youvegotattackboatsclosing";
    level.scr_sound[var_0]["fin_gdn_iseeem"] = "fin_gdn_iseeem";
    level.scr_sound[var_0]["fin_gdn_enemiesontheoverpass"] = "fin_gdn_enemiesontheoverpass";
    level.scr_sound[var_0]["fin_gdn_moreboatsbelowus"] = "fin_gdn_moreboatsbelowus";
    level.scr_sound[var_0]["fin_gdn_goodhit"] = "fin_gdn_goodhit";
    level.scr_sound[var_0]["fin_gdn_moreboatsinbound"] = "fin_gdn_moreboatsinbound";
    level.scr_sound[var_0]["fin_gdn_keepfiring"] = "fin_gdn_keepfiring";
    level.scr_sound[var_0]["fin_gdn_mitchellhitthosedamnboats"] = "fin_gdn_mitchellhitthosedamnboats";
    level.scr_radio["fin_iln1_meterstodroppoint"] = "fin_iln1_meterstodroppoint";
    level.scr_sound[var_0]["fin_gdn_watersclear"] = "fin_gdn_watersclear";
    level.scr_sound[var_0]["fin_iln1_thisitisdetachnow"] = "fin_iln1_thisitisdetachnow";
    level.scr_sound[var_0]["fin_iln1_michelldetach"] = "fin_iln1_michelldetach";
    level.scr_sound[var_0]["fin_iln1_dropnowmitchell"] = "fin_iln1_dropnowmitchell";
    level.scr_sound[var_0]["fin_gdn_breachpointisupahead"] = "fin_gdn_breachpointisupahead";
    level.scr_radio["fin_iln1_gideonthermalreadingsarespiking"] = "fin_iln1_gideonthermalreadingsarespiking";
    level.scr_sound[var_0]["fin_gdn_wellmakeit"] = "fin_gdn_wellmakeit";
    level.scr_sound[var_0]["fin_gdn_mitchellonme"] = "fin_gdn_mitchellonme";
    level.scr_sound[var_0]["fin_gdn_ilonawereinside"] = "fin_gdn_ilonawereinside";
    level.scr_radio["fin_iln1_youshouldberightnext"] = "fin_iln1_youshouldberightnext";
    level.scr_radio["fin_pa_securitybreachinthesilo"] = "fin_pa_securitybreachinthesilo";
    level.scr_radio["fin_pa_intrudersinsectorfour"] = "fin_pa_intrudersinsectorfour";
    level.scr_sound[var_0]["fin_gdn_contact"] = "fin_gdn_contact";
    level.scr_sound[var_0]["fin_gdn_ilonathemissilesshielded"] = "fin_gdn_ilonathemissilesshielded";
    level.scr_radio["fin_iln1_headdown"] = "fin_iln1_headdown";
    level.scr_sound[var_0]["fin_gdn_copy2"] = "fin_gdn_copy2";
    level.scr_sound[var_0]["fin_gdn_downthestairs"] = "fin_gdn_downthestairs";
    level.scr_sound[var_0]["fin_gdn_keepmovingforward"] = "fin_gdn_keepmovingforward";
    level.scr_sound[var_0]["fin_gdn_theyregoingtolaunch"] = "fin_gdn_theyregoingtolaunch";
    level.scr_sound[var_0]["fin_gdn_astsaheadtargetthemfirst"] = "fin_gdn_astsaheadtargetthemfirst";
    level.scr_radio["fin_iln1_theresanaccesspointto"] = "fin_iln1_theresanaccesspointto";
    level.scr_sound[var_0]["fin_gdn_gotitkeeppushingforward"] = "fin_gdn_gotitkeeppushingforward";
    level.scr_radio["fin_pa_launchintminus5minutes"] = "fin_pa_launchintminus5minutes";
    level.scr_radio["fin_pa_launchintminus4minutes"] = "fin_pa_launchintminus4minutes";
    level.scr_radio["fin_pa_launchintminus3minutes"] = "fin_pa_launchintminus3minutes";
    level.scr_radio["fin_pa_launchintminus2minutes"] = "fin_pa_launchintminus2minutes";
    level.scr_radio["fin_pa_launchintminus1minute"] = "fin_pa_launchintminus1minute";
    level.scr_radio["fin_pa_stage3boosterscheckcomplete"] = "fin_pa_stage3boosterscheckcomplete";
    level.scr_radio["fin_pa_cargoloadinginprogress"] = "fin_pa_cargoloadinginprogress";
    level.scr_radio["fin_pa_cargoloadingcomplete"] = "fin_pa_cargoloadingcomplete";
    level.scr_sound[var_0]["fin_gdn_theresthehatch"] = "fin_gdn_theresthehatch";
    level.scr_sound[var_0]["fin_gdn_mitchellopenthehatch"] = "fin_gdn_mitchellopenthehatch";
    level.scr_sound[var_0]["fin_gdn_needyourhelpmitchell"] = "fin_gdn_needyourhelpmitchell";
    level.scr_sound[var_0]["fin_gdn_go3"] = "fin_gdn_go3";
    level.scr_radio["fin_iln1_gideonthelaunchisstarting"] = "fin_iln1_gideonthelaunchisstarting";
    level.scr_radio["fin_pa_beginprimaryignitionin5"] = "fin_pa_beginprimaryignitionin5";
    level.scr_sound[var_0]["fin_gdn_braceyourself"] = "fin_gdn_braceyourself";
    level.scr_sound[var_0]["fin_gdn_keepgoing"] = "fin_gdn_keepgoing";
    level.scr_sound[var_0]["fin_gdn_hititwitheverythingyouve"] = "fin_gdn_hititwitheverythingyouve";
    level.scr_sound[var_0]["fin_gdn_shoottheengines"] = "fin_gdn_shoottheengines";
    level.scr_sound[var_0]["fin_gdn_shootitmitchell"] = "fin_gdn_shootitmitchell";
    level.scr_sound[var_0]["fin_gdn_hittheenginesmitchell"] = "fin_gdn_hittheenginesmitchell";
    level.scr_sound[var_0]["fin_gdn_thatsitkeepshooting"] = "fin_gdn_thatsitkeepshooting";
    level.scr_sound[var_0]["fin_gdn_takeoutthemissilesengines"] = "fin_gdn_takeoutthemissilesengines";
    level.scr_sound[var_0]["fin_gdn_thatsit"] = "fin_gdn_thatsit";
    level.scr_sound[var_1]["fin_gdn_holdthemoff"] = "fin_gdn_holdthemoff";
    level.scr_sound[var_1]["fin_gdn_morecomingin"] = "fin_gdn_morecomingin";
    level.scr_sound[var_1]["fin_gdn_gottakeepmoving"] = "fin_gdn_gottakeepmoving";
    level.scr_radio["fin_kgn_sentineltwoonecitydefensesare"] = "fin_kgn_sentineltwoonecitydefensesare";
    level.scr_sound[var_1]["fin_gdn_copythatkingpin"] = "fin_gdn_copythatkingpin";
    level.scr_radio["fin_kgn_static"] = "fin_kgn_static";
    level.scr_sound[var_1]["fin_gdn_ilonaareyoureceiving"] = "fin_gdn_ilonaareyoureceiving";
    level.scr_radio["fin_iln1_static"] = "fin_iln1_static";
    level.scr_sound[var_1]["fin_gdn_damnwerecutoff"] = "fin_gdn_damnwerecutoff";
    level.scr_sound[var_1]["fin_gdn_imsettingyoudown"] = "fin_gdn_imsettingyoudown";
    level.scr_sound[var_1]["fin_gdn_needtofindsomelight"] = "fin_gdn_needtofindsomelight";
    level.scr_sound[var_1]["fin_gdn_dontletironsgetaway"] = "fin_gdn_dontletironsgetaway";
    level.scr_sound[var_1]["fin_gdn_hurrymitchell"] = "fin_gdn_hurrymitchell";
    level.scr_sound[var_1]["fin_gdn_keepgoing2"] = "fin_gdn_keepgoing2";
}

init_dialogue_flags()
{
    common_scripts\utility::flag_init( "flag_dialogue_intro_black_complete" );
    common_scripts\utility::flag_init( "flag_dialogue_se_will_reveal" );
    common_scripts\utility::flag_init( "flag_dialogue_gideon_canal_breach_ready" );
    common_scripts\utility::flag_init( "flag_dialogue_canal_breach_complete" );
    common_scripts\utility::flag_init( "flag_dialogue_ast_ahead" );
    common_scripts\utility::flag_init( "flag_dialogue_launch_coundown_complete" );
    common_scripts\utility::flag_init( "flag_dialogue_exhaust_hatch" );
    common_scripts\utility::flag_init( "flag_dialogue_carry_scene_01" );
    common_scripts\utility::flag_init( "flag_dialogue_carry_scene_02" );
    common_scripts\utility::flag_init( "flag_dialogue_carry_scene_02_complete" );
}

start_dialogue_threads()
{
    switch ( level.start_point )
    {
        case "default":
        case "intro":
            dialogue_intro_black();
        case "intro_skip":
            dialogue_intro();
            dialogue_overpass();
            dialogue_more_boats();
            thread dialogue_boat_destroyed();
            thread dialogue_water_clear();
            dialogue_approaching_drop_point();
            dialogue_ready_to_drop();
        case "canal":
            dialogue_canal_start();
            dialogue_breach_ahead();
        case "canal_breach":
            dialogue_breach_complete();
        case "silo_approach":
            thread dialogue_pa_security_breach();
            dialogue_silo_contact();
            dialogue_head_to_exhaust_vent();
            dialogue_keep_moving();
        case "silo_floor_03":
            thread dialogue_pa_launch_coundown();
            dialogue_ast_ahead();
        case "silo_door_kick":
            dialogue_hatch_position();
        case "silo_exhaust_entrance":
            dialogue_exhaust_hatch();
            dialogue_into_exhaust_hatch();
            dialogue_missile_launch();
            dialogue_missile_damage();
        case "lobby":
            dialogue_carry_scene_01();
        case "sky_bridge":
            dialogue_carry_scene_02();
        case "will_room":
            dialogue_will_revael();
        case "irons_chase":
            dialogue_chase_irons();
        case "roof":
            dialogue_irons_ending();
            break;
        default:
    }
}

dialogue_intro_black()
{
    common_scripts\utility::flag_wait( "flag_chyron_finale_complete" );
    wait 1;
    soundscripts\_snd::snd_music_message( "mitchell_vo_intro" );
    level maps\_utility::dialogue_queue( "fin_mchl_itwasaplanonlygideon" );
    wait 0.25;
    common_scripts\utility::flag_set( "flag_dialogue_intro_black_complete" );
    soundscripts\_snd::snd_music_message( "game_play_begin" );
}

dialogue_intro()
{
    common_scripts\utility::flag_wait( "flag_intro_screen_complete" );
    level maps\_utility::dialogue_queue( "fin_kgn_sentineltwoonewearestill" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_copythatkingpin2" );
    level maps\_utility::dialogue_queue( "fin_iln1_youvegotattackboatsclosing" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_iseeem" );
    soundscripts\_snd::snd_music_message( "weapons_free" );
}

dialogue_overpass()
{
    common_scripts\utility::flag_wait( "flag_combat_flyin_bridge_01" );
    wait 3;
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_enemiesontheoverpass" );
}

dialogue_more_boats()
{
    common_scripts\utility::flag_wait( "flag_chase_boats_path_02" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_moreboatsbelowus" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_keepfiring" );
    wait 4;

    if ( !common_scripts\utility::flag( "flag_boat_single_dead" ) )
        level.gideon maps\_utility::dialogue_queue( "fin_gdn_mitchellhitthosedamnboats" );
}

dialogue_boat_destroyed()
{
    common_scripts\utility::flag_wait( "flag_boat_single_dead" );
    wait 1;

    if ( !common_scripts\utility::flag( "flag_intro_flyin_release" ) )
        level.gideon maps\_utility::dialogue_queue( "fin_gdn_goodhit" );
}

dialogue_water_clear()
{
    common_scripts\utility::flag_wait_all( "flag_boat_canal_dead", "flag_intro_flyin_200_to_drop", "flag_intro_flyin_approaching_drop" );
    wait 2;

    if ( !common_scripts\utility::flag( "flag_intro_flyin_release" ) )
        level.gideon maps\_utility::dialogue_queue( "fin_gdn_watersclear" );
}

dialogue_approaching_drop_point()
{
    common_scripts\utility::flag_wait( "flag_intro_flyin_200_to_drop" );
    level notify( "aud_intro_flight_arrive_hover" );
    level maps\_utility::dialogue_queue( "fin_iln1_meterstodroppoint" );
}

dialogue_ready_to_drop()
{
    level endon( "flag_intro_flyin_release" );
    common_scripts\utility::flag_wait( "flag_intro_flyin_done" );

    if ( !common_scripts\utility::flag( "flag_intro_flyin_release" ) )
        level.gideon maps\_utility::dialogue_queue( "fin_iln1_thisitisdetachnow" );

    wait 2;

    if ( !common_scripts\utility::flag( "flag_intro_flyin_release" ) )
        level.gideon maps\_utility::dialogue_queue( "fin_iln1_michelldetach" );

    wait 2;

    if ( !common_scripts\utility::flag( "flag_intro_flyin_release" ) )
        level.gideon maps\_utility::dialogue_queue( "fin_iln1_dropnowmitchell" );
}

dialogue_canal_start()
{
    common_scripts\utility::flag_wait( "flag_intro_flyin_release" );
    wait 8;
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_whataboutdronesupport" );
    level maps\_utility::dialogue_queue( "fin_kgn_negativetwooneallunmannedassets" );
    level maps\_utility::dialogue_queue( "fin_kgn_ifyoudontthinkyou" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_copythat" );
}

dialogue_breach_ahead()
{
    common_scripts\utility::flag_wait( "flag_dialogue_breach_ahead" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_breachpointisupahead" );
    level maps\_utility::dialogue_queue( "fin_iln1_gideonthermalreadingsarespiking" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_wellmakeit" );
}

dialogue_breach_complete()
{
    common_scripts\utility::flag_wait( "flag_obj_enter_silo_update" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_mitchellonme" );
    common_scripts\utility::flag_wait( "flag_dialogue_canal_breach_complete" );
    wait 3;
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_ilonawereinside" );
    level maps\_utility::dialogue_queue( "fin_iln1_youshouldberightnext" );
}

dialogue_pa_security_breach()
{
    wait 3;

    while ( !common_scripts\utility::flag( "flag_combat_silo_floor_02" ) )
    {
        level maps\_utility::dialogue_queue( "fin_pa_securitybreachinthesilo" );
        wait 8;
        level maps\_utility::dialogue_queue( "fin_pa_intrudersinsectorfour" );
        wait 8;
    }

    wait 0.05;
}

dialogue_silo_contact()
{
    common_scripts\utility::flag_wait( "flag_combat_silo_entrance" );
    wait 1;
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_contact" );
    soundscripts\_snd::snd_music_message( "post_underwater_combat_begin" );
}

dialogue_head_to_exhaust_vent()
{
    common_scripts\utility::flag_wait( "flag_combat_silo_floor_02" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_ilonathemissilesshielded" );
    level maps\_utility::dialogue_queue( "fin_iln1_headdown" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_copy2" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_downthestairs" );
    wait 0.5;
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_keepmovingforward" );
}

dialogue_keep_moving()
{
    common_scripts\utility::flag_wait( "flag_combat_silo_floor_02_retreat" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_theyregoingtolaunch" );
}

dialogue_pa_launch_coundown()
{
    level endon( "flag_exhaust_hatch_open" );
    common_scripts\utility::flag_wait( "flag_missile_move_start" );
    soundscripts\_snd::snd_music_message( "timer_begin" );
    level thread maps\_utility::dialogue_queue( "fin_pa_launchintminus4minutes" );
    wait 15;
    level thread maps\_utility::dialogue_queue( "fin_pa_cargoloadinginprogress" );
    wait 45;
    level thread maps\_utility::dialogue_queue( "fin_pa_launchintminus3minutes" );
    wait 5;
    level thread maps\_utility::dialogue_queue( "fin_pa_cargoloadingcomplete" );
    wait 55;
    level thread maps\_utility::dialogue_queue( "fin_pa_launchintminus2minutes" );
    wait 10;
    level thread maps\_utility::dialogue_queue( "fin_pa_stage3boosterscheckcomplete" );
    wait 50;
    level thread maps\_utility::dialogue_queue( "fin_pa_launchintminus1minute" );
    wait 60;
    common_scripts\utility::flag_set( "flag_dialogue_launch_coundown_complete" );
}

dialogue_ast_ahead()
{
    common_scripts\utility::flag_wait( "flag_dialogue_ast_ahead" );
    wait 3;

    if ( !common_scripts\utility::flag( "flag_countdown_complete_mission_fail" ) )
    {
        level.gideon maps\_utility::dialogue_queue( "fin_gdn_astsaheadtargetthemfirst" );
        soundscripts\_snd::snd_music_message( "ast_combat_begin" );
    }
}

dialogue_hatch_position()
{
    common_scripts\utility::flag_wait( "flag_silo_exit" );

    if ( !common_scripts\utility::flag( "flag_countdown_complete_mission_fail" ) )
    {
        soundscripts\_snd::snd_music_message( "post_door_kick" );
        level maps\_utility::dialogue_queue( "fin_iln1_theresanaccesspointto" );
    }

    common_scripts\utility::flag_set( "flag_obj_exhaust_hatch_position" );

    if ( !common_scripts\utility::flag( "flag_countdown_complete_mission_fail" ) )
        level.gideon maps\_utility::dialogue_queue( "fin_gdn_gotitkeeppushingforward" );
}

dialogue_exhaust_hatch()
{
    level endon( "flag_exhaust_hatch_grab" );
    level endon( "flag_countdown_complete_mission_fail" );
    common_scripts\utility::flag_wait( "flag_dialogue_exhaust_hatch" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_theresthehatch" );
    soundscripts\_snd::snd_music_message( "hatch_scene_begin" );
    common_scripts\utility::flag_wait( "flag_obj_exhaust_hatch_open" );

    while ( !common_scripts\utility::flag( "flag_exhaust_hatch_grab" ) )
    {
        wait 4;
        level.gideon maps\_utility::dialogue_queue( "fin_gdn_mitchellopenthehatch" );
        wait 8;
        level.gideon maps\_utility::dialogue_queue( "fin_gdn_needyourhelpmitchell" );
        wait 4;
    }

    wait 0.05;
}

dialogue_into_exhaust_hatch()
{
    level.player endon( "free_fall_done" );
    common_scripts\utility::flag_wait( "flag_exhaust_hatch_open" );
    wait 10.5;

    if ( !common_scripts\utility::flag( "flag_countdown_complete_mission_fail" ) )
        level.gideon maps\_utility::dialogue_queue( "fin_gdn_go3" );
}

dialogue_missile_launch()
{
    common_scripts\utility::flag_wait( "flag_player_exhaust_corridor" );
    level.player waittill( "notetrack_aud_countdown_start" );
    level maps\_utility::dialogue_queue( "fin_iln1_gideonthelaunchisstarting" );
    dialogue_primary_ignitionin();
    wait 18;
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_keepgoing" );
}

dialogue_primary_ignitionin()
{
    level maps\_utility::dialogue_queue( "fin_pa_beginprimaryignitionin5" );

    if ( !common_scripts\utility::flag( "flag_countdown_complete_mission_fail" ) )
        level.gideon maps\_utility::dialogue_queue( "fin_gdn_braceyourself" );
}

dialogue_missile_damage()
{
    level endon( "flag_missile_failed" );
    level endon( "flag_exhaust_corridor_timer_fail" );
    common_scripts\utility::flag_wait( "flag_player_shoot_missile" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_hititwitheverythingyouve" );
    var_0 = [ "fin_gdn_shoottheengines", "fin_gdn_shootitmitchell", "fin_gdn_hittheenginesmitchell", "fin_gdn_takeoutthemissilesengines" ];
    maps\_shg_utility::dialogue_reminder( level.gideon, "flag_missile_hit", var_0, 1.5, 3 );
    common_scripts\utility::flag_wait( "flag_missile_hit" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_thatsitkeepshooting" );
    maps\_shg_utility::dialogue_reminder( level.gideon, "flag_missile_damaged", var_0, 1.5, 3 );
    common_scripts\utility::flag_wait( "flag_missile_damaged" );

    if ( !common_scripts\utility::flag( "flag_missile_failed" ) )
    {
        level.gideon maps\_utility::dialogue_queue( "fin_gdn_thatsit" );
        soundscripts\_snd::snd_music_message( "missile_disabled" );
    }
}

dialogue_carry_scene_01()
{
    common_scripts\utility::flag_wait( "flag_dialogue_carry_scene_01" );
    wait 5;
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_morecomingin" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_holdthemoff" );
    soundscripts\_snd::snd_music_message( "lobby_combat_begin" );
    common_scripts\utility::flag_wait( "flag_lobby_clear" );
    wait 2.5;
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_gottakeepmoving" );
}

dialogue_carry_scene_02()
{
    common_scripts\utility::flag_wait( "flag_dialogue_carry_scene_02" );
    level maps\_utility::dialogue_queue( "fin_kgn_sentineltwoonecitydefensesare" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_copythatkingpin" );
    level maps\_utility::dialogue_queue( "fin_kgn_static" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_ilonaareyoureceiving" );
    level maps\_utility::dialogue_queue( "fin_iln1_static" );
    wait 1;
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_damnwerecutoff" );
    common_scripts\utility::flag_set( "flag_dialogue_carry_scene_02_complete" );
}

dialogue_will_revael()
{
    wait 5.0;
    soundscripts\_snd::snd_music_message( "gideon_sets_mitchell_down" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_imsettingyoudown" );
    level.gideon maps\_utility::dialogue_queue( "fin_gdn_needtofindsomelight" );
    common_scripts\utility::flag_set( "flag_dialogue_se_will_reveal" );
    soundscripts\_snd::snd_message( "aud_irons_says_hello" );
}

dialogue_chase_irons()
{
    common_scripts\utility::flag_wait( "flag_will_room_door_exit_open" );

    if ( !common_scripts\utility::flag( "missionfailed" ) )
        level.gideon maps\_utility::dialogue_queue( "fin_gdn_dontletironsgetaway" );

    common_scripts\utility::flag_wait( "flag_irons_start_running_01" );
    wait 2;

    if ( !common_scripts\utility::flag( "missionfailed" ) )
        level.gideon maps\_utility::dialogue_queue( "fin_gdn_hurrymitchell" );

    wait 1;

    if ( !common_scripts\utility::flag( "missionfailed" ) )
        level.gideon maps\_utility::dialogue_queue( "fin_gdn_keepgoing2" );
}

dialogue_irons_ending()
{
    common_scripts\utility::flag_wait( "flag_se_irons_end_start" );
}

#using_animtree("generic_human");

init_pcap_vo()
{
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %fin_exhaust_mech_exit_gideon, "aud_start_fin_exhaust_mech_exit_gideon", ::fin_mech_exit_gideon );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %fin_irons_reveal_npc_irons, "aud_start_finale_pt1_irons", ::fin_ending1_1_irs );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %fin_irons_reveal_npc_gideon, "aud_start_finale_pt1_gideon", ::fin_ending1_1_gdn );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %fin_irons_reveal_part2_npc_gideon, "aud_start_finale_pt1_2_gideon", ::fin_ending1_2_gdn );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %fin_balcony_finale_pt2_npc, "aud_start_Fin_Part2_1_001", ::fin_ending2_1_irs );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %fin_balcony_finale_pt3_combined_npc, "fin_finale_drop_part3_irs", ::fin_ending2_3combined_irs );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %fin_balcony_finale_pt5_npc, "aud_start_fin_irons_fail_fall", ::fin_ending2_5_irs );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %fin_balcony_finale_end_gideon, "aud_start_Fin_Part2_2_001", ::fin_ending2_2_gdn );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %fin_balcony_finale_end_gideon, "aud_start_fin_900_900_mtl", ::fin_mitchel_vo );
}

fin_mech_exit_gideon( var_0 )
{
    soundscripts\_snd::snd_music_message( "mitchellhangon" );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_gdn_mitchellhangon", 1.12 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_gdn_westoppeditwestopped", 7.24 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_gdn_imgonnagetyouout", 13.21 );
}

fin_ending1_1_irs( var_0 )
{
    soundscripts\_snd::snd_music_message( "fin_irs_hellomitchell" );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_irs_hellomitchell", 2.18 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_irs_idaskthesameof", 6.09 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_irs_yourelytoomuchon2", 13.18 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_irs_whativestartedwontend2", 18.18 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_irs_youthinkimamonster", 26.03 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_irs_imsavingtheworldfrom", 37.03 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_irs_icouldhavekilledyou", 55.0 );
}

fin_ending1_1_gdn( var_0 )
{
    soundscripts\_snd::snd_message( "aud_irons_reveal_bomb_shake", 45.21 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_gdn_dontfuckingmove", 4.21 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_gdn_heshackingourexos", 9.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_gdn_thecitysfallingitsover2", 16.06 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_gdn_necessary", 31.28 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_gdn_yeah", 45.21 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_gdn_mitchell5", 73.27 );
}

fin_ending1_2_gdn( var_0 )
{
    soundscripts\_snd::snd_message( "aud_irons_reveal_bomb_shake_02", 0.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_gdn_nowmine", 0.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_gdn_theresnotime", 7.08, "sounddone_fin_gdn_theresnotime" );
}

fin_ending2_1_irs( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_irs_mitchellpullmeup", 4.0, undefined, "audio_finale_qte_fail" );
}

fin_ending2_3combined_irs( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_irs_theresonlytwochoices", 0.0, undefined, "audio_finale_qte_fail" );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_irs_mitchellwhatareyoudoing", 11.0, undefined, "audio_finale_qte_fail" );
}

fin_ending2_5_irs( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_irs_aaahhhhmitchell", 3.18, "sounddone_fin_irs_aaahhhhmitchell" );
}

fin_ending2_2_gdn( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fin_gdn_ivegotyamate", 2.18, "sounddone_fin_gdn_ivegotyamate" );
}

fin_mitchel_vo( var_0 )
{
    soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps( "fin_mtl_endingmonologue", 0.01 );
}
