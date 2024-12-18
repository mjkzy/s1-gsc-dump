// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    init_dialogue_flags();
    setup_vo();
    thread init_pcap_vo();
    thread init_plr_vo();
}

init_dialogue_flags()
{
    common_scripts\utility::flag_init( "vo_cart_push" );
}

setup_vo()
{
    var_0 = "ally_0";
    var_1 = "ally_1";
    var_2 = "ally_2";
    var_3 = "scientist_0";
    var_4 = "tech";
    var_5 = "doctor";
    var_6 = "ah_tech_1";
    var_7 = "ah_tech_2";
    var_8 = "guard_0";
    var_9 = "guard_1";
    var_10 = "guard_2";
    var_11 = "guard_3";
    var_12 = "general_1";
    var_13 = "drug_doctor";
    var_14 = "guard_end";
    level.scr_sound[var_0]["cap_gdn_cormack"] = "cap_gdn_cormack";
    level.scr_sound[var_2]["cap_crk_gideon"] = "cap_crk_gideon";
    level.scr_sound[var_10]["cap_gr1_everyoneoffthetruck"] = "cap_gr1_everyoneoffthetruck";
    level.scr_sound[var_12]["cap_gr1_cmonguysgetem"] = "cap_gr1_cmonguysgetem";
    level.scr_sound[var_0]["cap_gdn_groundhitgrunt"] = "cap_gdn_groundhitgrunt";
    level.scr_sound[var_1]["cap_iln_groundhitgrunt"] = "cap_iln_groundhitgrunt";
    level.scr_sound[var_12]["cap_gr2_thatsallofem"] = "cap_gr2_thatsallofem";
    level.scr_sound[var_12]["cap_gr3_mover12youreall"] = "cap_gr3_mover12youreall";
    level.scr_sound[var_10]["cap_gr8_pencomingopen"] = "cap_gr8_pencomingopen";
    level.scr_sound[var_12]["cap_gr2_thesetwocpen"] = "cap_gr2_thesetwocpen";
    level.scr_sound[var_9]["cap_gr2_intothecage"] = "cap_gr2_intothecage";
    level.scr_sound[var_11]["cap_gr1_therestofyoubehind_alt01"] = "cap_gr1_therestofyoubehind_alt01";
    level.scr_sound[var_10]["cap_gr2_move"] = "cap_gr2_move";
    level.scr_sound[var_12]["cap_gr2_getinthecage"] = "cap_gr2_getinthecage";
    level.scr_sound[var_12]["cap_gr2_getinside"] = "cap_gr2_getinside";
    level.scr_sound[var_12]["cap_gr2_getmoving2"] = "cap_gr2_getmoving2";
    level.scr_sound[var_11]["cap_gr2_penfillingup"] = "cap_gr2_penfillingup";
    level.scr_sound[var_10]["cap_gr1_pasttheline"] = "cap_gr1_pasttheline";
    level.scr_sound[var_11]["cap_gr2_4goingdowntozero"] = "cap_gr2_4goingdowntozero";
    level.scr_sound[var_11]["cap_gr3_4takingtheride"] = "cap_gr3_4takingtheride";
    level.scr_sound[var_10]["cap_gr2_youreclearfordelivery"] = "cap_gr2_youreclearfordelivery";
    level.scr_sound[var_10]["cap_gr2_penclosingupsecure"] = "cap_gr2_penclosingupsecure";
    level.scr_sound[var_10]["cap_gr3_bringemin"] = "cap_gr3_bringemin";
    level.scr_sound[var_11]["cap_gr5_stepforward"] = "cap_gr5_stepforward";
    level.scr_sound[var_10]["cap_gr8_pencomingopen"] = "cap_gr8_pencomingopen";
    level.scr_sound[var_9]["cap_gr4_alrightletsgoguys"] = "cap_gr4_alrightletsgoguys";
    level.scr_sound[var_10]["cap_gr5_moveit"] = "cap_gr5_moveit";
    level.scr_sound[var_11]["cap_gr5_moveitnow"] = "cap_gr5_moveitnow";
    level.scr_sound[var_11]["cap_gr17_comeonthisway"] = "cap_gr17_comeonthisway";
    level.scr_sound[var_11]["cap_gr20_herenow"] = "cap_gr20_herenow";
    level.scr_sound[var_11]["cap_gr20_letsgo"] = "cap_gr20_letsgo";
    level.scr_sound[var_11]["cap_gr20_startwalking"] = "cap_gr20_startwalking";
    level.scr_sound[var_11]["cap_gr20_getoverhere"] = "cap_gr20_getoverhere";
    level.scr_sound[var_11]["cap_gr20_prisonercomehere"] = "cap_gr20_prisonercomehere";
    level.scr_sound[var_11]["cap_gr20_prisonerhere"] = "cap_gr20_prisonerhere";
    level.scr_sound[var_0]["cap_iln_ohmygod"] = "cap_iln_ohmygod";
    level.scr_sound[var_14]["cap_gr10_shutupgetonyour"] = "cap_gr10_shutupgetonyour";
    level.scr_sound[var_10]["cap_gr4_sendingthepenbackup"] = "cap_gr4_sendingthepenbackup";
    level.scr_sound[var_11]["cap_gr5_letsstartwalking"] = "cap_gr5_letsstartwalking";
    level.scr_sound[var_14]["cap_gr17_comeonthisway"] = "cap_gr17_comeonthisway";
    level.scr_sound[var_8]["cap_gr2_movealong"] = "cap_gr2_movealong";
    level.scr_sound[var_14]["cap_gr4_stoplookin"] = "cap_gr4_stoplookin";
    level.scr_sound[var_14]["cap_gr4_whatareyoulooking"] = "cap_gr4_whatareyoulooking";
    level.scr_sound[var_14]["cap_gr7_fourcomingin2"] = "cap_gr7_fourcomingin2";
    level.scr_sound[var_14]["cap_gr4_rogerthatcblock"] = "cap_gr4_rogerthatcblock";
    level.scr_sound[var_14]["cap_gr5_alrightpeoplethrough"] = "cap_gr5_alrightpeoplethrough";
    level.scr_sound[var_14]["cap_gr4_clearedcblocklocking"] = "cap_gr4_clearedcblocklocking";
    level.scr_sound[var_9]["cap_gr7_getmoving"] = "cap_gr7_getmoving";
    level.scr_sound[var_9]["cap_gr11_wegotincomingtoc6"] = "cap_gr11_wegotincomingtoc6";
    level.scr_sound[var_9]["cap_gr9_copythatprisoners"] = "cap_gr9_copythatprisoners";
    level.scr_sound[var_8]["cap_gr8_thatsfarenough"] = "cap_gr8_thatsfarenough";
    level.scr_sound[var_8]["cap_gr8_openthechute"] = "cap_gr8_openthechute";
    level.scr_sound[var_9]["cap_gr7_onthefloor"] = "cap_gr7_onthefloor";
    level.scr_sound[var_9]["cap_gr7_stayput"] = "cap_gr7_stayput";
    level.scr_sound[var_11]["cap_gr7_open"] = "cap_gr7_open";
    level.scr_sound[var_11]["cap_gr7_clear"] = "cap_gr7_clear";
    level.scr_sound[var_8]["cap_gr8_wiresout"] = "cap_gr8_wiresout";
    level.scr_sound[var_8]["cap_gr8_hookemup"] = "cap_gr8_hookemup";
    level.scr_sound[var_8]["cap_gr8_go"] = "cap_gr8_go";
    level.scr_sound[var_11]["cap_gr8_isaiddown"] = "cap_gr8_isaiddown";
    level.scr_sound[var_9]["cap_gr7_haveanicedayasshole_alt01"] = "cap_gr7_haveanicedayasshole_alt01";
    level.scr_sound[var_8]["cap_gr8_wegotfourinthe"] = "cap_gr8_wegotfourinthe";
    level.scr_sound[var_8]["cap_gr9_fourrogerbringem"] = "cap_gr9_fourrogerbringem";
    level.scr_sound[var_8]["cap_gr8_preppingguests"] = "cap_gr8_preppingguests";
    level.scr_sound[var_0]["cap_gdn_gruntsstruggles"] = "cap_gdn_gruntsstruggles";
    level.scr_sound[var_0]["cap_gdn_gruntsstruggles_alt01"] = "cap_gdn_gruntsstruggles_alt01";
    level.scr_sound[var_14]["cap_gr5_alrightpeoplethrough"] = "cap_gr5_alrightpeoplethrough";
    level.scr_sound[var_9]["cap_gr16_imcoming"] = "cap_gr16_imcoming";
    level.scr_sound[var_9]["cap_gr16_struckbygideongrunting"] = "cap_gr16_struckbygideongrunting";
    level.scr_sound[var_9]["cap_gr16_noi"] = "cap_gr16_noi";
    level.scr_sound[var_0]["cap_gdn_youlooklikehissize"] = "cap_gdn_youlooklikehissize";
    level.scr_sound[var_0]["cap_gdn_grabhispistol"] = "cap_gdn_grabhispistol";
    level.scr_sound[var_0]["cap_gdn_herewithonewing"] = "cap_gdn_herewithonewing";
    level.scr_sound[var_0]["cap_gdn_somakeeveryshotcount"] = "cap_gdn_somakeeveryshotcount";
    level.scr_sound[var_0]["cap_gdn_ready3"] = "cap_gdn_ready3";
    level.scr_sound[var_0]["cap_gdn_mitchelldontshoot"] = "cap_gdn_mitchelldontshoot";
    level.scr_sound[var_0]["cap_gdn_thislookslikesurface"] = "cap_gdn_thislookslikesurface";
    level.scr_sound[var_0]["cap_gdn_illanathisway"] = "cap_gdn_illanathisway";
    level.scr_sound[var_0]["cap_gdn_mitchellgetonthat"] = "cap_gdn_mitchellgetonthat";
    level.scr_sound[var_0]["cap_gdn_hurryupcmonmove"] = "cap_gdn_hurryupcmonmove";
    level.scr_sound[var_1]["cap_iln_cormackslookingbad"] = "cap_iln_cormackslookingbad";
    level.scr_sound[var_2]["cap_crk_icanmakeit"] = "cap_crk_icanmakeit";
    level.scr_sound[var_0]["cap_gdn_dropit"] = "cap_gdn_dropit";
    level.scr_sound[var_0]["cap_gdn_getdown"] = "cap_gdn_getdown";
    level.scr_sound[var_10]["cap_gr11_freezegetdown"] = "cap_gr11_freezegetdown";
    level.scr_sound[var_11]["cap_gr12_youontheconsole"] = "cap_gr12_youontheconsole";
    level.scr_sound[var_0]["cap_gdn_mitchellstaythere"] = "cap_gdn_mitchellstaythere";
    level.scr_sound[var_10]["cap_gr11_getdownnow_alt01"] = "cap_gr11_getdownnow_alt01";
    level.scr_sound[var_0]["cap_gdn_iwillopenfire"] = "cap_gdn_iwillopenfire";
    level.scr_sound[var_0]["cap_gdn_damn"] = "cap_gdn_damn";
    level.scr_sound[var_1]["cap_iln_whathappened"] = "cap_iln_whathappened";
    level.scr_sound[var_0]["cap_gdn_doorslocked"] = "cap_gdn_doorslocked";
    level.scr_sound[var_0]["cap_gdn_standback"] = "cap_gdn_standback";
    level.scr_sound[var_0]["cap_gdn_gettopsidewell"] = "cap_gdn_gettopsidewell";
    level.scr_sound[var_1]["cap_iln_alright"] = "cap_iln_alright";
    level.scr_sound[var_0]["cap_gdn_letsmove"] = "cap_gdn_letsmove";
    level.scr_sound[var_0]["cap_gdn_illonailonadoyou"] = "cap_gdn_illonailonadoyou";
    level.scr_sound[var_0]["cap_gdn_mitchellwegottaget"] = "cap_gdn_mitchellwegottaget";
    level.scr_sound[var_0]["cap_gdn_ifiknowilonashell"] = "cap_gdn_ifiknowilonashell";
    level.scr_sound[var_0]["cap_gdn_letsnotkeepherwaiting"] = "cap_gdn_letsnotkeepherwaiting";
    level.scr_sound[var_0]["cap_gdn_upherestayquiet"] = "cap_gdn_upherestayquiet";
    level.scr_sound[var_0]["cap_gdn_manticorestrikeshes"] = "cap_gdn_manticorestrikeshes";
    level.scr_sound[var_0]["cap_gdn_washingtonnewyork"] = "cap_gdn_washingtonnewyork";
    level.scr_sound[var_0]["cap_gdn_illgrabthetallbloke"] = "cap_gdn_illgrabthetallbloke";
    level.scr_sound[var_0]["cap_gdn_staycalmshutup"] = "cap_gdn_staycalmshutup";
    level.scr_sound[var_3]["cap_sc9_who"] = "cap_sc9_who";
    level.scr_sound[var_3]["cap_tc1_oof"] = "cap_tc1_oof";
    level.scr_sound[var_0]["cap_gdn_theexitwhereis"] = "cap_gdn_theexitwhereis";
    level.scr_sound[var_0]["cap_gdn_thanks"] = "cap_gdn_thanks";
    level.scr_sound[var_0]["cap_gdn_youheardhimthis"] = "cap_gdn_youheardhimthis";
    level.scr_sound[var_0]["cap_gdn_downhere"] = "cap_gdn_downhere";
    level.scr_sound[var_0]["cap_iln_gideonareyouthere"] = "cap_iln_gideonareyouthere";
    level.scr_sound[var_0]["cap_gdn_illonailonadoyou"] = "cap_gdn_illonailonadoyou";
    level.scr_sound[var_0]["cap_gdn_didyouseethelist"] = "cap_gdn_didyouseethelist";
    level.scr_sound[var_0]["cap_gdn_huh"] = "cap_gdn_huh";
    level.scr_sound[var_0]["cap_gdn_open"] = "cap_gdn_open";
    level.scr_sound[var_0]["cap_gdn_damnit"] = "cap_gdn_damnit";
    level.scr_sound[var_0]["cap_gdn_heydoorsbusted"] = "cap_gdn_heydoorsbusted";
    level.scr_sound[var_0]["cap_gdn_welcometoironsvision"] = "cap_gdn_welcometoironsvision";
    level.scr_sound[var_0]["cap_gdn_hesinsane"] = "cap_gdn_hesinsane";
    level.scr_sound[var_0]["cap_gdn_wecantletthishappen"] = "cap_gdn_wecantletthishappen";
    level.scr_sound[var_0]["cap_gdn_illbedamnedifwe"] = "cap_gdn_illbedamnedifwe";
    level.scr_sound[var_0]["cap_gdn_ithinktheseguyswere"] = "cap_gdn_ithinktheseguyswere";
    level.scr_sound[var_0]["cap_gdn_letskeepmoving"] = "cap_gdn_letskeepmoving";
    level.scr_sound[var_0]["cap_gdn_outofthewaymove"] = "cap_gdn_outofthewaymove";
    level.scr_sound[var_0]["cap_gdn_wevegottakeepmoving"] = "cap_gdn_wevegottakeepmoving";
    level.scr_sound[var_6]["cap_lt1_runrun"] = "cap_lt1_runrun";
    level.scr_sound[var_7]["cap_lt2_helpustheyrebehind"] = "cap_lt2_helpustheyrebehind";
    level.scr_sound[var_0]["cap_gdn_ontheground"] = "cap_gdn_ontheground";
    level.scr_sound[var_0]["cap_gdn_downnow"] = "cap_gdn_downnow";
    level.scr_sound[var_0]["cap_gdn_heyyou"] = "cap_gdn_heyyou";
    level.scr_sound[var_4]["cap_sc1_ahhheytakeiteasy"] = "cap_sc1_ahhheytakeiteasy";
    level.scr_sound[var_4]["cap_sc2_ahhohmygod"] = "cap_sc2_ahhohmygod";
    level.scr_sound[var_4]["cap_sc3_ahhscaredreaction"] = "cap_sc3_ahhscaredreaction";
    level.scr_sound[var_4]["cap_sc4_ahhscaredreaction"] = "cap_sc4_ahhscaredreaction";
    level.scr_sound[var_4]["cap_sc5_ahhscaredreaction"] = "cap_sc5_ahhscaredreaction";
    level.scr_sound[var_0]["cap_gdn_throughhere"] = "cap_gdn_throughhere";
    level.scr_sound[var_0]["cap_gdn_wevegottakeepmoving"] = "cap_gdn_wevegottakeepmoving";
    level.scr_sound[var_5]["cap_dcr_stayback"] = "cap_dcr_stayback";
    level.scr_sound[var_5]["cap_dcr_imwarningyou"] = "cap_dcr_imwarningyou";
    level.scr_sound[var_5]["cap_dcr_getbackorillshoot"] = "cap_dcr_getbackorillshoot";
    level.scr_sound[var_0]["cap_gdn_comeongetthedoor"] = "cap_gdn_comeongetthedoor";
    level.scr_sound[var_0]["cap_gdn_cmonhelp"] = "cap_gdn_cmonhelp";
    level.scr_sound[var_5]["cap_dcr_ugh"] = "cap_dcr_ugh";
    level.scr_sound[var_0]["cap_gdn_whereismanticore"] = "cap_gdn_whereismanticore";
    level.scr_sound[var_5]["cap_dcr_theatlascommand"] = "cap_dcr_theatlascommand";
    level.scr_sound[var_5]["cap_dcr_oof"] = "cap_dcr_oof";
    level.scr_sound[var_5]["cap_dcr_itgoesoutside"] = "cap_dcr_itgoesoutside";
    level.scr_sound[var_0]["cap_gdn_throughhere2"] = "cap_gdn_throughhere2";
    level.scr_sound[var_0]["cap_gdn_thehatchletsgo"] = "cap_gdn_thehatchletsgo";
    level.scr_sound[var_0]["cap_gdn_inthehatch"] = "cap_gdn_inthehatch";
    level.scr_sound[var_0]["cap_gdn_what"] = "cap_gdn_what";
    level.scr_sound[var_0]["cap_gdn_shit"] = "cap_gdn_shit";
    level.scr_sound[var_0]["cap_gdn_notgood"] = "cap_gdn_notgood";
    level.scr_sound[var_0]["cap_gdn_weneedawayout"] = "cap_gdn_weneedawayout";
    level.scr_sound[var_0]["cap_gdn_look"] = "cap_gdn_look";
    level.scr_sound[var_0]["cap_gdn_aventunderthis"] = "cap_gdn_aventunderthis";
    level.scr_sound[var_0]["cap_gdn_mitchell"] = "cap_gdn_mitchell";
    level.scr_sound[var_0]["cap_gdn_mitchellcmonlets"] = "cap_gdn_mitchellcmonlets";
    level.scr_sound[var_0]["cap_gdn_cmonpush"] = "cap_gdn_cmonpush";
    level.scr_sound[var_0]["cap_gdn_wegottamovethiscart"] = "cap_gdn_wegottamovethiscart";
    level.scr_sound[var_0]["cap_gdn_push"] = "cap_gdn_push";
    level.scr_sound[var_0]["cap_gdn_keeppushing"] = "cap_gdn_keeppushing";
    level.scr_sound[var_0]["cap_gdn_dontstop"] = "cap_gdn_dontstop";
    level.scr_sound[var_0]["cap_gdn_ughcomeoncome"] = "cap_gdn_ughcomeoncome";
    level.scr_sound[var_0]["cap_gdn_goodtogo"] = "cap_gdn_what";
    level.scr_sound[var_0]["cap_gdn_letsgo2"] = "cap_gdn_letsgo2";
    level.scr_sound[var_0]["cap_gdn_moveit"] = "cap_gdn_moveit";
    level.scr_sound[var_0]["cap_gdn_comeonmitchellcmon"] = "cap_gdn_comeonmitchellcmon";
    level.scr_sound[var_0]["cap_gdn_move"] = "cap_gdn_move";
    level.scr_sound[var_0]["cap_gdn_cmonmate"] = "cap_gdn_cmonmate";
    level.scr_sound[var_0]["cap_gdn_shitmitchell"] = "cap_gdn_shitmitchell";
    level.scr_sound[var_0]["cap_gdn_gotcha"] = "cap_gdn_gotcha";
    level.scr_sound[var_0]["cap_gdn_fuckthatwasclose_alt01"] = "cap_gdn_fuckthatwasclose_alt01";
    level.scr_sound[var_0]["cap_gdn_outofthepanyeah"] = "cap_gdn_outofthepanyeah";
    level.scr_sound[var_0]["cap_gdn_sunlightwerealmost"] = "cap_gdn_sunlightwerealmost";
    level.scr_sound[var_0]["cap_gdn_letshopetherestime"] = "cap_gdn_letshopetherestime";
    level.scr_sound[var_0]["cap_iln_gideonitsilona"] = "cap_iln_gideonitsilona";
    level.scr_sound[var_0]["cap_gdn_goodworkwere"] = "cap_gdn_goodworkwere";
    level.scr_sound[var_0]["cap_iln_hurrycormackisnt"] = "cap_iln_hurrycormackisnt";
    level.scr_sound[var_0]["cap_gdn_theyllcomerunning"] = "cap_gdn_theyllcomerunning";
    level.scr_sound[var_0]["cap_gdn_othersideofthisdoor"] = "cap_gdn_othersideofthisdoor";
    level.scr_sound[var_0]["cap_gdn_thathelothatsour"] = "cap_gdn_thathelothatsour";
    level.scr_sound[var_0]["cap_gdn_ready"] = "cap_gdn_ready";
    level.scr_sound[var_0]["cap_gdn_theyllknowourtwenty"] = "cap_gdn_theyllknowourtwenty";
    level.scr_sound[var_0]["cap_gdn_thatsourridewhatthehell"] = "cap_gdn_thatsourridewhatthehell";
    level.scr_sound[var_0]["cap_gdn_mitchelltakealook"] = "cap_gdn_mitchelltakealook";
    level.scr_sound[var_0]["cap_gdn_lookatthis"] = "cap_gdn_lookatthis";
    level.scr_sound[var_0]["cap_gdn_damnmitchellover"] = "cap_gdn_damnmitchellover";
    level.scr_sound[var_0]["cap_gdn_theresgottabeenough"] = "cap_gdn_theresgottabeenough";
    level.scr_sound[var_0]["cap_gdn_wevegottafindilona"] = "cap_gdn_wevegottafindilona";
    level.scr_sound[var_0]["cap_gdn_wecanspotilonafrom"] = "cap_gdn_wecanspotilonafrom";
    level.scr_sound[var_0]["cap_gdn_mitchellwegottaget2"] = "cap_gdn_mitchellwegottaget2";
    level.scr_sound[var_0]["cap_gdn_letsgorunforit"] = "cap_gdn_letsgorunforit";
    level.scr_sound[var_0]["cap_gdn_pushtothehelicopter"] = "cap_gdn_pushtothehelicopter";
    level.scr_sound[var_0]["cap_gdn_spoolingup"] = "cap_gdn_spoolingup";
    level.scr_sound[var_0]["cap_gdn_anystationany_alt"] = "cap_gdn_anystationany_alt";
    level.scr_sound[var_0]["cap_kgp_twoonethisis"] = "cap_kgp_twoonethisis";
    level.scr_sound[var_0]["cap_gdn_listenironsis_alt"] = "cap_gdn_listenironsis_alt";
    level.scr_sound[var_0]["cap_kgp_understoodweare"] = "cap_kgp_understoodweare";
    level.scr_sound[var_0]["cap_gdn_kingpindoyoucopy"] = "cap_gdn_kingpindoyoucopy";
    level.scr_sound[var_0]["cap_gdn_braceforimpact"] = "cap_gdn_braceforimpact";
    level.scr_sound[var_0]["cap_gdn_holdon"] = "cap_gdn_holdon";
    level.scr_sound[var_0]["cap_gdn_coughing"] = "cap_gdn_coughing";
    level.scr_sound[var_0]["cap_gdn_onyourfeet"] = "cap_gdn_onyourfeet";
    level.scr_sound[var_0]["cap_gdn_watchit"] = "cap_gdn_watchit";
    level.scr_sound[var_0]["cap_gdn_stilllooksfunctional"] = "cap_gdn_stilllooksfunctional";
    level.scr_sound[var_0]["cap_gdn_smashthroughthatwall"] = "cap_gdn_smashthroughthatwall";
    level.scr_sound[var_0]["cap_gdn_overheremitchell"] = "cap_gdn_overheremitchell";
    level.scr_sound[var_0]["cap_gdn_onyoumitchell"] = "cap_gdn_onyoumitchell";
}

s2walk_guard_gate_vo_notetrack( var_0 )
{
    var_0 maps\_utility::dialogue_queue( "cap_gr5_alrightpeoplethrough" );
}

s2walk_guard_cages_vo_notetrack( var_0 )
{
    var_0 maps\_utility::dialogue_queue( "cap_gr11_ahhlookwhatwe" );
    wait 1;
    var_0 maps\_utility::dialogue_queue( "cap_gr11_keepmovingthisisnt" );
    wait 1;
    var_0 maps\_utility::dialogue_queue( "cap_gr11_wegotincomingtoc6" );
    soundscripts\_snd::snd_message( "aud_s2walk_guard_hip_radio", var_0 );
}

s3_guard_takedown_vo_notetrack( var_0 )
{
    var_0 maps\_utility::dialogue_queue( "cap_gdn_grabhispistol" );
}

s3_get_gun_vo_notetrack1( var_0 )
{

}

s3_get_gun_vo_notetrack2( var_0 )
{

}

s3_get_gun_vo_notetrack3( var_0 )
{

}

s3_controlroom_vo_notetrack1( var_0 )
{
    var_0 maps\_utility::dialogue_queue( "cap_gdn_thislookslikesurface" );
}

s3_controlroom_vo_notetrack2( var_0 )
{
    var_0 maps\_utility::dialogue_queue( "cap_gdn_illanathisway" );
}

s3_controlroom_vo_notetrack3( var_0 )
{
    var_0 maps\_utility::dialogue_queue( "cap_gdn_mitchellgetonthat" );
}

s3_controlroom_vo_notetrack4( var_0 )
{
    common_scripts\utility::flag_set( "s3_escape_entered_security_center" );
    var_0 maps\_utility::dialogue_queue( "cap_gdn_hurryupcmonmove" );
    common_scripts\utility::flag_set( "s3_escape_hurry_up_move_done" );
}

s3_controlroom_vo_notetrack5( var_0 )
{
    common_scripts\utility::flag_wait( "s3_escape_hurry_up_move_done" );
}

s3_controlroom_vo_notetrack6( var_0 )
{

}

s3_controlroom_attack_vo_notetrack( var_0 )
{
    level notify( "controlroom_guards_enter" );
}

s3_controlroom_exit_vo_notetrack1( var_0 )
{
    var_0 maps\_utility::dialogue_queue( "cap_gdn_damn" );
}

s3_controlroom_exit_vo_notetrack2( var_0 )
{
    var_0 maps\_utility::dialogue_queue( "cap_iln_whathappened" );
}

s3_controlroom_exit_vo_notetrack3( var_0 )
{
    var_0 maps\_utility::dialogue_queue( "cap_gdn_doorslocked" );
}

s3_controlroom_exit_vo_notetrack4( var_0 )
{
    var_0 maps\_utility::dialogue_queue( "cap_gdn_standback" );
}

s3_controlroom_exit_vo_notetrack5( var_0 )
{
    var_0 maps\_utility::dialogue_queue( "cap_gdn_gettopsidewell" );
}

s3_controlroom_exit_vo_notetrack6( var_0 )
{

}

s3_controlroom_exit_vo_notetrack7( var_0 )
{
    wait 2.0;
    var_0 maps\_utility::dialogue_queue( "cap_gdn_letsmove" );
}

#using_animtree("generic_human");

init_pcap_vo()
{
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s1_drive_gideon_01, "aud_cap_s1_drive_gideon_01_start", ::cap_intro_drive_gdn );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s1_drive_ilana_01, "aud_cap_s1_drive_ilana_01_start", ::cap_intro_drive_iln );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s1_elevator_gideon_01_enter, "aud_cap_s1_elevator_gideon_01_enter_start", ::cap_elevator_gdn );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s1_elevator_ilana_01_enter, "aud_cap_s1_elevator_ilana_01_enter_start", ::cap_elevator_iln );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s1_elevator_cormack_01_enter, "aud_cap_s1_elevator_cormack_01_enter_start", ::cap_elevator_crk );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s2_walk_ally_02, "aud_cap_s2_walk_ally_02_start", ::cap_trolley_gdn );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s3_interrogation_irons_01, "aud_cap_s3_interrogation_irons_01_start", ::cap_interrogation_irn );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s3_interrogation_cormack_01, "aud_cap_s3_interrogation_cormack_01_start", ::cap_interrogation_crk );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s3_interrogation_cormack_01, "aud_cap_s3_interrogation_cormack_exertion", ::cap_interrogation_crk_add );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s3_rescue_gideon_01, "aud_cap_s3_rescue_gideon_01_start", ::cap_rescue_gdn );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s3_rescue_ilana_01, "aud_cap_s3_rescue_ilana_01_start", ::cap_rescue_iln );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s3_rescue_cormack_01, "aud_cap_s3_rescue_cormack_01_start", ::cap_rescue_crk );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s3_escape_takedown_gideon_01_help, "aud_cap_s3_escape_takedown_gideon_01_help_start", ::cap_gun_training_gdn );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s3_escape_controlroom_ilana_01_exit, "cap_060_131_iln", ::cap_separation_iln_01 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s3_observation_app_gideon_02, "aud_cap_s3_observation_app_gideon_02_011", ::cap_observation_gdn_01 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s3_observation_app_gideon_02, "aud_cap_s3_observation_app_gideon_02_012", ::cap_observation_gdn_02 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s3_test_chamber_app_gideon_03, "aud_cap_s3_test_chamber_app_gideon_03_start", ::cap_bake_chamber_gdn_01 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s3_test_chamber_app_gideon_03, "aud_cap_s3_test_chamber_app_gideon_03_130", ::cap_bake_chamber_gdn_02 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s3_test_chamber_app_gideon_03, "aud_cap_s3_test_chamber_app_gideon_03_021", ::cap_test_chamber_gdn_01 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s3_test_chamber_app_gideon_03, "aud_cap_s3_test_chamber_app_gideon_03_031", ::cap_test_chamber_gdn_02 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s3_test_chamber_app_gideon_03, "aud_cap_s3_test_chamber_app_gideon_03_050", ::cap_test_chamber_gdn_03 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_incinerator_start_gideon, "aud_cap_incinerator_start_gideon_030", ::cap_incinerator_start_01 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_incinerator_start_gideon, "aud_cap_incinerator_start_gideon_040", ::cap_incinerator_start_02 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_incinerator_start_gideon, "aud_cap_incinerator_start_gideon_041", ::cap_incinerator_start_03 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_incinerator_push_gideon, "aud_cap_incinerator_push_gideon_110", ::cap_incinerator_push_01 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_incinerator_push_gideon, "aud_cap_incinerator_push_gideon_100", ::cap_incinerator_push_02 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_incinerator_push_gideon, "aud_cap_incinerator_push_gideon_131", ::cap_incinerator_push_03 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_incinerator_end_gideon, "aud_cap_incinerator_end_gideon_240", ::cap_incinerator_end_01 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_incinerator_end_gideon, "aud_cap_incinerator_end_gideon_250", ::cap_incinerator_end_02 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_incinerator_end_gideon, "aud_cap_incinerator_end_gideon_260", ::cap_incinerator_end_03 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_gdn_theresgottabeenough_anim, "aud_cap_gdn_theresgottabeenough_anim_010", ::cap_manticore_window_gdn_01 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_gdn_theresgottabeenough_anim, "aud_cap_gdn_theresgottabeenough_anim_020", ::cap_manticore_window_gdn_02 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s1_escape_mech_crash_wakeup_gideon, "aud_cap_s1_escape_mech_crash_wakeup_gideon_start", ::cap_crash_recovery_gdn );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s1_escape_mech_door_lift_exit_end_gideon, "aud_cap_ending_gideon_extra", ::cap_ending_gdn_extra );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s1_escape_mech_door_lift_exit_end_gideon, "aud_cap_ending_gideon_start", ::cap_ending_gdn );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s1_escape_mech_door_lift_exit_end_ilona, "aud_cap_ending_ilona_start", ::cap_ending_iln );
}

cap_intro_drive_gdn( var_0 )
{
    soundscripts\_snd::snd_message( "aud_intro_heli_flyover" );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_stayalertanydetail", 0.12 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_usedtobearesearch", 6.09 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_medicaladvancements", 12.24 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_thisisitonlyway", 28.24 );
}

cap_intro_drive_iln( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_iln_whatisthisplace", 4.09 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_iln_researchforwhat", 11.09 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_iln_exhales", 33.15 );
}

cap_elevator_gdn( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_howdyouenduphere", 1.06 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_pulledgrunt", 25.24 );
}

cap_elevator_iln( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_iln_istherearescueforce", 10.21 );
}

cap_elevator_crk( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_heavybreathing", 0.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_ourairsupportwas", 4.03 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_iwasoutsidetheblast", 7.03 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_downtowniscontaminated", 14.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_wevepulledoutofthe", 16.18 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_idontthinkanyones", 19.21 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_gasps", 26.15 );
}

cap_trolley_gdn( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_gruntsstruggles_alt01", 0.0 );
}

cap_interrogation_irn( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_irn_iwantedtomeetthe", 12.18 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_irn_failureisnotsomething", 26.03 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_irn_havefailedsomiserably", 33.06 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_irn_butthatsthewayithasto", 36.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_irn_thewheatfromthechaff", 38.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_irn_theancientspartans", 42.09 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_irn_butthattruthhasbeen", 47.15 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_irn_willwasthevictim", 57.09 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_irn_ofcoursethetragedy", 66.24 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_irn_yourenotyoungbut", 76.24 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_irn_soigiveyoutwenty", 81.06 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_irn_timeenoughtoconsider", 84.03 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_irn_andyou", 101.27 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_irn_theprodigalsonreturns", 106.09 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_irn_ibelievedinyou", 113.18 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_irn_igaveyouasecond", 116.18 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_irn_yourenothinglike", 138.15 );
}

cap_interrogation_crk( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_ourmissionwastostop", 16.27 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_butifthatmeantkilling", 22.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_whatofyoursonwill", 52.12 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_willdiedfightingfor", 62.15 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_painfulscreaming", 72.06 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_laboredbreathing1", 86.18 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_laboredbreathing2", 94.18 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_laboredbreathing3", 101.24 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_laboredbreathing4", 140.15 );
}

cap_interrogation_crk_add( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "scn_cap_interrogation_crk_exertion", 0.0 );
}

cap_rescue_crk( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_breathinggrunt", 0.15 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_painfullabored", 4.18 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_stopironsimdone", 8.09 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_painfulgasps1", 16.27 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_painfulgasps2", 22.27 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_crk_quietpainfulbreathing", 28.06 );
}

cap_rescue_iln( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_iln_breathinggrunt", 0.09 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_iln_canyouwalk", 6.18 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_iln_igotyouletsget", 14.03 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_iln_exertion1", 19.06 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_iln_exertion2", 23.24 );
}

cap_rescue_gdn( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_gethimoutofthere", 0.09 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_shutitweareleaving2", 10.21 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_weareleavingstayquiet", 14.21 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_heavybreathing1", 20.21 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_heavybreathing2", 27.27 );
}

cap_gun_training_gdn( var_0 )
{
    soundscripts\_snd::snd_message( "aud_limp_exo" );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_here", 1.15 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_herewithonewing", 3.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_somakeeveryshotcount", 6.03 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_ready3", 9.12 );
}

cap_separation_iln_01( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_iln_whathappened", 0.0 );
}

cap_observation_gdn_01( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_manticorestrikeshes", 0.0 );
}

cap_observation_gdn_02( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_washingtonnewyork", 0.0 );
}

cap_bake_chamber_gdn_01( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_heydoorsbusted", 0.05 );
}

cap_bake_chamber_gdn_02( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_huh", 0.0 );
}

cap_test_chamber_gdn_01( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_welcometoironsvision", 0.0 );
}

cap_test_chamber_gdn_02( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_hesinsane", 0.0 );
}

cap_test_chamber_gdn_03( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_illbedamnedifwe", 0.0 );
}

cap_incinerator_start_01( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_what", 0.0 );
}

cap_incinerator_start_02( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_shit", 0.0 );
}

cap_incinerator_start_03( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_notgood", 0.0 );
}

cap_incinerator_push_01( var_0 )
{
    if ( common_scripts\utility::flag( "vo_cart_push" ) == 0 )
    {
        var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_wegottamovethiscart", 0.0 );
        common_scripts\utility::flag_set( "vo_cart_push" );
    }
}

cap_incinerator_push_02( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_cmonpush", 0.0 );
}

cap_incinerator_push_03( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_throughhere2", 0.0 );
}

cap_incinerator_crawl_loop_01( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_cmonmate", 0.0 );
}

cap_incinerator_end_01( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_shitmitchell", 0.0 );
}

cap_incinerator_end_02( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_gotcha", 0.0 );
}

cap_incinerator_end_03( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_fuckthatwasclose_alt01", 0.0 );
}

cap_manticore_window_gdn_01( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_theresgottabeenough", 0.0 );
}

cap_manticore_window_gdn_02( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_wevegottafindilona", 0.0 );
}

cap_crash_recovery_gdn( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_onyourfeet", 0.0 );
}

cap_ending_iln( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_iln_getin", 0.03 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_iln_hesintheback", 2.06 );
}

cap_ending_gdn_extra( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_theretheyare", 0.0 );
}

cap_ending_gdn( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_cormack2", 1.15 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_gruntsbreaths", 10.12 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_gdn_letspraywerenot", 11.0 );
}

#using_animtree("player");

init_plr_vo()
{
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %cap_s3_interrogation_player, "aud_cap_s3_interrogation_player_start", ::cap_interrogation_plr );
}

cap_interrogation_plr( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_plr_yellsinpain", 123.21 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "cap_plr_yellsinpain2", 127.33 );
}
