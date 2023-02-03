// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setup_vo();
    thread start_dialogue_threads();
    thread init_pcap_vo();
    thread init_plr_vo();
}

setup_vo()
{
    var_0 = "burke";
    var_0 = "burke";
    var_1 = "joker";
    var_1 = "joker";
    var_2 = "bones";
    var_2 = "bones";
    var_3 = "bones";
    var_3 = "bones";
    var_4 = "PA";
    var_5 = "drone_civs";
    var_6 = "drone_civs";
    var_7 = "drone_civs";
    var_8 = "drone_civs";
    var_9 = "generic";
    var_10 = "generic";
    var_11 = "bones";
    var_12 = "prophet";
    var_13 = "kva";
    var_13 = "kva";
    var_14 = "kva";
    var_15 = "soldier";
    var_16 = "Mech";
    var_17 = "doctor";
    var_10 = "Atlas_Commander";
    var_18 = "mech1";
    var_18 = "mech1";
    var_19 = "decon_gate";
    level.scr_sound[var_0]["detroit_brk_twoandahalfmillion"] = "detroit_brk_twoandahalfmillion";
    level.scr_sound[var_1]["detroit_jkr_burkeyoulooklikeshit"] = "detroit_jkr_burkeyoulooklikeshit";
    level.scr_sound[var_0]["detroit_brk_beengoingtwentytwodaysstraight"] = "detroit_brk_beengoingtwentytwodaysstraight";
    level.scr_sound[var_1]["detroit_jkr_copythat"] = "detroit_jkr_copythat";
    level.scr_sound[var_1]["detroit_jkr_theyweregoingtostart"] = "detroit_jkr_theyweregoingtostart";
    level.scr_sound[var_0]["detroit_brk_theyreprotectingourtargetdr"] = "detroit_brk_theyreprotectingourtargetdr";
    level.scr_sound[var_1]["detroit_jkr_midtownhospitalweregreen"] = "detroit_jkr_midtownhospitalweregreen";
    level.scr_sound[var_0]["det_gdn_letsgetitdone"] = "det_gdn_letsgetitdone";
    level.scr_sound[var_4]["detroit_pa_attentioncurfewisinone"] = "detroit_pa_attentioncurfewisinone";
    level.scr_sound[var_4]["detroit_pa_remembertohaveyouridentification"] = "detroit_pa_remembertohaveyouridentification";
    level.scr_sound[var_4]["detroit_pa_reportanysuspiciousactivityto"] = "detroit_pa_reportanysuspiciousactivityto";
    level.scr_sound[var_4]["detroit_pa_noncompliancewithyoursecurityprotocol"] = "detroit_pa_noncompliancewithyoursecurityprotocol";
    level.scr_sound[var_4]["det_cmr1_scanningforisotopespleasewait"] = "det_cmr1_scanningforisotopespleasewait";
    level.scr_sound[var_4]["detroit_pa_curfewisnowineffect"] = "detroit_pa_curfewisnowineffect";
    level.scr_sound[var_4]["detroit_pa_thisissafetyreminder"] = "detroit_pa_thisissafetyreminder";
    level.scr_sound[var_5]["detroit_cv1_istillhaventbeenable"] = "detroit_cv1_istillhaventbeenable";
    level.scr_sound[var_6]["detroit_cv2_imsurehesfine"] = "detroit_cv2_imsurehesfine";
    level.scr_sound[var_7]["detroit_cv3_theysayitsgoingto"] = "detroit_cv3_theysayitsgoingto";
    level.scr_sound[var_8]["detroit_cv4_andyoutrustthem"] = "detroit_cv4_andyoutrustthem";
    level.scr_sound[var_7]["detroit_cv3_doihaveachoice"] = "detroit_cv3_doihaveachoice";
    level.scr_sound[var_9]["detroit_atd_heyhey"] = "detroit_atd_heyhey";
    level.scr_sound[var_9]["detroit_atd_rememberonepacketpersector"] = "detroit_atd_rememberonepacketpersector";
    level.scr_sound[var_10]["detroit_atr_youllbewontbeable"] = "detroit_atr_youllbewontbeable";
    level.scr_sound[var_10]["detroit_atr_onceyourdnaisin"] = "detroit_atr_onceyourdnaisin";
    level.scr_sound[var_10]["detroit_atr_ifyouhaveaquestion"] = "detroit_atr_ifyouhaveaquestion";
    level.scr_sound[var_10]["detroit_atr_remembernothinghappensunlessyou"] = "detroit_atr_remembernothinghappensunlessyou";
    level.scr_sound[var_10]["detroit_atr_weappreciateyourpatience"] = "detroit_atr_weappreciateyourpatience";
    level.scr_sound[var_10]["detroit_atr_sectorsathroughfwill"] = "detroit_atr_sectorsathroughfwill";
    level.scr_sound[var_10]["detroit_atr_werereopeningthesectorc"] = "detroit_atr_werereopeningthesectorc";
    level.scr_sound[var_10]["detroit_atr_iknowyouallhave"] = "detroit_atr_iknowyouallhave";
    level.scr_sound[var_10]["detroit_atr_werelookingatarolling"] = "detroit_atr_werelookingatarolling";
    level.scr_sound[var_4]["detroit_pa_attentioncurfewisinone"] = "detroit_pa_attentioncurfewisinone";
    level.scr_sound[var_4]["detroit_pa_remembertohaveyouridentification"] = "detroit_pa_remembertohaveyouridentification";
    level.scr_sound[var_4]["detroit_pa_reportanysuspiciousactivityto"] = "detroit_pa_reportanysuspiciousactivityto";
    level.scr_sound[var_4]["detroit_pa_noncompliancewithyoursecurityprotocol"] = "detroit_pa_noncompliancewithyoursecurityprotocol";
    level.scr_sound["scanner_guard_animated_spawner"]["detroit_atd_captain"] = "detroit_atd_captain";
    level.scr_sound[var_1]["detroit_jkr_whatthehellarethe"] = "detroit_jkr_whatthehellarethe";
    level.scr_sound[var_0]["detroit_brk_anemptycitywithoutpolice"] = "detroit_brk_anemptycitywithoutpolice";
    level.scr_sound["scanner_guard_animated_spawner"]["detroit_atd_cleargoodluckoutthere"] = "detroit_atd_cleargoodluckoutthere";
    level.scr_sound[var_11]["detroit_trs_gideon"] = "detroit_trs_gideon";
    level.scr_sound[var_0]["detroit_brk_torresbikesready"] = "detroit_brk_torresbikesready";
    level.scr_sound[var_11]["detroit_trs_rogergoodtogo"] = "detroit_trs_rogergoodtogo";
    level.scr_sound[var_0]["detroit_brk_saddleupmitchell"] = "detroit_brk_saddleupmitchell";
    level.scr_sound[var_0]["detroit_brk_letshititmitchell"] = "detroit_brk_letshititmitchell";
    level.scr_sound[var_0]["detroit_brk_getonthebike"] = "detroit_brk_getonthebike";
    level.scr_sound[var_0]["det_gdn_moveitforfuckssake"] = "det_gdn_moveitforfuckssake";
    level.scr_sound[var_0]["detroit_brk_keepitonautopilotfor"] = "detroit_brk_keepitonautopilotfor";
    level.scr_radio["detroit_prt_bravotwooneweveisolatedthe"] = "detroit_prt_bravotwooneweveisolatedthe";
    level.scr_sound[var_0]["detroit_brk_copyprophet"] = "detroit_brk_copyprophet";
    level.scr_radio["detroit_prt_thedoctorsnogoodto"] = "detroit_prt_thedoctorsnogoodto";
    level.scr_sound[var_0]["detroit_brk_rogerbravoout"] = "detroit_brk_rogerbravoout";
    level.scr_sound[var_18]["detroit_mch_nameandordernumber"] = "detroit_mch_nameandordernumber";
    level.scr_sound[var_0]["detroit_brk_burkeorder5527"] = "detroit_brk_burkeorder5527";
    level.scr_sound[var_18]["detroit_mch_holdon"] = "detroit_mch_holdon";
    level.scr_sound[var_18]["det_mch_gotfouroperativesonbikes"] = "det_mch_gotfouroperativesonbikes";
    level.scr_sound[var_18]["detroit_mch_okyouregood"] = "detroit_mch_okyouregood";
    level.scr_sound[var_0]["detroit_brk_prophetbravotwoone"] = "detroit_brk_prophetbravotwoone";
    level.scr_sound[var_0]["detroit_brk_staylockedon"] = "detroit_brk_staylockedon";
    level.scr_sound[var_11]["detroit_trs_cantbelievethisisdetroit"] = "detroit_trs_cantbelievethisisdetroit";
    level.scr_sound[var_1]["detroit_jkr_hasntchangedthatmuch"] = "detroit_jkr_hasntchangedthatmuch";
    level.scr_sound[var_0]["detroit_brk_linkuppointupahead"] = "detroit_brk_linkuppointupahead";
    level.scr_sound[var_0]["detroit_brk_prophetbravotwooneatlinkuppoint"] = "detroit_brk_prophetbravotwooneatlinkuppoint";
    level.scr_radio["detroit_prt_rogerthatbravotwoone"] = "detroit_prt_rogerthatbravotwoone";
    level.scr_sound[var_0]["detroit_brk_jokerparkeryouknowyour"] = "detroit_brk_jokerparkeryouknowyour";
    level.scr_sound[var_1]["detroit_jkr_rogerthat"] = "detroit_jkr_rogerthat";
    level.scr_radio["detroit_prt_isrdetectingmovementnorthwest"] = "detroit_prt_isrdetectingmovementnorthwest";
    level.scr_sound[var_0]["detroit_brk_wellkeepourheadson"] = "detroit_brk_wellkeepourheadson";
    level.scr_sound[var_0]["detroit_brk_cleanupcrewupahead"] = "detroit_brk_cleanupcrewupahead";
    level.scr_sound[var_0]["detroit_brk_watchyourroemaintainstealth"] = "detroit_brk_watchyourroemaintainstealth";
    level.scr_sound[var_0]["detroit_brk_prophetwereatcheckpointblue"] = "detroit_brk_prophetwereatcheckpointblue";
    level.scr_radio["detroit_prt_copyweretrackingyou"] = "detroit_prt_copyweretrackingyou";
    level.scr_sound[var_0]["detroit_brk_shit"] = "detroit_brk_shit";
    level.scr_sound[var_0]["det_gdn_scoff"] = "det_gdn_scoff";
    level.scr_sound[var_0]["detroit_brk_fuckme"] = "detroit_brk_fuckme";
    level.scr_sound[var_0]["detroit_brk_jokerivegotbodies"] = "detroit_brk_jokerivegotbodies";
    level.scr_sound[var_0]["detroit_brk_ifthekvahavebeen"] = "detroit_brk_ifthekvahavebeen";
    level.scr_radio["detroit_jkr_copy3"] = "detroit_jkr_copy3";
    level.scr_sound[var_0]["det_gdn_thedoormitchell"] = "det_gdn_thedoormitchell";
    level.scr_sound[var_0]["det_gdn_getthedoor"] = "det_gdn_getthedoor";
    level.scr_sound[var_0]["detroit_brk_mitchelltakepoint"] = "detroit_brk_mitchelltakepoint";
    level.scr_sound[var_0]["detroit_brk_upthestairs"] = "detroit_brk_upthestairs";
    level.scr_sound[var_0]["detroit_brk_thisway"] = "detroit_brk_thisway";
    level.scr_sound[var_0]["detroit_brk_easy"] = "detroit_brk_easy";
    level.scr_sound[var_0]["detroit_brk_letthempass"] = "detroit_brk_letthempass";
    level.scr_radio["detroit_kva_whatwasthat"] = "detroit_kva_whatwasthat";
    level.scr_sound[var_13]["detroit_kva_overhere"] = "detroit_kva_overhere";
    level.scr_sound[var_13]["detroit_kva_checkcomms"] = "detroit_kva_checkcomms";
    level.scr_sound[var_0]["detroit_brk_mitchellmitchell2"] = "detroit_brk_mitchellmitchell2";
    level.scr_sound[var_0]["detroit_brk_mitchellmitchell"] = "detroit_brk_mitchellmitchell";
    level.scr_sound[var_0]["detroit_brk_mitchellimseeingalot"] = "detroit_brk_mitchellimseeingalot";
    level.scr_sound[var_13]["detroit_kva_thoughtisawsomething"] = "detroit_kva_thoughtisawsomething";
    level.scr_sound[var_13]["det_kva_contact"] = "det_kva_contact";
    level.scr_sound[var_13]["det_kva_huh"] = "det_kva_huh";
    level.scr_sound[var_13]["det_kva_ivegotcontact"] = "det_kva_ivegotcontact";
    level.scr_sound[var_13]["detroit_kva_nothindownherebutrats"] = "detroit_kva_nothindownherebutrats";
    level.scr_sound[var_13]["detroit_kva_copystayalert"] = "detroit_kva_copystayalert";
    level.scr_radio["detroit_kva_bauerdoyoureadme"] = "detroit_kva_bauerdoyoureadme";
    level.scr_sound[var_0]["detroit_brk_imexternal"] = "detroit_brk_imexternal";
    level.scr_sound[var_0]["detroit_brk_mitchelldownhere"] = "detroit_brk_mitchelldownhere";
    level.scr_sound[var_0]["detroit_brk_overheremitchell"] = "detroit_brk_overheremitchell";
    level.scr_sound[var_0]["detroit_brk_thoughtyouwerecompromised"] = "detroit_brk_thoughtyouwerecompromised";
    level.scr_sound[var_0]["detroit_brk_patrolupahead"] = "detroit_brk_patrolupahead";
    level.scr_sound[var_0]["detroit_brk_needtoaccelerateourtimeline"] = "detroit_brk_needtoaccelerateourtimeline";
    level.scr_sound[var_0]["detroit_brk_onyou"] = "detroit_brk_onyou";
    level.scr_sound[var_0]["detroit_brk_dropthemnow"] = "detroit_brk_dropthemnow";
    level.scr_sound[var_0]["detroit_brk_tooslow"] = "detroit_brk_tooslow";
    level.scr_sound[var_0]["detroit_brk_moreontheway"] = "detroit_brk_moreontheway";
    level.scr_sound[var_0]["detroit_brk_jokerineedasitrep"] = "detroit_brk_jokerineedasitrep";
    level.scr_radio["detroit_jkr_wereatthecheckpointon"] = "detroit_jkr_wereatthecheckpointon";
    level.scr_sound[var_0]["detroit_brk_engageatwill"] = "detroit_brk_engageatwill";
    level.scr_sound[var_0]["det_gdn_useyouroverdrive"] = "det_gdn_useyouroverdrive";
    level.scr_sound[var_0]["detroit_brk_theretheyareletsmove"] = "detroit_brk_theretheyareletsmove";
    level.scr_sound[var_0]["detroit_brk_statusonthedoctor"] = "detroit_brk_statusonthedoctor";
    level.scr_sound[var_1]["detroit_jkr_biometrictracehasalock"] = "detroit_jkr_biometrictracehasalock";
    level.scr_sound[var_0]["detroit_brk_good"] = "detroit_brk_good";
    level.scr_sound[var_1]["detroit_jkr_go"] = "detroit_jkr_go";
    level.scr_sound[var_0]["detroit_brk_drones"] = "detroit_brk_drones";
    level.scr_sound[var_0]["detroit_brk_hospitalonehundredmeters"] = "detroit_brk_hospitalonehundredmeters";
    level.scr_sound[var_1]["det_jkr_wegotnocoveron"] = "det_jkr_wegotnocoveron";
    level.scr_sound[var_0]["detroit_brk_thetruck"] = "detroit_brk_thetruck";
    level.scr_sound[var_0]["detroit_brk_useyourexo"] = "detroit_brk_useyourexo";
    level.scr_sound[var_0]["detroit_brk_parkercoverus"] = "detroit_brk_parkercoverus";
    level.scr_sound[var_0]["detroit_brk_push"] = "detroit_brk_push";
    level.scr_sound[var_0]["detroit_brk_mitchellpush"] = "detroit_brk_mitchellpush";
    level.scr_sound[var_0]["detroit_brk_entrypointtotheright"] = "detroit_brk_entrypointtotheright";
    level.scr_sound[var_0]["detroit_brk_movemove"] = "detroit_brk_movemove";
    level.scr_sound[var_1]["detroit_jkr_doctorsclose"] = "detroit_jkr_doctorsclose";
    level.scr_sound[var_0]["detroit_brk_aliveatallcosts"] = "detroit_brk_aliveatallcosts";
    level.scr_sound[var_0]["det_gdn_flashbang"] = "det_gdn_flashbang";
    level.scr_sound[var_0]["detroit_brk_setthebreach"] = "detroit_brk_setthebreach";
    level.scr_sound[var_0]["detroit_brk_mitchellsetthebreachcharge"] = "detroit_brk_mitchellsetthebreachcharge";
    level.scr_sound[var_0]["detroit_brk_securethedoor"] = "detroit_brk_securethedoor";
    level.scr_sound[var_17]["det_dcr_painreaction"] = "det_dcr_painreaction";
    level.scr_sound[var_17]["detroit_dcr_dontshoot"] = "detroit_dcr_dontshoot";
    level.scr_sound[var_0]["det_gdn_mitchellgrabhim"] = "det_gdn_mitchellgrabhim";
    level.scr_sound[var_0]["det_gdn_getthedoctormitchell"] = "det_gdn_getthedoctormitchell";
    level.scr_sound[var_0]["det_gdn_grabhimmitchell"] = "det_gdn_grabhimmitchell";
    level.scr_sound[var_0]["detroit_brk_seenyourpalhadesrecently"] = "detroit_brk_seenyourpalhadesrecently";
    level.scr_sound[var_17]["detroit_dcr_iwonttellyouanything"] = "detroit_dcr_iwonttellyouanything";
    level.scr_sound[var_0]["detroit_brk_thatswhattheyallsay"] = "detroit_brk_thatswhattheyallsay";
    level.scr_sound[var_17]["detroit_dcr_youthinkthischangesanything"] = "detroit_dcr_youthinkthischangesanything";
    level.scr_sound[var_1]["detroit_jkr_nottoday"] = "detroit_jkr_nottoday";
    level.scr_sound[var_0]["detroit_brk_baganddraghim"] = "detroit_brk_baganddraghim";
    level.scr_sound[var_1]["detroit_brk_withpleasure"] = "detroit_brk_withpleasure";
    level.scr_sound[var_0]["detroit_brk_prophetwehavethepackage"] = "detroit_brk_prophetwehavethepackage";
    level.scr_radio["detroit_prt_copythatbravotwoone"] = "detroit_prt_copythatbravotwoone";
    level.scr_sound[var_0]["detroit_brk_movingtotherv"] = "detroit_brk_movingtotherv";
    level.scr_sound[var_0]["detroit_brk_clear"] = "detroit_brk_clear";
    level.scr_sound[var_0]["detroit_brk_move2"] = "detroit_brk_move2";
    level.scr_sound[var_0]["detroit_brk_lockedmitchellhitit"] = "detroit_brk_lockedmitchellhitit";
    level.scr_sound[var_0]["detroit_brk_hitthedoormitchell"] = "detroit_brk_hitthedoormitchell";
    level.scr_radio["detroit_slr_freezenobodymove"] = "detroit_slr_freezenobodymove";
    level.scr_sound[var_0]["detroit_brk_notplanningtomate"] = "detroit_brk_notplanningtomate";
    level.scr_sound[var_1]["detroit_jkr_boss"] = "detroit_jkr_boss";
    level.scr_sound[var_0]["detroit_brk_easyjokerwerejusttalking"] = "detroit_brk_easyjokerwerejusttalking";
    level.scr_radio["detroit_slr_whosyourcatch"] = "detroit_slr_whosyourcatch";
    level.scr_sound[var_0]["detroit_brk_thatsclassified"] = "detroit_brk_thatsclassified";
    level.scr_radio["detroit_slr_reactionaryforcesareinbound"] = "detroit_slr_reactionaryforcesareinbound";
    level.scr_sound[var_0]["detroit_brk_iliketoknowwhos"] = "detroit_brk_iliketoknowwhos";
    level.scr_radio["detroit_slr_thatsclassifiedmate"] = "detroit_slr_thatsclassifiedmate";
    level.scr_sound[var_0]["detroit_brk_alrightletsmove"] = "detroit_brk_alrightletsmove";
    level.scr_sound[var_1]["detroit_jkr_thehellwasthat"] = "detroit_jkr_thehellwasthat";
    level.scr_sound[var_0]["detroit_brk_fuckknows"] = "detroit_brk_fuckknows";
    level.scr_sound[var_0]["detroit_brk_onthebikesmove"] = "detroit_brk_onthebikesmove";
    level.scr_sound[var_0]["detroit_brk_mitchellgetonthebike"] = "detroit_brk_mitchellgetonthebike";
    level.scr_sound[var_0]["det_brk_lookout"] = "det_brk_lookout";
    level.scr_sound[var_0]["detroit_brk_watchit"] = "detroit_brk_watchit";
    level.scr_sound[var_0]["detroit_brk_gogogo"] = "detroit_brk_gogogo";
    level.scr_sound[var_0]["det_brk_mitchellilostyou"] = "det_brk_mitchellilostyou";
    level.scr_sound[var_0]["det_brk_mitchellkeepup"] = "det_brk_mitchellkeepup";
    level.scr_sound[var_0]["det_brk_keepgoing"] = "det_brk_keepgoing";
    level.scr_sound[var_0]["detroit_brk_theresthegate"] = "detroit_brk_theresthegate";
    level.scr_sound[var_0]["det_brk_prophettargetissecured"] = "det_brk_prophettargetissecured";
    level.scr_sound[var_1]["detroit_jkr_hopethisassholeisworth"] = "detroit_jkr_hopethisassholeisworth";
    level.scr_sound[var_0]["detroit_brk_hewillbe"] = "detroit_brk_hewillbe";
}

init_dialogue_flags()
{
    common_scripts\utility::flag_init( "vo_refugee_camp_intro" );
    common_scripts\utility::flag_init( "vo_refugee_camp_meet_joker" );
    common_scripts\utility::flag_init( "vo_civ_convo_01" );
    common_scripts\utility::flag_init( "vo_refugee_camp_scanner" );
    common_scripts\utility::flag_init( "vo_refugee_camp_security_checkpoint" );
    common_scripts\utility::flag_init( "vo_camp_bike_ready" );
    common_scripts\utility::flag_init( "vo_autopilot_engaged" );
    common_scripts\utility::flag_init( "vo_drive_in" );
    common_scripts\utility::flag_init( "vo_drive_in_mech_scene" );
    common_scripts\utility::flag_init( "vo_school_exterior" );
    common_scripts\utility::flag_init( "vo_school_cleaning_crew_ahead" );
    common_scripts\utility::flag_init( "vo_school_checkpoint_blue" );
    common_scripts\utility::flag_init( "vo_school_light_burst_dialogue" );
    common_scripts\utility::flag_init( "vo_school_deadroom" );
    common_scripts\utility::flag_init( "vo_school_stairs" );
    common_scripts\utility::flag_init( "vo_school_thisway" );
    common_scripts\utility::flag_init( "vo_school_shimmy" );
    common_scripts\utility::flag_init( "vo_school_holdtight" );
    common_scripts\utility::flag_init( "vo_school_kva_checkcomms" );
    common_scripts\utility::flag_init( "vo_school_burke_post_fall" );
    common_scripts\utility::flag_init( "vo_school_basement_sawsomething" );
    common_scripts\utility::flag_init( "vo_school_basement_rats" );
    common_scripts\utility::flag_init( "vo_school_kva_copyalert" );
    common_scripts\utility::flag_init( "vo_school_burke_external" );
    common_scripts\utility::flag_init( "vo_alley_burke_downhere" );
    common_scripts\utility::flag_init( "vo_alley_burke_overhere" );
    common_scripts\utility::flag_init( "vo_alley_burke_reunite" );
    common_scripts\utility::flag_init( "vo_alley_burke_patrol" );
    common_scripts\utility::flag_init( "vo_alley_burke_too_slow" );
    common_scripts\utility::flag_init( "vo_alley_combat" );
    common_scripts\utility::flag_init( "vo_office_reunion_start" );
    common_scripts\utility::flag_init( "flicker_street_lights" );
    common_scripts\utility::flag_init( "vo_office_reunion_doctor" );
    common_scripts\utility::flag_init( "vo_exo_push_start" );
    common_scripts\utility::flag_init( "vo_exo_push_entry_point" );
    common_scripts\utility::flag_init( "vo_hospital_capture" );
    common_scripts\utility::flag_init( "vo_sentinel_reveal" );
    common_scripts\utility::flag_init( "vo_exit_drive_bikes_reached" );
    common_scripts\utility::flag_init( "vo_exit_drive_chopper_1" );
    common_scripts\utility::flag_init( "vo_exit_drive_dealership" );
    common_scripts\utility::flag_init( "vo_exit_drive_park_barrage" );
    common_scripts\utility::flag_init( "vo_exit_drive_building_interior" );
    common_scripts\utility::flag_init( "vo_exit_drive_trains_1" );
    common_scripts\utility::flag_init( "vo_exit_drive_jeeps_1" );
    common_scripts\utility::flag_init( "vo_exit_drive_jeeps_2" );
    common_scripts\utility::flag_init( "vo_exit_drive_chopper_3" );
    common_scripts\utility::flag_init( "vo_exit_drive_final_straightaway_1" );
}

start_dialogue_threads()
{
    thread refugee_camp_dialogue();
    thread drive_in_mech_checkpoint_dialogue();
    thread drive_in_dialogue();
    thread school_dialogue();
    thread alley_dialogue();
    thread office_dialogue();
    thread exo_push_dialogue();
    thread exo_push_exit_enter_hospital_dialogue();
    thread hospital_dialogue();
    thread sentintel_reveal_dialogue();
    thread exit_drive_prepare_dialogue();
    thread exit_drive_dialogue();
    thread exit_drive_failed_dialogue();
}

refugee_camp_dialogue()
{
    thread refugee_camp_intro_dialogue();
    thread refugee_camp_civ_convo_01();
    thread refugee_camp_security_checkpoint_dialogue();
    thread refugee_camp_autopilot_engaged();
    thread scanner_pa_vo();
}

refugee_camp_intro_dialogue()
{
    common_scripts\utility::flag_wait( "vo_refugee_camp_intro" );
    wait 7.8;
    common_scripts\utility::flag_wait( "vo_refugee_camp_meet_joker" );
    soundscripts\_snd::snd_message( "begin_intro_conversation" );
    level.joker maps\_utility::dialogue_queue( "detroit_jkr_burkeyoulooklikeshit" );
    wait 0.5;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_beengoingtwentytwodaysstraight" );
    wait 0.5;
    level.joker maps\_utility::dialogue_queue( "detroit_jkr_copythat" );
    level.joker maps\_utility::dialogue_queue( "detroit_jkr_theyweregoingtostart" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_theyreprotectingourtargetdr" );
    level.joker maps\_utility::dialogue_queue( "detroit_jkr_midtownhospitalweregreen" );
    level.burke maps\_utility::dialogue_queue( "det_gdn_letsgetitdone" );
    level notify( "end_intro_conversation" );
    common_scripts\utility::flag_set( "begin_pa_system_dialogue" );
    wait 10;
    soundscripts\_snd::snd_message( "start_stage_dialog" );
}

refugee_camp_civ_convo_01()
{
    common_scripts\utility::flag_wait( "vo_civ_convo_01" );
    level.civ1 maps\_utility::dialogue_queue( "detroit_cv1_istillhaventbeenable" );
    level.civ2 maps\_utility::dialogue_queue( "detroit_cv2_imsurehesfine" );
    level.civ3 maps\_utility::dialogue_queue( "detroit_cv3_theysayitsgoingto" );
    level.civ4 maps\_utility::dialogue_queue( "detroit_cv4_andyoutrustthem" );
    level.civ3 maps\_utility::dialogue_queue( "detroit_cv3_doihaveachoice" );
    soundscripts\_snd::snd_music_message( "end_refugee_camp_civ_convo_01" );
}

refugee_camp_security_checkpoint_dialogue()
{
    common_scripts\utility::flag_wait( "vo_refugee_camp_security_checkpoint" );
    wait 6.0;
    level.camp_scanner_guy maps\_utility::dialogue_queue( "detroit_atd_captain" );
    common_scripts\utility::flag_wait( "joker_deliver_decon_line" );
    wait 5.94;
    level.joker maps\_utility::dialogue_queue( "detroit_jkr_whatthehellarethe" );
    wait 1;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_anemptycitywithoutpolice" );
    level.camp_scanner_guy maps\_utility::dialogue_queue( "detroit_atd_cleargoodluckoutthere" );
    wait 3.0;
    level.bones maps\_utility::dialogue_queue( "detroit_trs_gideon" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_torresbikesready" );
    level.bones maps\_utility::dialogue_queue( "detroit_trs_rogergoodtogo" );
    wait 0.35;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_saddleupmitchell" );
    wait 1.5;
    common_scripts\utility::flag_set( "vo_camp_bike_ready" );
}

refugee_camp_autopilot_engaged()
{
    common_scripts\utility::flag_wait( "vo_camp_bike_ready" );
    thread burke_ask_player_to_use_bike();
    common_scripts\utility::flag_wait( "vo_autopilot_engaged" );
    wait 4;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_keepitonautopilotfor" );
    wait 4.5;
    level maps\_utility::dialogue_queue( "detroit_prt_bravotwooneweveisolatedthe" );
    wait 2;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_copyprophet" );
    level maps\_utility::dialogue_queue( "detroit_prt_thedoctorsnogoodto" );
    wait 0.25;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_rogerbravoout" );
}

pa_system_filler_after_joker()
{
    common_scripts\utility::flag_wait( "begin_pa_system_dialogue" );
    wait 3.25;
    maps\_utility::dialogue_queue( "detroit_pa_attentioncurfewisinone2" );
    wait 0.82;
    maps\_utility::dialogue_queue( "detroit_pa_remembertohaveyouridentification2" );
    wait 1.16;
    maps\_utility::dialogue_queue( "detroit_pa_reportanysuspiciousactivityto2" );
    wait 1.62;
    maps\_utility::dialogue_queue( "detroit_pa_noncompliancewithyoursecurityprotocol2" );
}

scanner_pa_vo()
{
    common_scripts\utility::flag_wait( "vo_refugee_camp_scanner" );
    wait 0.5;
    maps\_utility::dialogue_queue( "det_cmr1_scanningforisotopespleasewait" );
}

burke_ask_player_to_use_bike()
{
    level endon( "player_has_used_bike" );
    var_0 = 0;
    var_1 = 0;

    for (;;)
    {
        wait(randomfloatrange( 4, 7 ));

        if ( var_0 == 0 )
        {
            if ( common_scripts\utility::flag( "begin_player_mount_bike" ) )
                return;

            level.burke maps\_utility::dialogue_queue( "detroit_brk_getonthebike" );
            var_0++;
        }

        wait(randomfloatrange( 4, 7 ));

        if ( var_0 == 1 )
        {
            if ( common_scripts\utility::flag( "begin_player_mount_bike" ) )
                return;

            level.burke maps\_utility::dialogue_queue( "detroit_brk_letshititmitchell" );
            var_0++;
        }

        wait(randomfloatrange( 4, 7 ));

        if ( var_0 == 2 )
        {
            var_2 = randomint( 3 );

            if ( var_2 < 2 )
            {
                if ( common_scripts\utility::flag( "begin_player_mount_bike" ) )
                    return;

                level.burke maps\_utility::dialogue_queue( "det_gdn_moveitforfuckssake" );
                var_0 = 0;
            }
            else
                var_0 = 0;
        }
    }
}

drive_in_mech_checkpoint_dialogue()
{
    common_scripts\utility::flag_wait( "vo_drive_in_mech_scene" );
    wait 28;
    level.hoverbike_meet_up_mech1 maps\_utility::dialogue_queue( "detroit_mch_nameandordernumber" );
    wait 0.5;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_burkeorder5527" );
    wait 1.5;
    level.hoverbike_meet_up_mech1 maps\_utility::dialogue_queue( "detroit_mch_holdon" );
    wait 2.0;
    level.hoverbike_meet_up_mech1 maps\_utility::dialogue_queue( "det_mch_gotfouroperativesonbikes" );
    common_scripts\utility::flag_set( "portal_grp_gate_on" );
    wait 2.0;
    level.hoverbike_meet_up_mech1 maps\_utility::dialogue_queue( "detroit_mch_okyouregood" );
}

drive_in_dialogue()
{
    common_scripts\utility::flag_wait( "vo_drive_in" );
    wait 3.6;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_prophetbravotwoone" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_staylockedon" );
    wait 7;
    level.bones maps\_utility::dialogue_queue( "detroit_trs_cantbelievethisisdetroit" );
    wait 1;
    level.joker maps\_utility::dialogue_queue( "detroit_jkr_hasntchangedthatmuch" );
    wait 18;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_linkuppointupahead" );
    wait 2;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_prophetbravotwooneatlinkuppoint" );
    level maps\_utility::dialogue_queue( "detroit_prt_rogerthatbravotwoone" );
}

school_dialogue()
{
    thread school_exterior_dialogue();
    thread school_exterior_cleaning_crew_dialogue();
    thread school_enter_dialogue();
    thread school_light_burst_dialogue();
    thread school_deadroom_dialogue();
    thread school_stairs_dialogue();
    thread school_thisway_dialogue();
    thread school_shimmy_dialogue();
    thread school_kva_basement_rats_dialogue();
    thread school_burke_external();
}

school_exterior_dialogue()
{
    common_scripts\utility::flag_wait( "vo_school_exterior" );
    soundscripts\_snd::snd_message( "walk_to_school" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_jokerparkeryouknowyour" );
    level.joker maps\_utility::dialogue_queue( "detroit_jkr_rogerthat" );
    wait 5;
    level maps\_utility::dialogue_queue( "detroit_prt_isrdetectingmovementnorthwest" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_wellkeepourheadson" );
}

school_exterior_cleaning_crew_dialogue()
{
    common_scripts\utility::flag_wait( "vo_school_cleaning_crew_ahead" );
    wait 2;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_cleanupcrewupahead" );
    wait 2;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_watchyourroemaintainstealth" );
}

school_enter_dialogue()
{
    common_scripts\utility::flag_wait( "vo_school_checkpoint_blue" );
    wait 8;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_prophetwereatcheckpointblue" );
    level maps\_utility::dialogue_queue( "detroit_prt_copyweretrackingyou" );
}

school_light_burst_dialogue()
{
    common_scripts\utility::flag_wait( "vo_school_light_burst_dialogue" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_shit" );
    wait 3.2;
    level.burke maps\_utility::dialogue_queue( "det_gdn_scoff" );
}

school_deadroom_dialogue()
{
    common_scripts\utility::flag_wait( "vo_school_deadroom" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_fuckme" );
    wait 5;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_jokerivegotbodies" );
    level maps\_utility::dialogue_queue( "detroit_jkr_copy3" );
    wait 1;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_ifthekvahavebeen" );
    wait 6;
    common_scripts\utility::flag_set( "burke_needs_to_idle" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_mitchelltakepoint" );
}

school_stairs_dialogue()
{
    common_scripts\utility::flag_wait( "vo_school_stairs" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_upthestairs" );
    soundscripts\_snd::snd_message( "school_upthestairs" );
}

school_thisway_dialogue()
{
    common_scripts\utility::flag_wait( "vo_school_thisway" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_thisway" );
}

school_shimmy_dialogue()
{
    common_scripts\utility::flag_wait( "vo_school_shimmy" );
    level.school_kva_fall_notice_guy.animname = "kva";
    level maps\_utility::dialogue_queue( "detroit_kva_whatwasthat" );
    wait 0.5;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_easy" );
    wait 1;
    level.school_kva_fall_notice_guy maps\_utility::dialogue_queue( "detroit_kva_overhere" );
    wait 1.5;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_letthempass" );
    common_scripts\utility::flag_wait( "vo_school_holdtight" );
    wait 8;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_mitchellmitchell2" );
    common_scripts\utility::flag_wait( "vo_school_kva_checkcomms" );
    common_scripts\utility::flag_wait( "vo_school_burke_post_fall" );
    wait 4;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_mitchellmitchell" );
    wait 5;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_mitchellimseeingalot" );
}

school_kva_basement_dialogue()
{
    level endon( "kva_thoughtisawsomething" );
    var_0 = common_scripts\utility::flag_wait( "vo_school_basement_sawsomething" );

    if ( isdefined( var_0 ) )
    {
        if ( !isdefined( var_0.animname ) )
            var_0.animname = "kva";
        else if ( var_0.animname != "kva" )
            return;

        var_0 thread maps\_utility::dialogue_queue( "detroit_kva_thoughtisawsomething" );
        level notify( "kva_thoughtisawsomething" );
    }
}

school_kva_basement_rats_dialogue()
{
    common_scripts\utility::flag_wait( "vo_school_basement_rats" );
    wait 27.03;
    level.kva_basement_guy endon( "spotted_player" );
    level.flashlight_guy endon( "spotted_player" );
    common_scripts\utility::flag_wait( "copy_that_stay_alert" );
    wait 2.5;
}

school_burke_external()
{
    level endon( "vo_alley_burke_downhere" );
    common_scripts\utility::flag_wait( "vo_school_burke_external" );
    wait 4;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_imexternal" );
}

alley_dialogue()
{
    thread alley_beckon();
    thread alley_meetup_dialogue();
}

alley_beckon()
{
    common_scripts\utility::flag_wait( "vo_alley_burke_downhere" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_mitchelldownhere" );
    common_scripts\utility::flag_wait( "vo_alley_burke_overhere" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_overheremitchell" );
}

alley_meetup_dialogue()
{
    level endon( "stop_burke_asking_player_to_drop_patrol" );
    common_scripts\utility::flag_wait( "vo_alley_burke_reunite" );
    thread alley_fail_dialogue();
    thread alley_combat_dialogue();
    level.burke maps\_utility::dialogue_queue( "detroit_brk_thoughtyouwerecompromised" );
    common_scripts\utility::flag_wait( "vo_alley_burke_patrol" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_patrolupahead" );

    if ( common_scripts\utility::flag( "stop_burke_asking_player_to_drop_patrol" ) == 0 )
    {
        level.burke maps\_utility::dialogue_queue( "detroit_brk_needtoaccelerateourtimeline" );
        wait 2;
    }

    if ( common_scripts\utility::flag( "stop_burke_asking_player_to_drop_patrol" ) == 0 )
    {
        level.burke maps\_utility::dialogue_queue( "detroit_brk_onyou" );
        wait 2;
    }

    if ( common_scripts\utility::flag( "stop_burke_asking_player_to_drop_patrol" ) == 0 )
    {
        level.burke maps\_utility::dialogue_queue( "detroit_brk_dropthemnow" );
        wait 3;
    }
}

alley_fail_dialogue()
{
    common_scripts\utility::flag_wait( "vo_alley_burke_too_slow" );

    if ( !common_scripts\utility::flag( "one_street_guy_dead_kickoff_fight_now" ) )
        level.burke maps\_utility::dialogue_queue( "detroit_brk_tooslow" );
}

alley_combat_dialogue()
{
    common_scripts\utility::flag_wait( "vo_alley_combat" );
    level notify( "stop_burke_asking_player_to_drop_patrol" );

    if ( !common_scripts\utility::flag( "vo_alley_burke_too_slow" ) )
    {
        if ( isdefined( level.burke.function_stack ) )
            level.burke maps\_utility::function_stack_clear();

        level.burke stopsounds();
        maps\_utility::radio_dialogue_stop();
    }

    soundscripts\_snd::snd_message( "mus_alley_combat" );
    wait 2;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_moreontheway" );
}

office_dialogue()
{
    thread office_interior_dialogue();
    thread office_atrium_dialogue();
    thread player_reached_window();
    thread office_reunion_dialogue();
}

office_interior_dialogue()
{
    common_scripts\utility::flag_wait( "sitrep_dialogue_line" );
    wait 1;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_jokerineedasitrep" );
    wait 1;
    level maps\_utility::dialogue_queue( "detroit_jkr_wereatthecheckpointon" );
    wait 1;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_engageatwill" );
}

office_atrium_dialogue()
{
    common_scripts\utility::flag_wait( "spawn_second_floor_spawners" );
    wait 2.3;
    level.burke maps\_utility::dialogue_queue( "det_gdn_useyouroverdrive" );
}

player_reached_window()
{
    common_scripts\utility::flag_wait( "move_burke_down" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_theretheyareletsmove" );
}

office_reunion_dialogue()
{
    common_scripts\utility::flag_wait( "vo_office_reunion_start" );
    var_0 = 1;

    while ( var_0 == 1 )
    {
        if ( !isdefined( level.joker ) )
            wait 0.05;

        if ( isdefined( level.joker ) )
            var_0 = 0;
    }

    while ( !level.burke cansee( level.joker ) )
        wait 0.1;

    soundscripts\_snd::snd_message( "office_reunion_dialogue" );
    common_scripts\utility::flag_wait( "vo_office_reunion_doctor" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_statusonthedoctor" );
    level.joker maps\_utility::dialogue_queue( "detroit_jkr_biometrictracehasalock" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_good" );
    common_scripts\utility::flag_set( "flag_send_team_to_the_truck" );
}

exo_push_dialogue()
{
    level endon( "stop_vo_for_exo_push" );
    common_scripts\utility::flag_wait_any( "vo_exo_push_start", "flag_send_team_to_the_truck" );
    level.joker maps\_utility::dialogue_queue( "det_jkr_wegotnocoveron" );
    wait 0.5;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_thetruck" );
    wait 3;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_hospitalonehundredmeters" );
    wait 0.5;
    level.joker maps\_utility::dialogue_queue( "detroit_jkr_go" );
    common_scripts\utility::flag_set( "send_bones_joker_to_cover1" );
    wait 2;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_parkercoverus" );
    exo_push_begin_nag_loop();
}

exo_push_begin_nag_loop()
{
    for (;;)
    {
        wait 4;

        if ( !common_scripts\utility::flag( "exo_push_has_been_started" ) )
            level.burke maps\_utility::dialogue_queue( "detroit_brk_push" );
        else if ( common_scripts\utility::flag( "exo_push_has_been_started" ) )
            return;

        wait 6;

        if ( !common_scripts\utility::flag( "exo_push_has_been_started" ) )
        {
            level.burke maps\_utility::dialogue_queue( "detroit_brk_mitchellpush" );
            continue;
        }

        if ( common_scripts\utility::flag( "exo_push_has_been_started" ) )
            return;
    }
}

exo_push_exit_enter_hospital_dialogue()
{
    common_scripts\utility::flag_wait( "vo_exo_push_entry_point" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_entrypointtotheright" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_movemove" );
}

hospital_dialogue()
{
    thread hospital_entry_dialogue();
    thread hospital_breach_prep_dialogue();
    thread hospital_capture_dialogue();
}

hospital_entry_dialogue()
{
    common_scripts\utility::flag_wait( "vo_hospital_entry" );
    level.joker maps\_utility::dialogue_queue( "detroit_jkr_doctorsclose" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_aliveatallcosts" );
    common_scripts\utility::flag_wait( "flashbang" );
    wait 0.4;
    level.burke maps\_utility::dialogue_queue( "det_gdn_flashbang" );
}

hospital_breach_prep_dialogue()
{
    level endon( "player breached and survived" );
    common_scripts\utility::flag_wait( "vo_hospital_breach_prep" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_setthebreach" );
    wait 5;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_mitchellsetthebreachcharge" );
    wait 3;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_securethedoor" );

    for (;;)
    {
        wait(randomintrange( 3, 7 ));
        var_0 = randomint( 2 );

        if ( var_0 == 0 )
        {
            level.burke maps\_utility::dialogue_queue( "detroit_brk_mitchellsetthebreachcharge" );
            continue;
        }

        level.burke maps\_utility::dialogue_queue( "detroit_brk_securethedoor" );
    }
}

hospital_capture_dialogue()
{
    common_scripts\utility::flag_wait( "grab_the_doctor" );
    level.doctor thread maps\_utility::dialogue_queue( "detroit_dcr_dontshoot" );
    soundscripts\_snd::snd_message( "det_start_doctor_breathing", level.doctor );
    common_scripts\utility::flag_set( "show_grab_doctor_prompt" );
    wait 0.8;
    level.burke maps\_utility::dialogue_queue( "det_gdn_mitchellgrabhim" );
    thread grab_doctor_loop();
}

grab_doctor_loop()
{
    for (;;)
    {
        wait(randomintrange( 5, 8 ));

        if ( common_scripts\utility::flag( "doctor_grabbed" ) )
            return;
        else if ( !common_scripts\utility::flag( "doctor_grabbed" ) )
            level.burke maps\_utility::dialogue_queue( "det_gdn_getthedoctormitchell" );

        wait(randomintrange( 4, 6 ));

        if ( common_scripts\utility::flag( "doctor_grabbed" ) )
            return;
        else if ( !common_scripts\utility::flag( "doctor_grabbed" ) )
            level.burke maps\_utility::dialogue_queue( "det_gdn_grabhimmitchell" );
    }
}

sentintel_reveal_dialogue()
{
    thread sentinel_reveal_moment_dialogue();
}

sentintel_reveal_door_dialogue()
{
    level endon( "vo_sentinel_reveal" );
    common_scripts\utility::flag_wait( "vo_sentinel_reveal_door" );
    wait 5;
}

sentinel_reveal_moment_dialogue()
{
    level endon( "reached_the_bikes" );
    common_scripts\utility::flag_wait( "vo_sentinel_reveal" );
    wait 6;
    wait 9.25;
    common_scripts\utility::flag_set( "sentinel_recloak" );
    wait 2;
}

exit_drive_prepare_dialogue()
{
    common_scripts\utility::flag_wait( "exit_drive_cinematic_start" );
    wait 1;
    level.joker maps\_utility::dialogue_queue( "detroit_jkr_thehellwasthat" );
    wait 0.3;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_fuckknows" );
    wait 2.8;

    if ( common_scripts\utility::flag( "player_on_exitdrive_jetbike" ) == 0 )
    {
        level.burke maps\_utility::dialogue_queue( "detroit_brk_onthebikesmove" );
        thread exit_drive_prepare_dialogue_nag();
    }
}

exit_drive_prepare_dialogue_nag()
{
    for (;;)
    {
        wait(randomintrange( 5, 8 ));

        if ( common_scripts\utility::flag( "player_on_exitdrive_jetbike" ) )
            return;

        if ( !common_scripts\utility::flag( "player_on_exitdrive_jetbike" ) )
            level.burke maps\_utility::dialogue_queue( "detroit_brk_mitchellgetonthebike" );

        wait(randomintrange( 5, 8 ));

        if ( common_scripts\utility::flag( "player_on_exitdrive_jetbike" ) )
            return;

        if ( !common_scripts\utility::flag( "player_on_exitdrive_jetbike" ) )
            level.burke maps\_utility::dialogue_queue( "detroit_brk_onthebikesmove" );
    }
}

exit_drive_dialogue()
{
    common_scripts\utility::flag_wait( "exit_drive_started" );
    wait 1;
    level.burke maps\_utility::dialogue_queue( "detroit_brk_gogogo" );
    soundscripts\_snd::snd_music_message( "mus_exit_drive" );
    common_scripts\utility::flag_wait( "vo_exit_drive_chopper_1" );
    common_scripts\utility::flag_wait( "vo_exit_drive_dealership" );
    common_scripts\utility::flag_wait( "vo_exit_drive_park_barrage" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_watchit" );
    common_scripts\utility::flag_wait( "vo_exit_drive_building_interior" );
    common_scripts\utility::flag_wait( "vo_exit_drive_trains_1" );
    level.burke maps\_utility::dialogue_queue( "det_brk_lookout" );
    common_scripts\utility::flag_wait( "vo_exit_drive_jeeps_1" );
    common_scripts\utility::flag_wait( "vo_exit_drive_jeeps_2" );
    common_scripts\utility::flag_wait( "vo_exit_drive_chopper_3" );
    common_scripts\utility::flag_wait( "vo_exit_drive_final_straightaway_1" );
    common_scripts\utility::flag_wait( "flag_gate_in_sight" );
    level.burke maps\_utility::dialogue_queue( "detroit_brk_theresthegate" );
    level waittill( "detroit_ending_VO" );
    wait 4;
    level.burke maps\_utility::dialogue_queue( "det_brk_prophettargetissecured" );
}

exit_drive_failed_dialogue()
{
    level waittill( "exit_drive_failed" );
    level.burke maps\_utility::dialogue_queue( "det_brk_mitchellilostyou" );
}

#using_animtree("generic_human");

init_pcap_vo()
{
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %det_camp_intro_burke, "aud_det_camp_intro_burke_start", ::det_intro_gdn );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %det_doctor_capture_burke_hit_doc, "aud_start_aft_doctor_capture_guy1", ::det_doc_cap_gdn );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %det_doctor_capture_doc_react, "aud_start_aft_doctor_capture_guy1", ::det_doc_cap_doc );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %det_doctor_capture_joker_grab_doc, "aud_start_aft_doctor_capture_guy1", ::det_doc_cap_jkr );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %det_hos_sent_meet_burke, "aud_start_aft_sentinel_meetup", ::det_sent_meet_brk );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %det_hos_sent_meet_guy1, "aud_start_aft_sentinel_meetup", ::det_sent_meet_knx );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %det_hos_sent_meet_joker, "aud_start_aft_sentinel_meetup", ::det_sent_meet_jkr );
}

det_intro_gdn( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "det_gdn_welcometodetroit", 4.15 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "det_gdn_twoandahalfmillion", 7.09 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "det_gdn_nofuckinholidaybutthey", 10.24 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "det_gdn_nowthekvahavethe", 15.12 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "det_gdn_fuckme", 19.12 );
}

det_doc_cap_gdn( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "detroit_brk_seenyourpalhadesrecently", 2.27 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "detroit_brk_thatswhattheyallsay", 8.29 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "detroit_brk_baganddraghim", 21.15 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "det_gdn_mitchellonme", 24.06, "sounddone_det_gdn_mitchellonme" );
    thread wait_for_sounddone_det_gdn_mitchellonme();
}

wait_for_sounddone_det_gdn_mitchellonme()
{
    level waittill( "sounddone_det_gdn_mitchellonme" );
    soundscripts\_snd::snd_music_message( "mus_sounddone_det_gdn_mitchellonme" );
}

det_doc_cap_doc( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "detroit_dcr_iwonttellyouanything", 8.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "detroit_dcr_youthinkthischangesanything", 12.09 );
}

det_doc_cap_jkr( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "detroit_jkr_nottoday", 18.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "detroit_brk_withpleasure", 22.21 );
}

det_sent_meet_brk( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "det_gdn_iliketoknowwhose", 14.12 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "det_gdn_notsurewehavea", 24.18 );
}

det_sent_meet_knx( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "det_knx_reactionaryforcesareinboundwe", 7.21 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "det_knx_thatsclassifiedmate", 16.27 );
    wait 17;
    soundscripts\_snd::snd_message( "det_knx_thatsclassifiedmate" );
}

det_sent_meet_jkr( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "det_jkr_yousurewereokaywith", 22.18 );
    wait 23;
    soundscripts\_snd::snd_message( "sentinel_reveal_final_vo" );
}

#using_animtree("player");

init_plr_vo()
{
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %det_school_fall_vm, "aud_det_school_fall_start", ::det_school_fall_plr );
}

det_school_fall_plr( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "det_plr_fall_01", 0.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "det_plr_fall_02", 13.18 );
}
