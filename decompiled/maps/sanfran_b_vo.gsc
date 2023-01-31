// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setup_dialogue();
    thread play_dialogue();
}

setup_dialogue()
{
    level.scr_radio["sfb_sn1_ineedallavailablecoast"] = "sfb_sn1_ineedallavailablecoast";
    level.scr_radio["sfb_sn2_cleareveryoneoffthebridge"] = "sfb_sn2_cleareveryoneoffthebridge";
    level.scr_radio["sfb_sn1_casevacunitsareinbound"] = "sfb_sn1_casevacunitsareinbound";
    level.scr_radio["sfb_sn2_tellthemitsinthe"] = "sfb_sn2_tellthemitsinthe";
    level.scr_radio["sfb_sn1_openfireonthosecargo"] = "sfb_sn1_openfireonthosecargo";
    level.scr_radio["sfb_nvr_ourweaponssystemsaredown"] = "sfb_nvr_ourweaponssystemsaredown";
    level.scr_radio["sfb_plt_copythatwearetwo"] = "sfb_plt_copythatwearetwo";
    level.scr_radio["sfb_nvr_ivegoteyesonthirty"] = "sfb_nvr_ivegoteyesonthirty";
    level.scr_radio["sfb_sn1_getallsecuritypersonnelarmed"] = "sfb_sn1_getallsecuritypersonnelarmed";
    level.scr_radio["sfb_nvr_fireeverythingyouvegotin"] = "sfb_nvr_fireeverythingyouvegotin";
    level.scr_sound["cormack"]["sfb_crk_techniciansaretryingtoget"] = "sfb_crk_techniciansaretryingtoget";
    level.scr_sound["burke"]["sfb_gdn_howthehelldidirons"] = "sfb_gdn_howthehelldidirons";
    level.scr_sound["cormack"]["sfb_crk_hehasntdoneagoddamn"] = "sfb_crk_hehasntdoneagoddamn";
    level.scr_sound["burke"]["sfb_gdn_alrightletsshowthesenavy"] = "sfb_gdn_alrightletsshowthesenavy";
    level.scr_sound["burke"]["sfb_gdn_useyourboosterstogain"] = "sfb_gdn_useyourboosterstogain";
    level.scr_sound["burke"]["sfb_gdn_contactbythejet"] = "sfb_gdn_contactbythejet";
    level.scr_sound["maddox"]["sfb_mdx_boostjumpersincoming"] = "sfb_mdx_boostjumpersincoming";
    level.scr_sound["burke"]["sfb_gdn_switchtoyourgrenadelauncher"] = "sfb_gdn_switchtoyourgrenadelauncher";
    level.scr_sound["security_officer_1"]["sfb_sc1_whothehellareyou"] = "sfb_sc1_whothehellareyou";
    level.scr_sound["maddox"]["sfb_mdx_wereyourbackup"] = "sfb_mdx_wereyourbackup";
    level.scr_sound["cormack"]["sfb_crk_jumpersinboundfromthenorth"] = "sfb_crk_jumpersinboundfromthenorth";
    level.scr_sound["burke"]["sfb_gdn_atlaschoppersinbound"] = "sfb_gdn_atlaschoppersinbound";
    level.scr_sound["maddox"]["sfb_mdx_theyrealloverthegoddamn"] = "sfb_mdx_theyrealloverthegoddamn";
    level.scr_sound["cormack"]["sfb_crk_someonegetmeasitrep"] = "sfb_crk_someonegetmeasitrep";
    level.scr_radio["sfb_alx_carriertechissayingtheyre"] = "sfb_alx_carriertechissayingtheyre";
    level.scr_sound["cormack"]["sfb_crk_almostdoesntcutit"] = "sfb_crk_almostdoesntcutit";
    level.scr_sound["burke"]["sfb_gdn_morefastzippers"] = "sfb_gdn_morefastzippers";
    level.scr_sound["security_officer_2"]["sfb_sc1_takecover"] = "sfb_sc1_takecover";
    level.scr_sound["security_officer_3"]["sfb_sc2_regrouponthestarboarddeck"] = "sfb_sc2_regrouponthestarboarddeck";
    level.scr_sound["security_officer_4"]["sfb_sc1_michaelskeepyourgoddamnhead"] = "sfb_sc1_michaelskeepyourgoddamnhead";
    level.scr_sound["security_officer_5"]["sfb_sc2_moreofthembythe"] = "sfb_sc2_moreofthembythe";
    level.scr_radio["sfb_alx_weaponsbackonline"] = "sfb_alx_weaponsbackonline";
    level.scr_sound["cormack"]["sfb_crk_deckissecuredwereheading"] = "sfb_crk_deckissecuredwereheading";
    level.scr_sound["burke"]["sfb_gdn_letsgoletsgo"] = "sfb_gdn_letsgoletsgo";
    level.scr_sound["cormack"]["sfb_crk_mitchelljumpuphere"] = "sfb_crk_mitchelljumpuphere";
    level.scr_sound["cormack"]["sfb_crk_mitchelloverhere"] = "sfb_crk_mitchelloverhere";
    level.scr_sound["cormack"]["sfb_crk_mitchellgetwiththeprogram"] = "sfb_crk_mitchellgetwiththeprogram";
    level.scr_sound["cormack"]["sfb_crk_killyourboosters"] = "sfb_crk_killyourboosters";
    level.scr_sound["burke"]["sfb_gdn_checkthosecorners"] = "sfb_gdn_checkthosecorners";
    level.scr_sound["cormack"]["sfb_crk_weneedtogetto"] = "sfb_crk_weneedtogetto";
    level.scr_sound["cormack"]["sfb_crk_powersoutswitchtosonar"] = "sfb_crk_powersoutswitchtosonar";
    level.scr_sound["maddox"]["sfb_mdx_contact"] = "sfb_mdx_contact";
    level.scr_sound["cormack"]["sfb_crk_clearemout"] = "sfb_crk_clearemout";
    level.scr_sound["cormack"]["sfb_crk_thisway"] = "sfb_crk_thisway";
    level.scr_sound["cormack"]["sfb_crk_overhere"] = "sfb_crk_overhere";
    level.scr_sound["cormack"]["sfb_crk_mitchellmove"] = "sfb_crk_mitchellmove";
    level.scr_sound["cormack"]["sfb_crk_wehavetobreakthrough"] = "sfb_crk_wehavetobreakthrough";
    level.scr_sound["burke"]["sfb_gdn_fastzipatourtwelve"] = "sfb_gdn_fastzipatourtwelve";
    level.scr_sound["cormack"]["sfb_crk_throughthedoor"] = "sfb_crk_throughthedoor";
    level.scr_radio["sfb_alx_thosefabsaretearingup"] = "sfb_alx_thosefabsaretearingup";
    level.scr_sound["burke"]["sfb_gdn_upthestairs"] = "sfb_gdn_upthestairs";
    level.scr_sound["cormack"]["sfb_crk_pushthrough"] = "sfb_crk_pushthrough";
    level.scr_sound["cormack"]["sfb_crk_alxeiwerealmostthere"] = "sfb_crk_alxeiwerealmostthere";
    level.scr_sound["cormack"]["sfb_crk_admiraldavisrequestingauthorizationto"] = "sfb_crk_admiraldavisrequestingauthorizationto";
    level.scr_radio["sfb_ads_authorizationgrantedsentinelone"] = "sfb_ads_authorizationgrantedsentinelone";
    level.scr_sound["cormack"]["sfb_crk_copythat2"] = "sfb_crk_copythat2";
    level.scr_sound["burke"]["sfb_gdn_steadynowmitchell"] = "sfb_gdn_steadynowmitchell";
    level.scr_sound["burke"]["sfb_gdn_thatsahit"] = "sfb_gdn_thatsahit";
    level.scr_sound["burke"]["sfb_gdn_cargoshipisdown"] = "sfb_gdn_cargoshipisdown";
    level.scr_sound["maddox"]["sfb_mdx_wejustlostourcrusier"] = "sfb_mdx_wejustlostourcrusier";
    level.scr_sound["burke"]["sfb_gdn_thatsthelastofem"] = "sfb_gdn_thatsthelastofem";
    level.scr_radio["sfb_ads_thisiscompacfleet"] = "sfb_ads_thisiscompacfleet";
    level.scr_sound["cormack"]["sfb_crk_copythatadmiral"] = "sfb_crk_copythatadmiral";
    level.scr_sound["burke"]["sfb_gdn_fuckinghell"] = "sfb_gdn_fuckinghell";
    level.scr_sound["maddox"]["sfb_mdx_whathappensnext"] = "sfb_mdx_whathappensnext";
    level.scr_sound["cormack"]["sfb_crk_next"] = "sfb_crk_next";
    level.scr_sound["cormack"]["sfb_crk_takethemout"] = "sfb_crk_takethemout";
    level.scr_sound["burke"]["sfb_gdn_dronesareclear"] = "sfb_gdn_dronesareclear";
    level.scr_sound["cormack"]["sfb_crk_oklinkingin"] = "sfb_crk_oklinkingin";
    level.scr_sound["cormack"]["sfb_crk_ineedyoutotarget"] = "sfb_crk_ineedyoutotarget";
    level.scr_sound["cormack"]["sfb_crk_getonthatterminalmitchell"] = "sfb_crk_getonthatterminalmitchell";
    level.scr_sound["cormack"]["sfb_crk_mitchellusethetargetingcomputer"] = "sfb_crk_mitchellusethetargetingcomputer";
    level.scr_sound["cormack"]["sfb_crk_targetthatcargoship"] = "sfb_crk_targetthatcargoship";
    level.scr_sound["cormack"]["sfb_crk_holdsteadyonthecargo"] = "sfb_crk_holdsteadyonthecargo";
    level.scr_sound["cormack"]["sfb_crk_targetaquiredfiring"] = "sfb_crk_targetaquiredfiring";
    level.scr_sound["burke"]["sfb_gdn_shesdown"] = "sfb_gdn_shesdown";
    level.scr_sound["cormack"]["sfb_crk_switchingtothesecondship"] = "sfb_crk_switchingtothesecondship";
    level.scr_sound["cormack"]["sfb_crk_targettheship"] = "sfb_crk_targettheship";
    level.scr_sound["cormack"]["sfb_crk_holdthattarget"] = "sfb_crk_holdthattarget";
    level.scr_sound["cormack"]["sfb_crk_firing"] = "sfb_crk_firing";
    level.scr_sound["cormack"]["sfb_crk_stayontarget"] = "sfb_crk_stayontarget";
    level.scr_sound["cormack"]["sfb_crk_hittheothercargoship"] = "sfb_crk_hittheothercargoship";
    level.scr_sound["burke"]["sfb_gdn_thatwarbirdhasabead"] = "sfb_gdn_thatwarbirdhasabead";
    level.scr_sound["cormack"]["sfb_crk_twowarbirdscominginfrom"] = "sfb_crk_twowarbirdscominginfrom";
    level.scr_sound["cormack"]["sfb_crk_gettotherailgun"] = "sfb_crk_gettotherailgun";
    level.scr_sound["cormack"]["sfb_crk_getthatjammerinplace"] = "sfb_crk_getthatjammerinplace";
    level.scr_sound["cormack"]["sfb_crk_mitchellplantthejammer"] = "sfb_crk_mitchellplantthejammer";
    level.scr_sound["cormack"]["sfb_crk_jammerisset"] = "sfb_crk_jammerisset";
    level.scr_sound["cormack"]["sfb_crk_setthejammer"] = "sfb_crk_setthejammer";
    level.scr_sound["cormack"]["sfb_crk_cmonmitchellplantit"] = "sfb_crk_cmonmitchellplantit";
    level.scr_sound["cormack"]["sfb_crk_mitchellplantitnow"] = "sfb_crk_mitchellplantitnow";
    level.scr_sound["burke"]["sfb_gdn_thatshouldslowthemdown"] = "sfb_gdn_thatshouldslowthemdown";
    level.scr_sound["cormack"]["sfb_crk_railgunsaresecured"] = "sfb_crk_railgunsaresecured";
    level.scr_radio["sfb_ads_sentinelzeroonethecarriersweaponssystem"] = "sfb_ads_sentinelzeroonethecarriersweaponssystem";
    level.scr_sound["cormack"]["sfb_crk_copythat"] = "sfb_crk_copythat";
    level.scr_sound["cormack"]["sfb_crk_sonofabitch"] = "sfb_crk_sonofabitch";
    level.scr_sound["cormack"]["sfb_crk_tangodown"] = "sfb_crk_tangodown";
    level.scr_sound["cormack"]["sfb_crk_thatsforthebridge"] = "sfb_crk_thatsforthebridge";
    level.scr_radio["sfb_ads_thosedronesaretearingup"] = "sfb_ads_thosedronesaretearingup";
    level.scr_radio["sfb_ads_atlashastakenthebridge"] = "sfb_ads_atlashastakenthebridge";
    level.scr_sound["cormack"]["sfb_crk_werealmostatthebridge"] = "sfb_crk_werealmostatthebridge";
    level.scr_sound["cormack"]["sfb_crk_lightsout"] = "sfb_crk_lightsout";
    level.scr_sound["cormack"]["sfb_crk_ast"] = "sfb_crk_ast";
}

play_dialogue()
{
    thread intro_radio_chatter();
    thread deck_dialogue();
    thread interior_dialogue();
    thread hangar_dialogue();
    thread information_center_dialogue();
    thread bridge_dialogue();
}

intro_radio_chatter()
{
    level endon( "intro_dialogue" );
    common_scripts\utility::flag_wait( "intro_radio_vo" );
    wait 1.5;
    maps\_utility::dialogue_queue( "sfb_nvr_ivegoteyesonthirty" );
    maps\_utility::dialogue_queue( "sfb_sn1_getallsecuritypersonnelarmed" );
}

deck_dialogue()
{
    level endon( "flag_player_entered_interior" );
    maps\_utility::trigger_wait_targetname( "trig_deck_vo_1" );
    thread grenade_launcher_vo();
    var_0 = find_non_squad_allies_by_distance();
    level.burke maps\_utility::dialogue_queue( "sfb_gdn_contactbythejet" );
    maps\_utility::delaythread( 2, ::navy_vo );
    wait 3;
    common_scripts\utility::flag_wait( "useyourboosters_vo" );
    common_scripts\utility::flag_wait( "obj_track_jammers" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_gettotherailgun" );
    maps\_utility::trigger_wait_targetname( "trig_deck_vo_jammer_1_nag" );
    thread jammer_1_nag_lines();
    common_scripts\utility::flag_wait( "boost_incoming_vo" );
    wait 2.5;
    level.maddox maps\_utility::dialogue_queue( "sfb_mdx_boostjumpersincoming" );
    common_scripts\utility::flag_wait( "jammer_1_deactivated" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_jammerisset" );
    soundscripts\_snd::snd_music_message( "first_jammer_set" );
    common_scripts\utility::flag_wait( "deck_warbird_vo" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_twowarbirdscominginfrom" );
    common_scripts\utility::flag_wait( "deck_reinforcement_1" );
    wait 2.5;
    level.burke maps\_utility::dialogue_queue( "sfb_gdn_atlaschoppersinbound" );
    wait 1;
    level.burke maps\_utility::dialogue_queue( "sfb_gdn_thatwarbirdhasabead" );
    common_scripts\utility::flag_wait( "jammer_2_vo" );
    thread jammer_2_nag_lines();
    common_scripts\utility::flag_wait( "jammer_2_deactivated" );
    level.burke maps\_utility::dialogue_queue( "sfb_gdn_thatshouldslowthemdown" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_railgunsaresecured" );
    common_scripts\utility::flag_wait( "deck_reinforcement_2" );
    wait 3.25;
    level.burke maps\_utility::dialogue_queue( "sfb_gdn_morefastzippers" );
    wait 5;
    level.maddox maps\_utility::dialogue_queue( "sfb_mdx_theyrealloverthegoddamn" );
    thread deck_dialog_rail_gun_secure();
}

deck_dialog_rail_gun_secure()
{
    level endon( "flag_player_entered_interior" );
    common_scripts\utility::flag_wait( "rail_guns_secure_vo" );
    wait 3;
    level maps\_utility::dialogue_queue( "sfb_ads_sentinelzeroonethecarriersweaponssystem" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_copythat" );
    level.burke maps\_utility::dialogue_queue( "sfb_gdn_letsgoletsgo" );
    thread player_jump_into_mob_nag_lines();
}

grenade_launcher_vo()
{
    maps\_utility::trigger_wait_targetname( "trig_grenade_launcher_vo" );
    soundscripts\_snd::snd_message( "begin_rooftop_combat" );
    var_0 = 0;
    var_1 = level.player _meth_830B();

    foreach ( var_3 in var_1 )
    {
        if ( issubstr( var_3, "microdronelauncher" ) )
        {
            var_0 = 1;
            continue;
        }
    }

    var_5 = level.player _meth_8311();

    if ( var_0 && !issubstr( var_5, "microdronelauncher" ) )
        return;
}

navy_vo()
{
    var_0 = find_non_squad_allies_by_distance();

    if ( isdefined( var_0 ) && var_0.size > 0 )
    {
        var_0[0].animname = "security_officer_2";
        var_0[0] maps\_utility::dialogue_queue( "sfb_sc1_takecover" );
    }

    wait 3;
    var_0 = find_non_squad_allies_by_distance();

    if ( isdefined( var_0 ) && var_0.size > 0 )
    {
        var_0[0].animname = "security_officer_4";
        var_0[0] maps\_utility::dialogue_queue( "sfb_sc1_michaelskeepyourgoddamnhead" );
    }

    common_scripts\utility::flag_wait( "deck_reinforcement_1" );
    wait 6;
    var_0 = find_non_squad_allies_by_distance();

    if ( isdefined( var_0 ) && var_0.size > 0 )
    {
        var_0[0].animname = "security_officer_3";
        var_0[0] maps\_utility::dialogue_queue( "sfb_sc2_regrouponthestarboarddeck" );
    }

    common_scripts\utility::flag_wait( "deck_reinforcement_2" );
    wait 6;
    var_0 = find_non_squad_allies_by_distance();

    if ( isdefined( var_0 ) && var_0.size > 0 )
    {
        var_0[0].animname = "security_officer_5";
        var_0[0] maps\_utility::dialogue_queue( "sfb_sc2_moreofthembythe" );
    }
}

find_non_squad_allies_by_distance()
{
    var_0 = _func_0D6( "allies" );

    foreach ( var_2 in var_0 )
    {
        if ( maps\_utility::is_in_array( level.heroes, var_2 ) )
            var_0 = common_scripts\utility::array_remove( var_0, var_2 );
    }

    var_0 = maps\_utility::array_removedead_or_dying( var_0 );
    var_0 = common_scripts\utility::array_removeundefined( var_0 );
    var_0 = sortbydistance( var_0, level.player.origin );
    return var_0;
}

jammer_1_nag_lines()
{
    var_0 = [];
    var_0[0] = "sfb_crk_getthatjammerinplace";
    var_0[1] = "sfb_crk_mitchellplantthejammer";
    var_0[2] = "sfb_crk_setthejammer";
    thread maps\_shg_utility::dialogue_reminder( level.cormack, "jammer_1_deactivated", var_0, 10, 20 );
}

jammer_2_nag_lines()
{
    var_0 = [];
    var_0[0] = "sfb_crk_cmonmitchellplantit";
    var_0[1] = "sfb_crk_mitchellplantitnow";
    var_0[2] = "sfb_crk_gettotherailgun";
    thread maps\_shg_utility::dialogue_reminder( level.cormack, "jammer_2_deactivated", var_0, 10, 20 );
}

player_jump_into_mob_nag_lines()
{
    var_0 = getent( "volume_initial_interior_room", "targetname" );
    var_1 = 0;

    while ( !var_1 )
    {
        if ( level.cormack _meth_80A9( var_0 ) )
        {
            var_1 = 1;
            break;
        }

        wait 0.05;
    }

    var_2 = [];
    var_2[0] = "sfb_crk_mitchelljumpuphere";
    var_2[1] = "sfb_crk_mitchelloverhere";
    var_2[2] = "sfb_crk_mitchellgetwiththeprogram";
    thread maps\_shg_utility::dialogue_reminder( level.cormack, "flag_player_entered_interior", var_2, 10, 20 );
}

interior_dialogue()
{
    common_scripts\utility::flag_wait( "flag_player_entered_interior" );
    maps\_utility::trigger_wait_targetname( "trig_open_initial_door_anim" );
    wait 1;
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_weneedtogetto" );
    common_scripts\utility::flag_wait( "exo_takedown_started" );

    if ( isdefined( level.takedownenemy1 ) )
    {
        level.cormack maps\_utility::delaythread( 3.75, maps\_utility::dialogue_queue, "sfb_crk_sonofabitch" );
        maps\_utility::delaythread( 3.75, common_scripts\utility::flag_set, "flag_allow_night_vision_hint" );
    }
    else
        common_scripts\utility::flag_set( "flag_allow_night_vision_hint" );

    maps\_utility::trigger_wait_targetname( "trig_display_sonar_hint" );
    common_scripts\utility::flag_wait( "flag_allow_night_vision_hint" );
    wait 0.75;
    soundscripts\_snd::snd_music_message( "sanfranb_crmk_switchtosonar" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_powersoutswitchtosonar" );
    common_scripts\utility::flag_wait( "flag_vo_trig_display_sonar_hint" );
    level.maddox maps\_utility::dialogue_queue( "sfb_mdx_contact" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_clearemout" );
    common_scripts\utility::flag_wait( "flag_vo_trig_interior_vo_2" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_thisway" );
    thread player_leave_cafeteria_nag_lines();
}

player_leave_cafeteria_nag_lines()
{
    var_0 = [];
    var_0[0] = "sfb_crk_overhere";
    var_0[1] = "sfb_crk_mitchellmove";
    thread maps\_shg_utility::dialogue_reminder( level.cormack, "player_exit_cafeteria", var_0, 7, 15 );
}

hangar_dialogue()
{
    common_scripts\utility::flag_wait( "player_exit_cafeteria" );
    common_scripts\utility::flag_wait( "trig_fleet_vo" );
    level maps\_utility::dialogue_queue( "sfb_ads_atlashastakenthebridge" );
    common_scripts\utility::flag_wait( "trig_hangar_vo_1" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_wehavetobreakthrough" );
    soundscripts\_snd::snd_message( "enter_hangar" );
    common_scripts\utility::flag_wait( "hangar_guys_unloading_1" );
    level.burke maps\_utility::dialogue_queue( "sfb_gdn_fastzipatourtwelve" );
    common_scripts\utility::flag_wait( "ast_vo" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_ast" );
    common_scripts\utility::flag_wait( "through_door_vo" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_throughthedoor" );
    common_scripts\utility::flag_wait( "trig_hangar_ambient_naval_combat" );
    wait 2;
    level maps\_utility::dialogue_queue( "sfb_ads_thosedronesaretearingup" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_werealmostatthebridge" );
    maps\_utility::trigger_wait_targetname( "trig_hangar_vo_2" );
    soundscripts\_snd::snd_message( "enter_room_above_hangar" );
}

information_center_dialogue()
{
    common_scripts\utility::flag_wait( "flag_information_center" );
    common_scripts\utility::flag_wait( "flag_information_center_vo_1" );
    level.burke maps\_utility::dialogue_queue( "sfb_gdn_upthestairs" );
    common_scripts\utility::flag_wait( "flag_information_center_vo_2" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_lightsout" );
    common_scripts\utility::flag_wait_either( "information_center_cleared", "information_center_enemies_killed" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_admiraldavisrequestingauthorizationto" );
    level maps\_utility::dialogue_queue( "sfb_ads_authorizationgrantedsentinelone" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_copythat2" );
}

bridge_dialogue()
{
    common_scripts\utility::flag_wait( "flag_bridge" );
    maps\_utility::trigger_wait_targetname( "trig_spawn_bridge_drones" );
    common_scripts\utility::flag_wait( "pulloff_anim_started" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_oklinkingin" );
    common_scripts\utility::flag_wait( "target_vo" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_ineedyoutotarget" );
    thread get_on_console_nag_lines();
    common_scripts\utility::flag_wait( "player_using_mob_turret" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_targetthatcargoship" );
    common_scripts\utility::flag_wait( "player_firing_mob_turret" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_holdsteadyonthecargo" );
    common_scripts\utility::flag_wait( "first_cargo_ship_destroyed" );
    wait 3;
    level.burke maps\_utility::dialogue_queue( "sfb_gdn_cargoshipisdown" );
    wait 1;
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_switchingtothesecondship" );
    common_scripts\utility::flag_wait( "player_firing_mob_turret" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_holdthattarget" );
    common_scripts\utility::flag_wait( "second_cargo_ship_destroyed" );
    wait 1.5;
    level.burke maps\_utility::dialogue_queue( "sfb_gdn_shesdown" );
    wait 2.0;
    level maps\_utility::dialogue_queue( "sfb_ads_thisiscompacfleet" );
    level.cormack maps\_utility::dialogue_queue( "sfb_crk_copythatadmiral" );
    common_scripts\utility::flag_set( "outro_dialogue_finished" );
}

get_on_console_nag_lines()
{
    var_0 = [];
    var_0[1] = "sfb_crk_getonthatterminalmitchell";
    var_0[2] = "sfb_crk_mitchellusethetargetingcomputer";
    thread maps\_shg_utility::dialogue_reminder( level.cormack, "player_using_mob_turret", var_0, 7, 15 );
}

init_pcap_vo()
{
    if ( level.nextgen )
    {
        init_pcap_vo_intro();
        init_pcap_vo_outro();
    }
    else if ( _func_21E( "sanfran_b_intro_tr" ) )
    {
        init_pcap_vo_intro();
        level waittill( "tff_post_transition_intro_to_outro" );
        init_pcap_vo_outro();
    }
    else if ( _func_21E( "sanfran_b_outro_tr" ) )
        init_pcap_vo_outro();
}

#using_animtree("generic_human");

init_pcap_vo_intro()
{
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %sanfran_b_intro_burke, "aud_start_MOB_transition_intro", ::pcap_vo_sf_b_intro_gideon );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %sanfran_b_intro_cormack, "aud_start_MOB_transition_intro", ::pcap_vo_sf_b_intro_cormack );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %sf_b_boost_off_guy2, "aud_start_sf_b_intro_boosters_off01", ::pcap_vo_sf_b_boosters_cormack );
}

init_pcap_vo_outro()
{
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %sf_b_bridge_dialog_guy1, "aud_start_MOB_bridge_final_diolog", ::sf_b_bridge_cormack );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %sf_b_bridge_dialog_guy2, "aud_start_mob_knox", ::sf_b_bridge_maddox );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %sf_b_bridge_dialog_guy3, "aud_start_MOB_bridge_final_diolog", ::sf_b_bridge_burk );
}

pcap_vo_sf_b_intro_cormack( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "sfb_crk_atlasistryingtotakecontrol", 7.18 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "sfb_crk_theyregonnatryandtake", 17.0 );
}

pcap_vo_sf_b_intro_gideon( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "sfb_gdn_jesus", 2.06 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "sfb_gdn_wevegotenemytroops", 14.21 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "sfb_gdn_wewontletthemget", 21.18, "pcap_vo_sf_b_intro_done" );
    level waittill( "pcap_vo_sf_b_intro_done" );
}

pcap_vo_sf_b_boosters_cormack( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo( "sfb_crk_killyourboosters", 0.0 );
}

pcap_vo_sf_b_bridge_init()
{

}

sf_b_bridge_burk( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "sfb_gdn_fuckinghell", 5.24 );
}

sf_b_bridge_maddox( var_0 )
{
    var_1 = 12.0;
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "sfb_mdx_whathappensnext", var_1 );
    soundscripts\_snd::snd_music_message( "mus_sfb_pcap_ending", var_1 );
}

sf_b_bridge_cormack( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "sfb_crk_next", 15.24, "pcap_vo_sf_b_bridge_done" );
}
