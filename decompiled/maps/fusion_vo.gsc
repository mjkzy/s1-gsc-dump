// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setup_vo();
    init_dialogue_flags();
    thread start_dialogue_threads();
}

setup_vo()
{
    level.scr_radio["fus_prt_werepickingupsignaldistortion"] = "fus_prt_werepickingupsignaldistortion";
    level.scr_radio["fus_prt_bravoteambeadvised"] = "fus_prt_bravoteambeadvised";
    level.scr_radio["fus_prt_mtoperatorzuluisdown"] = "fus_prt_mtoperatorzuluisdown";
    level.scr_radio["fus_prt_twentyplusfootmobilesinboundfrom"] = "fus_prt_twentyplusfootmobilesinboundfrom";
    level.scr_radio["fus_prt_copythatbravowevegot"] = "fus_prt_copythatbravowevegot";
    level.scr_radio["fus_prt_bravowehaveanimminet"] = "fus_prt_bravowehaveanimminet";
    level.scr_radio["fus_prt_affirmativebravoone"] = "fus_prt_affirmativebravoone";
    level.scr_radio["fus_prt_bravopressurereadingsarecritical"] = "fus_prt_bravopressurereadingsarecritical";
    level.scr_radio["fus_prt_imseeingamassiveexplosion"] = "fus_prt_imseeingamassiveexplosion";
    level.scr_radio["fus_prt_allunitsgetrotorson"] = "fus_prt_allunitsgetrotorson";
    level.scr_radio["fus_prg_coderedcoderedwarning"] = "fus_prg_coderedcoderedwarning";
    level.scr_radio["fus_prg_pleaseproceedtothenearest"] = "fus_prg_pleaseproceedtothenearest";
    level.scr_radio["fus_prg_warningcontainmentairlockclosing"] = "fus_prg_warningcontainmentairlockclosing";
    level.scr_radio["fus_ch1_twoonewerebearingthreeone"] = "fus_ch1_twoonewerebearingthreeone";
    level.scr_radio["fus_ch1_negativeonthatrestrictedroe"] = "fus_ch1_negativeonthatrestrictedroe";
    level.scr_radio["fus_ch1_twofourwevegotasam"] = "fus_ch1_twofourwevegotasam";
    level.scr_radio["fus_ch1_contactcontactdeployingswarmcountermeasures"] = "fus_ch1_contactcontactdeployingswarmcountermeasures";
    level.scr_radio["fus_ch1_twofourisdowntwofouris"] = "fus_ch1_twofourisdowntwofouris";
    level.scr_radio["fus_ch1_twofivebreakpositionandprovide"] = "fus_ch1_twofivebreakpositionandprovide";
    level.scr_radio["fus_ch1_wevegothostilesinour"] = "fus_ch1_wevegothostilesinour";
    level.scr_radio["fus_ch1_goodeffectontarget"] = "fus_ch1_goodeffectontarget";
    level.scr_radio["fus_ch1_lzisclear"] = "fus_ch1_lzisclear";
    level.scr_radio["fus_ch1_weareinpositionbravo"] = "fus_ch1_weareinpositionbravo";
    level.scr_radio["fus_ch1_teamoneisondeck"] = "fus_ch1_teamoneisondeck";
    level.scr_radio["fus_ch1_bravothisiswraithtwothree"] = "fus_ch1_bravothisiswraithtwothree";
    level.scr_radio["fus_ch1_copybravooneinboundinthirty"] = "fus_ch1_copybravooneinboundinthirty";
    level.scr_radio["fus_ch1_bravowecantgetnear"] = "fus_ch1_bravowecantgetnear";
    level.scr_radio["fus_ch1_bravodoyoucopy"] = "fus_ch1_bravodoyoucopy";
    level.scr_radio["fus_ch1_bravotakecover"] = "fus_ch1_bravotakecover";
    level.scr_radio["fus_ch1_wraithtwofiveisdown"] = "fus_ch1_wraithtwofiveisdown";
    level.scr_radio["fus_ch1_ineedcasevacunitsby"] = "fus_ch1_ineedcasevacunitsby";
    level.scr_radio["fus_ch2_copytwothreewehavea"] = "fus_ch2_copytwothreewehavea";
    level.scr_radio["fus_ch3_twothreeunderstandwearestill"] = "fus_ch3_twothreeunderstandwearestill";
    level.scr_radio["fus_ch3_disengagingstealth"] = "fus_ch3_disengagingstealth";
    level.scr_radio["fus_ch3_wraithtwothreewerehitwere"] = "fus_ch3_wraithtwothreewerehitwere";
    level.scr_radio["fus_ch4_copythattwothree"] = "fus_ch4_copythattwothree";
    level.scr_radio["fus_ch4_teamtwoisdeployingover"] = "fus_ch4_teamtwoisdeployingover";
    level.scr_radio["fus_ch4_cominginhot"] = "fus_ch4_cominginhot";
    level.scr_sound["alpha_leader"]["fus_alr_welcometothepartybravo"] = "fus_alr_welcometothepartybravo";
    level.scr_radio["fus_alr_ivegottencasualtiesand"] = "fus_alr_ivegottencasualtiesand";
    level.scr_radio["fus_alr_wheresourgoddamnairsupport"] = "fus_alr_wheresourgoddamnairsupport";
    level.scr_radio["fus_alr_wevelostcontactwithbravo"] = "fus_alr_wevelostcontactwithbravo";
    level.scr_sound["burke"]["fus_gdn_prophetimgettingalot"] = "fus_gdn_prophetimgettingalot";
    level.scr_sound["burke"]["fus_gdn_rogerthateveryoneseeingthis"] = "fus_gdn_rogerthateveryoneseeingthis";
    level.scr_sound["burke"]["fus_gdn_alphateamsgotthekva"] = "fus_gdn_alphateamsgotthekva";
    level.scr_sound["burke"]["fus_gdn_thisshitendsinthe"] = "fus_gdn_thisshitendsinthe";
    level.scr_sound["burke"]["fus_gdn_getinposition"] = "fus_gdn_getinposition";
    level.scr_sound["burke"]["fus_gdn_gonnabeagoodone"] = "fus_gdn_gonnabeagoodone";
    level.scr_sound["burke"]["fus_gdn_holdon"] = "fus_gdn_holdon";
    level.scr_sound["burke"]["fus_gdn_eyesforwardnothingwecan"] = "fus_gdn_eyesforwardnothingwecan";
    level.scr_sound["burke"]["fus_gdn_letsdothis"] = "fus_gdn_letsdothis";
    level.scr_sound["burke"]["fus_gdn_roger2"] = "fus_gdn_roger2";
    level.scr_sound["burke"]["fus_gdn_mitchellhitthosetangoson"] = "fus_gdn_mitchellhitthosetangoson";
    level.scr_sound["burke"]["fus_gdn_niceshot"] = "fus_gdn_niceshot";
    level.scr_sound["burke"]["fus_gdn_tangodown"] = "fus_gdn_tangodown";
    level.scr_sound["burke"]["fus_gdn_nexttimetrytokeep"] = "fus_gdn_nexttimetrytokeep";
    level.scr_sound["burke"]["fus_gdn_zerooneout"] = "fus_gdn_zerooneout";
    level.scr_sound["burke"]["fus_gdn_mitchelldeployyourzipline"] = "fus_gdn_mitchelldeployyourzipline";
    level.scr_sound["burke"]["fus_gdn_fireyourziplinemitchell"] = "fus_gdn_fireyourziplinemitchell";
    level.scr_sound["burke"]["fus_gdn_getthehelldownhere"] = "fus_gdn_getthehelldownhere";
    level.scr_sound["burke"]["fus_gdn_rallyup"] = "fus_gdn_rallyup";
    level.scr_sound["burke"]["fus_gdn_mitchellonme"] = "fus_gdn_mitchellonme";
    level.scr_sound["burke"]["fus_gdn_mitchelloverhere"] = "fus_gdn_mitchelloverhere";
    level.scr_sound["burke"]["fus_gdn_lookslikealphaisknee"] = "fus_gdn_lookslikealphaisknee";
    level.scr_sound["burke"]["fus_gdn_moveout"] = "fus_gdn_moveout";
    level.scr_sound["burke"]["fus_gdn_copythatprophet"] = "fus_gdn_copythatprophet";
    level.scr_sound["burke"]["fus_gdn_weaponsfree"] = "fus_gdn_weaponsfree";
    level.scr_sound["burke"]["fus_gdn_alphawearebootson"] = "fus_gdn_alphawearebootson";
    level.scr_sound["burke"]["fus_gdn_mitchellparkitbehindthose"] = "fus_gdn_mitchellparkitbehindthose";
    level.scr_sound["burke"]["fus_gdn_keeppushingforward"] = "fus_gdn_keeppushingforward";
    level.scr_sound["burke"]["fus_gdn_mitchellswitchovertoyour"] = "fus_gdn_mitchellswitchovertoyour";
    level.scr_sound["burke"]["fus_gdn_switchtoyourde"] = "fus_gdn_switchtoyourde";
    level.scr_sound["burke"]["fus_gdn_prophetthekvajustrolled"] = "fus_gdn_prophetthekvajustrolled";
    level.scr_sound["burke"]["fus_gdn_thensomeonegettheirass"] = "fus_gdn_thensomeonegettheirass";
    level.scr_sound["burke"]["fus_gdn_youvegot100mmroundson"] = "fus_gdn_youvegot100mmroundson";
    level.scr_sound["burke"]["fus_gdn_yourmtisdown"] = "fus_gdn_yourmtisdown";
    level.scr_sound["burke"]["fus_gdn_takeoutthetitanwith"] = "fus_gdn_takeoutthetitanwith";
    level.scr_sound["burke"]["fus_gdn_hitthetitanwiththe"] = "fus_gdn_hitthetitanwiththe";
    level.scr_sound["burke"]["fus_gdn_mitchellgrabthatlauncherand"] = "fus_gdn_mitchellgrabthatlauncherand";
    level.scr_sound["burke"]["fus_gdn_titansdowngoodjobmitchell"] = "fus_gdn_titansdowngoodjobmitchell";
    level.scr_sound["burke"]["fus_gdn_wegottalegitto"] = "fus_gdn_wegottalegitto";
    level.scr_sound["burke"]["fus_gdn_copythat3"] = "fus_gdn_copythat3";
    level.scr_sound["burke"]["fus_gdn_soarewekeepmoving"] = "fus_gdn_soarewekeepmoving";
    level.scr_sound["burke"]["fus_gdn_moveit"] = "fus_gdn_moveit";
    level.scr_sound["burke"]["fus_gdn_contactloadingbay"] = "fus_gdn_contactloadingbay";
    level.scr_sound["burke"]["fus_gdn_mitchelltossathreatgrenade"] = "fus_gdn_mitchelltossathreatgrenade";
    level.scr_sound["burke"]["fus_gdn_theyrerabbiting"] = "fus_gdn_theyrerabbiting";
    level.scr_sound["burke"]["fus_gdn_prophetwevegotkvaextraction"] = "fus_gdn_prophetwevegotkvaextraction";
    level.scr_sound["burke"]["fus_gdn_useyouremps"] = "fus_gdn_useyouremps";
    level.scr_sound["burke"]["fus_gdn_letsgoletsgo"] = "fus_gdn_letsgoletsgo";
    level.scr_sound["burke"]["fus_gdn_wraithtwothreeweneedimmediate"] = "fus_gdn_wraithtwothreeweneedimmediate";
    level.scr_sound["burke"]["fus_gdn_pressureexplosions"] = "fus_gdn_pressureexplosions";
    level.scr_sound["burke"]["fus_gdn_headsupmoredronesincoming"] = "fus_gdn_headsupmoredronesincoming";
    level.scr_sound["burke"]["fus_gdn_youreadamnwelcomesight"] = "fus_gdn_youreadamnwelcomesight";
    level.scr_sound["burke"]["fus_gdn_copythattwothree"] = "fus_gdn_copythattwothree";
    level.scr_sound["burke"]["fus_gdn_keepmovingkeepmoving"] = "fus_gdn_keepmovingkeepmoving";
    level.scr_sound["burke"]["fus_gdn_mitchellmitchell"] = "fus_gdn_mitchellmitchell";
    level.scr_sound["burke"]["fus_gdn_wraithtwothreebravotwoisdown"] = "fus_gdn_wraithtwothreebravotwoisdown";
    level.scr_sound["burke"]["fus_gdn_holdonman"] = "fus_gdn_holdonman";
    level.scr_sound["burke"]["fus_gdn_youregoingtobealright"] = "fus_gdn_youregoingtobealright";
    level.scr_sound["burke"]["fus_gdn_weregettingyouhome"] = "fus_gdn_weregettingyouhome";
    level.scr_sound["burke"]["fus_gdn_mitchelluseyourassaultdrone"] = "fus_gdn_mitchelluseyourassaultdrone";
    level.scr_sound["burke"]["fus_gdn_keepmovingwerealmostthere"] = "fus_gdn_keepmovingwerealmostthere";
    level.scr_sound["burke"]["fus_gdn_areaclearletsmove"] = "fus_gdn_areaclearletsmove";
    level.scr_sound["burke"]["fus_gdn_wevegottogetto"] = "fus_gdn_wevegottogetto";
    level.scr_sound["carter"]["fus_ctr_zerothreeout"] = "fus_ctr_zerothreeout";
    level.scr_sound["carter"]["fus_ctr_ourdroneoperatorjusttook"] = "fus_ctr_ourdroneoperatorjusttook";
    level.scr_sound["carter"]["fus_ctr_jokerwhatsyourgeigerreading"] = "fus_ctr_jokerwhatsyourgeigerreading";
    level.scr_sound["carter"]["fus_ctr_whatthehellwasthat"] = "fus_ctr_whatthehellwasthat";
    level.scr_sound["carter"]["fus_ctr_gogo"] = "fus_ctr_gogo";
    level.scr_sound["joker"]["fus_jkr_gotit"] = "fus_jkr_gotit";
    level.scr_sound["joker"]["fus_jkr_shit"] = "fus_jkr_shit";
    level.scr_sound["joker"]["fus_jkr_theymakeit"] = "fus_jkr_theymakeit";
    level.scr_sound["joker"]["fus_jkr_yessir"] = "fus_jkr_yessir";
    level.scr_sound["joker"]["fus_jkr_grabsomecoverbehindthose"] = "fus_jkr_grabsomecoverbehindthose";
    level.scr_sound["joker"]["fus_jkr_youvegot25mmroundson"] = "fus_jkr_youvegot25mmroundson";
    level.scr_sound["joker"]["fus_jkr_tangosduginbehindthose"] = "fus_jkr_tangosduginbehindthose";
    level.scr_sound["joker"]["fus_jkr_bastardsgotatrophysystem"] = "fus_jkr_bastardsgotatrophysystem";
    level.scr_sound["joker"]["fus_jkr_gideonthatmtisstill"] = "fus_jkr_gideonthatmtisstill";
    level.scr_sound["joker"]["fus_jkr_gogogo"] = "fus_jkr_gogogo";
    level.scr_sound["joker"]["fus_jkr_gideontangosarebailinout"] = "fus_jkr_gideontangosarebailinout";
    level.scr_sound["joker"]["fus_jkr_gotalotofsmoke"] = "fus_jkr_gotalotofsmoke";
    level.scr_sound["joker"]["fus_jkr_doorsclosin"] = "fus_jkr_doorsclosin";
    level.scr_sound["joker"]["fus_jkr_weregoodjustkeepshooting"] = "fus_jkr_weregoodjustkeepshooting";
    level.scr_sound["joker"]["fus_jkr_theyreusingdronestocover"] = "fus_jkr_theyreusingdronestocover";
    level.scr_sound["joker"]["fus_jkr_dronesaredown"] = "fus_jkr_dronesaredown";
    level.scr_sound["joker"]["fus_jkr_youheardtheman"] = "fus_jkr_youheardtheman";
    level.scr_sound["joker"]["fus_jkr_goddamn2"] = "fus_jkr_goddamn2";
    level.scr_sound["joker"]["fus_jkr_theresourexfil"] = "fus_jkr_theresourexfil";
    level.scr_sound["joker"]["fus_jkr_comeon"] = "fus_jkr_comeon";
    level.scr_sound["joker"]["fus_jkr_ohshit"] = "fus_jkr_ohshit";
    level.scr_radio["fus_jkr_wherescarterwherescarter"] = "fus_jkr_wherescarterwherescarter";
    level.scr_radio["fus_jkr_itscomingdown"] = "fus_jkr_itscomingdown";
    level.scr_radio["fus_jkr_hesdeadcartersdead"] = "fus_jkr_hesdeadcartersdead";
    level.scr_sound["burke"]["fus_gdn_activateboostjump"] = "fus_gdn_activateboostjump";
    level.scr_sound["burke"]["fus_gdn_wehaveeyesonan2"] = "fus_gdn_wehaveeyesonan2";
    level.scr_sound["burke"]["fus_gdn_thereisanammocrate2"] = "fus_gdn_thereisanammocrate2";
    level.scr_sound["burke"]["fus_gdn_getmoreammoforthat2"] = "fus_gdn_getmoreammoforthat2";
    level.scr_sound["burke"]["fus_gdn_useyouroverdrive"] = "fus_gdn_useyouroverdrive";
    level.scr_sound["burke"]["fus_gdn_tossasmartgrenade"] = "fus_gdn_tossasmartgrenade";
    level.scr_sound["burke"]["fin_gdn_usesonics"] = "fin_gdn_usesonics";
    level.scr_sound["joker"]["fus_jkr_dronesaboveus"] = "fus_jkr_dronesaboveus";
    level.scr_sound["burke"]["fus_gdn_letsmove"] = "fus_gdn_letsmove";
    level.scr_sound["burke"]["fus_gdn_carteryoualright"] = "fus_gdn_carteryoualright";
    level.scr_sound["pa"]["fus_pa_warningreactorcritical"] = "fus_pa_warningreactorcritical";
    level.scr_sound["burke"]["fus_gdn_thereheis"] = "fus_gdn_thereheis";
    level.scr_sound["burke"]["fus_gdn_prophetatlasteamisevacuating"] = "fus_gdn_prophetatlasteamisevacuating";
    level.scr_sound["burke"]["fus_gdn_mitchellgetonboard"] = "fus_gdn_mitchellgetonboard";
    level.scr_sound["burke"]["fus_gdn_mitchelltheareaiscompromised"] = "fus_gdn_mitchelltheareaiscompromised";
    level.scr_sound["burke"]["fus_gdn_mitchellcomeon"] = "fus_gdn_mitchellcomeon";
    interior_prepare_dialogue();
}

interior_prepare_dialogue()
{
    var_0 = "burke";
    var_1 = "joker";
    var_2 = "carter";
    level.scr_sound[var_1]["fus_jkr_whistles"] = "fus_jkr_whistles";
    level.scr_sound[var_0]["fus_gdn_staysharp"] = "fus_gdn_staysharp";
    level.scr_radio["fus_prt_fastestaccesstothelower"] = "fus_prt_fastestaccesstothelower";
    level.scr_sound[var_0]["fus_gdn_roger3"] = "fus_gdn_roger3";
    level.scr_sound[var_1]["fus_jkr_grunt"] = "fus_jkr_grunt";
    level.scr_sound[var_0]["fus_gdn_oneatatimelets"] = "fus_gdn_oneatatimelets";
    level.scr_sound[var_1]["fus_jkr_afteryou"] = "fus_jkr_afteryou";
    level.scr_sound[var_1]["fus_jkr_youreupmitchell"] = "fus_jkr_youreupmitchell";
    level.scr_sound[var_1]["fus_jkr_letsgomitchell"] = "fus_jkr_letsgomitchell";
    level.scr_sound[var_0]["fus_gdn_clear"] = "fus_gdn_clear";
    level.scr_sound[var_0]["fus_gdn_thisway"] = "fus_gdn_thisway";
    level.scr_radio["fus_prt_bravoreactorcoretemperatureis"] = "fus_prt_bravoreactorcoretemperatureis";
    level.scr_sound[var_1]["fus_jkr_thatsbadnewsright"] = "fus_jkr_thatsbadnewsright";
    level.scr_radio["fus_prt_indicatorsarebelownormalrate"] = "fus_prt_indicatorsarebelownormalrate";
    level.scr_sound[var_0]["fus_gdn_thenwecanstillmake"] = "fus_gdn_thenwecanstillmake";
    level.scr_sound[var_1]["fus_jkr_poorbastardsdidntstanda"] = "fus_jkr_poorbastardsdidntstanda";
    level.scr_sound[var_1]["fus_jkr_goddamnmassacreinhere"] = "fus_jkr_goddamnmassacreinhere";
    level.scr_sound[var_0]["fus_gdn_keepmoving"] = "fus_gdn_keepmoving";
    level.scr_sound[var_0]["fus_gdn_junction"] = "fus_gdn_junction";
    level.scr_radio["fus_prt_headright"] = "fus_prt_headright";
    level.scr_sound[var_0]["fus_gdn_staytogether"] = "fus_gdn_staytogether";
    level.scr_sound[var_0]["fus_gdn_cartergetthisdooropen"] = "fus_gdn_cartergetthisdooropen";
    level.scr_sound[var_2]["fus_ctr_copy"] = "fus_ctr_copy";
    level.scr_sound[var_0]["fus_ctr_exertion"] = "fus_ctr_exertion";
    level.scr_sound[var_0]["fus_gdn_contact"] = "fus_gdn_contact";
    level.scr_sound[var_0]["fus_gdn_gogogo"] = "fus_gdn_gogogo";
    level.scr_radio["fus_prt_bravogetthroughthereactor"] = "fus_prt_bravogetthroughthereactor";
    level.scr_sound[var_0]["fus_gdn_tangosonthebalcony"] = "fus_gdn_tangosonthebalcony";
    level.scr_radio["fus_prt_youre300metersfromthe"] = "fus_prt_youre300metersfromthe";
    level.scr_sound[var_0]["fus_gdn_copythat2"] = "fus_gdn_copythat2";
    level.scr_radio["fus_prt_understood"] = "fus_prt_understood";
    level.scr_sound[var_2]["fus_ctr_thesedoorsarentsupposedto"] = "fus_ctr_thesedoorsarentsupposedto";
    level.scr_sound[var_1]["fus_jkr_thisaintanormalbusiness"] = "fus_jkr_thisaintanormalbusiness";
    level.scr_sound[var_0]["fus_gdn_prophetwereatthecargo"] = "fus_gdn_prophetwereatthecargo";
    level.scr_radio["fus_prt_uponefloortothe"] = "fus_prt_uponefloortothe";
    level.scr_sound[var_0]["fus_gdn_mitchellhittheswitch"] = "fus_gdn_mitchellhittheswitch";
    level.scr_sound[var_0]["fus_gdn_hitthebuttonmitchell"] = "fus_gdn_hitthebuttonmitchell";
    level.scr_sound[var_1]["fus_jkr_isthisthescenicroute"] = "fus_jkr_isthisthescenicroute";
    level.scr_radio["fus_prt_onlyavailablepath"] = "fus_prt_onlyavailablepath";
    level.scr_sound[var_1]["fus_jkr_thisisadamnkillbox"] = "fus_jkr_thisisadamnkillbox";
    level.scr_sound[var_0]["fus_gdn_deploycoveratthedoor"] = "fus_gdn_deploycoveratthedoor";
    level.scr_sound[var_1]["fus_jkr_copythat"] = "fus_jkr_copythat";
    level.scr_sound[var_0]["fus_gdn_exitsontheupperwalkway"] = "fus_gdn_exitsontheupperwalkway";
    level.scr_sound[var_1]["fus_jkr_what"] = "fus_jkr_what";
    level.scr_sound[var_0]["fus_gdn_upperwalkwaymove"] = "fus_gdn_upperwalkwaymove";
    level.scr_sound[var_1]["fus_jkr_icanthearagoddamn"] = "fus_jkr_icanthearagoddamn";
    level.scr_sound[var_0]["fus_gdn_keepmoving2"] = "fus_gdn_keepmoving2";
    level.scr_radio["fus_prt_bravooutputjustspiked"] = "fus_prt_bravooutputjustspiked";
    level.scr_sound[var_0]["fus_gdn_werealmostthere"] = "fus_gdn_werealmostthere";
    level.scr_radio["fus_prt_controlroomdeadahead"] = "fus_prt_controlroomdeadahead";
    level.scr_sound[var_0]["fus_gdn_thereitis"] = "fus_gdn_thereitis";
    level.scr_sound[var_2]["fus_ctr_painexertion"] = "fus_ctr_painexertion";
    level.scr_sound[var_1]["fus_jkr_thehelljusthappened"] = "fus_jkr_thehelljusthappened";
    level.scr_sound[var_0]["fus_gdn_theyriggedthedoor"] = "fus_gdn_theyriggedthedoor";
    level.scr_sound[var_2]["fus_ctr_imgood"] = "fus_ctr_imgood";
    level.scr_sound[var_2]["fus_gdn_thisconsoleisstilllive"] = "fus_gdn_thisconsoleisstilllive";
    level.scr_radio["fus_prt_patchinandrundiagnostics"] = "fus_prt_patchinandrundiagnostics";
    level.scr_sound[var_0]["fus_gdn_mitchellgetonthatconsole"] = "fus_gdn_mitchellgetonthatconsole";
    level.scr_sound[var_0]["fus_gdn_mitchellgetontheconsole"] = "fus_gdn_mitchellgetontheconsole";
    level.scr_sound[var_0]["fus_gdn_checkthecoolantlevelsmitchell"] = "fus_gdn_checkthecoolantlevelsmitchell";
    level.scr_sound[var_0]["fus_gdn_prophetyougotthis"] = "fus_gdn_prophetyougotthis";
    level.scr_radio["fus_prt_copy2"] = "fus_prt_copy2";
    level.scr_sound[var_0]["fus_gdn_okcoretempismaintaining"] = "fus_gdn_okcoretempismaintaining";
    level.scr_radio["fus_prt_thesteamreleaselineshave"] = "fus_prt_thesteamreleaselineshave";
    level.scr_sound[var_1]["fus_jkr_boss"] = "fus_jkr_boss";
    level.scr_sound[var_0]["fus_gdn_damnitwasstablea"] = "fus_gdn_damnitwasstablea";
    level.scr_radio["fus_prt_burkecoretemperatureiscritical"] = "fus_prt_burkecoretemperatureiscritical";
    level.scr_sound[var_0]["fus_gdn_icandothis"] = "fus_gdn_icandothis";
    level.scr_sound[var_1]["fus_jkr_burke"] = "fus_jkr_burke";
    level.scr_sound[var_0]["fus_gdn_shit"] = "fus_gdn_shit";
    level.scr_radio["fus_prt_wehavealevel7"] = "fus_prt_wehavealevel7";
    level.scr_sound[var_0]["fus_gdn_copythat3"] = "fus_gdn_copythat3";
    thread play_interior_dialogue();
}

init_dialogue_flags()
{
    common_scripts\utility::flag_init( "flag_rooftop_combat_dialogue" );
    common_scripts\utility::flag_init( "flag_boots_on_ground_dialogue" );
    common_scripts\utility::flag_init( "flag_burke_rally_street_dialogue" );
    common_scripts\utility::flag_init( "flag_burke_rally_street_dialogue_complete" );
    common_scripts\utility::flag_init( "flag_launcher_ammo_gathered" );
    common_scripts\utility::flag_init( "flag_boost_jump_reminder_dialogue_done" );
    common_scripts\utility::flag_init( "flag_mcd_vo_done" );
    common_scripts\utility::flag_init( "squad_out_dialogue_complete" );
    common_scripts\utility::flag_init( "flag_bailout_vo" );
    common_scripts\utility::flag_init( "flag_walker_reveal_dialogue_complete" );
    common_scripts\utility::flag_init( "dialogue_playing" );
}

start_dialogue_threads()
{
    switch ( level.start_point )
    {
        case "default":
        case "fly_in_animated":
            fly_in_dialogue();
        case "fly_in_animated_part2":
            fly_in_dialogue_part2();
            fly_in_rooftop_combat_dialogue();
            zip_rooftop_dialogue();
        case "courtyard":
            thread burke_rally_street_dialogue();
            thread use_mobile_cover_dialogue();
            thread use_boost_jump_dialogue();
            thread m_turret_1_dead_dialogue();
            thread street_battle_dialogue();
            thread use_m_turret_dialogue();
            thread drone_guy_down_dialogue();
            thread player_enters_mobile_turret_dialogue();
            thread bail_out_of_turret_dialogue();
            thread enemy_walker_reveal_dialogue();
        case "cooling_tower":
        case "control_room":
            break;
        default:
    }
}

fly_in_dialogue()
{
    wait 3.5;
    wait 1;
}

fly_in_dialogue_part2()
{

}

fly_in_rooftop_combat_dialogue()
{
    common_scripts\utility::flag_wait( "flag_rooftop_combat_dialogue" );
    radio_dialogue_queue_global( "fus_ch1_wevegothostilesinour" );
    level.burke dialogue_queue_global( "fus_gdn_roger2" );
    level.burke dialogue_queue_global( "fus_gdn_mitchellhitthosetangoson" );
    common_scripts\utility::flag_wait( "flag_combat_zip_rooftop_complete" );

    if ( !common_scripts\utility::flag( "player_participated_in_rooftop_fight" ) )
        level.burke dialogue_queue_global( "fus_gdn_nexttimetrytokeep" );
    else
        radio_dialogue_queue_global( "fus_ch1_goodeffectontarget" );
}

zip_rooftop_dialogue()
{
    common_scripts\utility::flag_wait( "flag_combat_zip_rooftop_complete" );
    thread zip_team_two_deployed_dialogue();
    radio_dialogue_queue_global( "fus_ch1_lzisclear" );
    radio_dialogue_queue_global( "fus_ch1_weareinpositionbravo" );

    if ( !common_scripts\utility::flag( "flag_player_zip_started" ) )
        level.burke dialogue_queue_global( "fus_gdn_letsdothis" );

    common_scripts\utility::flag_set( "squad_out_dialogue_complete" );
    thread burke_greets_alpha_dialogue();
    wait 5;

    if ( !common_scripts\utility::flag( "flag_player_zip_started" ) )
        level.burke dialogue_queue_global( "fus_gdn_mitchelldeployyourzipline" );
}

zip_team_two_deployed_dialogue()
{
    common_scripts\utility::flag_wait( "flag_squad_heli_2_unload" );
    radio_dialogue_queue_global( "fus_ch4_teamtwoisdeployingover" );
}

burke_greets_alpha_dialogue()
{
    common_scripts\utility::flag_wait( "flag_boots_on_ground_dialogue" );
    level.burke dialogue_queue_global( "fus_gdn_alphawearebootson" );
    soundscripts\_snd::snd_music_message( "mus_fusion_welcome_to_the_party" );

    if ( level.nextgen )
        level.alpha_leader dialogue_queue_global( "fus_alr_welcometothepartybravo" );
}

burke_rally_street_dialogue()
{
    common_scripts\utility::flag_wait( "flag_burke_rally_street_dialogue" );
    level.burke dialogue_queue_global( "fus_gdn_rallyup" );
    level.burke dialogue_queue_global( "fus_gdn_lookslikealphaisknee" );
    level.joker dialogue_queue_global( "fus_jkr_yessir" );
    level.burke dialogue_queue_global( "fus_gdn_moveout" );
    level.burke dialogue_queue_global( "fus_gdn_weaponsfree" );
    common_scripts\utility::flag_set( "flag_burke_rally_street_dialogue_complete" );
}

use_mobile_cover_dialogue()
{
    level.player endon( "player_linked_to_cover" );
    common_scripts\utility::flag_wait_all( "flag_street_wall_1_explode", "flag_burke_rally_street_dialogue_complete", "flag_boost_jump_reminder_dialogue_done" );

    if ( !common_scripts\utility::flag( "flag_mt_move_up_03" ) )
        level.burke dialogue_queue_global( "fus_gdn_mitchellparkitbehindthose" );

    common_scripts\utility::flag_set( "flag_mcd_vo_done" );
    wait 4;

    if ( !common_scripts\utility::flag( "flag_mt_move_up_03" ) )
        level.joker dialogue_queue_global( "fus_jkr_grabsomecoverbehindthose" );
}

use_boost_jump_dialogue()
{
    common_scripts\utility::flag_wait_all( "flag_obj_markers", "flag_burke_rally_street_dialogue_complete" );
    wait 4;
    level.burke dialogue_queue_global( "fus_gdn_activateboostjump" );
    common_scripts\utility::flag_set( "flag_boost_jump_reminder_dialogue_done" );
}

drone_guy_down_dialogue()
{
    common_scripts\utility::flag_wait( "flag_player_enters_mobile_turret" );

    if ( !common_scripts\utility::flag( "flag_enemy_walker" ) )
    {
        common_scripts\utility::flag_wait_or_timeout( "flag_spawn_gaz_01", 10 );
        level.carter dialogue_queue_global( "fus_ctr_ourdroneoperatorjusttook" );
    }
}

m_turret_1_dead_dialogue()
{
    common_scripts\utility::flag_wait( "flag_m_turret_dead" );
    wait 2;
    radio_dialogue_queue_global( "fus_prt_mtoperatorzuluisdown" );
}

street_battle_dialogue()
{
    common_scripts\utility::flag_wait( "flag_enemy_reinforcements_big_wave" );
    radio_dialogue_queue_global( "fus_prt_twentyplusfootmobilesinboundfrom" );
    common_scripts\utility::flag_wait_or_timeout( "flag_slow_explosions_1", 20 );
    level.burke dialogue_queue_global( "fus_gdn_keeppushingforward" );
}

use_m_turret_dialogue()
{
    common_scripts\utility::flag_wait( "flag_mt_move_up_03" );
    level endon( "flag_player_starts_entering_mobile_turret" );
    level.joker maps\_utility::dialogue_queue( "fus_jkr_gideonthatmtisstill" );
    level.burke maps\_utility::dialogue_queue( "fus_gdn_thensomeonegettheirass" );
}

player_enters_mobile_turret_dialogue()
{
    common_scripts\utility::flag_wait( "flag_player_enters_mobile_turret" );
}

bail_out_of_turret_dialogue()
{
    level endon( "street_cleanup" );
    common_scripts\utility::flag_wait( "flag_bailout_vo" );
    level.burke dialogue_queue_global( "fus_gdn_yourmtisdown" );
    common_scripts\utility::flag_clear( "flag_bailout_vo" );
}

enemy_walker_reveal_dialogue()
{
    common_scripts\utility::flag_wait( "flag_enemy_walker" );
    wait 3;

    if ( common_scripts\utility::flag( "player_in_x4walker" ) )
    {
        common_scripts\utility::flag_waitopen( "flag_bailout_vo" );
        wait 1;
    }

    level.burke dialogue_queue_global( "fus_gdn_prophetthekvajustrolled" );
    maps\_utility::delaythread( 2, common_scripts\utility::flag_set, "flag_walker_reveal_dialogue_complete" );
    radio_dialogue_queue_global( "fus_prt_copythatbravowevegot" );

    if ( !maps\_utility::player_has_weapon( "smaw_nolock_fusion" ) )
        level.burke dialogue_queue_global( "fus_gdn_mitchellgrabthatlauncherand" );

    thread hit_enemy_walker_nag();
    thread walker_trophy_system_dialogue();
    thread enemy_walker_destroyed_dialogue();
    common_scripts\utility::flag_wait( "flag_launcher_out_of_ammo" );

    if ( !common_scripts\utility::flag( "flag_walker_destroyed" ) )
        thread walker_ammo_crate_nag();
}

walker_trophy_system_dialogue()
{
    common_scripts\utility::flag_wait( "walker_trophy_1" );
    wait 0.5;
    level.joker dialogue_queue_global( "fus_jkr_bastardsgotatrophysystem" );
}

walker_ammo_crate_nag()
{
    level endon( "flag_walker_death_anim_start" );
    wait 4;
    level.burke maps\_utility::dialogue_queue( "fus_gdn_wehaveeyesonan2" );
    var_0 = [ "fus_gdn_thereisanammocrate2", "fus_gdn_getmoreammoforthat2" ];
    thread maps\_shg_utility::dialogue_reminder( level.burke, "flag_launcher_ammo_gathered", var_0, 5, 10 );
}

hit_enemy_walker_nag()
{
    level endon( "flag_walker_death_anim_start" );
    var_0 = [ "fus_gdn_takeoutthetitanwith", "fus_gdn_hitthetitanwiththe" ];
    maps\_shg_utility::dialogue_reminder( level.burke, "flag_launcher_out_of_ammo", var_0, 20, 30 );
    common_scripts\utility::flag_wait( "flag_launcher_ammo_gathered" );
    maps\_shg_utility::dialogue_reminder( level.burke, "flag_walker_death_anim_start", var_0, 20, 30 );
}

enemy_walker_destroyed_dialogue()
{
    common_scripts\utility::flag_wait( "flag_walker_destroyed" );
    wait 1.0;
    level.burke dialogue_queue_global( "fus_gdn_titansdowngoodjobmitchell" );
    wait 1;
    radio_dialogue_queue_global( "fus_prt_bravoteambeadvised" );
    level.burke dialogue_queue_global( "fus_gdn_copythatprophet" );
    level.burke dialogue_queue_global( "fus_gdn_wegottalegitto" );
}

play_interior_dialogue()
{
    thread vo_interior_security_room();
    thread vo_interior_lab();
    thread vo_interior_reactor();
    thread vo_interior_turbine_elevator();
    thread vo_interior_turbine_room();
    thread vo_interior_control_room_explosion();
    thread vo_interior_control_room();
    thread vo_tower_debris_radio_chatter();
    thread vo_fus_silo_collapse_burke();
}

vo_interior_security_room()
{
    common_scripts\utility::flag_wait( "vo_security_room" );
    wait 1;
    level.burke maps\_utility::dialogue_queue( "fus_gdn_staysharp" );
    common_scripts\utility::flag_wait( "vo_security_room_elevator_access" );
    level maps\_utility::dialogue_queue( "fus_prt_fastestaccesstothelower" );
    level.burke maps\_utility::dialogue_queue( "fus_gdn_roger3" );
    common_scripts\utility::flag_wait( "vo_security_room_elevator_open" );
    wait 1.5;
    level.joker maps\_utility::dialogue_queue( "fus_jkr_grunt" );
    wait 1;

    if ( !common_scripts\utility::flag( "elevator_descent_player" ) )
    {
        level.burke maps\_utility::dialogue_queue( "fus_gdn_oneatatimelets" );
        thread vo_elevator_descent_nag();
    }
}

vo_elevator_descent_nag()
{
    level endon( "elevator_descent_player" );

    while ( !common_scripts\utility::flag( "elevator_descent_player" ) )
    {
        wait 10;
        level.joker maps\_utility::dialogue_queue( "fus_jkr_afteryou" );
        wait 10;
        level.joker maps\_utility::dialogue_queue( "fus_jkr_youreupmitchell" );
        wait 10;
        level.joker maps\_utility::dialogue_queue( "fus_jkr_letsgomitchell" );
    }
}

vo_interior_lab()
{
    common_scripts\utility::flag_wait( "vo_lab_elevator_slide_complete" );
    level.burke maps\_utility::dialogue_queue( "fus_gdn_clear" );
    wait 1;
    level.burke maps\_utility::dialogue_queue( "fus_gdn_thisway" );
    wait 1;
    level maps\_utility::dialogue_queue( "fus_prt_bravoreactorcoretemperatureis" );
    level.joker maps\_utility::dialogue_queue( "fus_jkr_thatsbadnewsright" );
    level maps\_utility::dialogue_queue( "fus_prt_indicatorsarebelownormalrate" );
    level.burke maps\_utility::dialogue_queue( "fus_gdn_thenwecanstillmake" );
    common_scripts\utility::flag_wait( "vo_lab_entered" );

    if ( common_scripts\utility::cointoss() )
        level.joker maps\_utility::dialogue_queue( "fus_jkr_poorbastardsdidntstanda" );
    else
        level.joker maps\_utility::dialogue_queue( "fus_jkr_goddamnmassacreinhere" );

    level.burke maps\_utility::dialogue_queue( "fus_gdn_keepmoving" );
    common_scripts\utility::flag_wait( "vo_lab_junction" );
    level.burke maps\_utility::dialogue_queue( "fus_gdn_junction" );
    level maps\_utility::dialogue_queue( "fus_prt_headright" );
    level.burke maps\_utility::dialogue_queue( "fus_gdn_staytogether" );
}

vo_interior_reactor()
{
    common_scripts\utility::flag_wait( "vo_reactor_open_airlock" );
    level.burke maps\_utility::dialogue_queue( "fus_gdn_cartergetthisdooropen" );
    level.carter maps\_utility::dialogue_queue( "fus_ctr_copy" );
    common_scripts\utility::flag_wait( "vo_reactor_entrance" );
    wait 9;
    level.burke maps\_utility::dialogue_queue( "fus_ctr_exertion" );
    wait 3;
    level.burke maps\_utility::dialogue_queue( "fus_gdn_contact" );
    common_scripts\utility::flag_wait( "vo_reactor_gogogo" );
    level.burke maps\_utility::dialogue_queue( "fus_gdn_gogogo" );
    common_scripts\utility::flag_wait( "vo_reactor_quickly" );
    level maps\_utility::dialogue_queue( "fus_prt_bravogetthroughthereactor" );
    level.burke maps\_utility::dialogue_queue( "fus_gdn_tangosonthebalcony" );
    common_scripts\utility::flag_wait( "reactor_drones_1" );
    wait 2;
    level.joker maps\_utility::dialogue_queue( "fus_jkr_dronesaboveus" );
    common_scripts\utility::flag_wait( "vo_reactor_300m" );
    level maps\_utility::dialogue_queue( "fus_prt_youre300metersfromthe" );
    level.burke maps\_utility::dialogue_queue( "fus_gdn_copythat2" );
    level maps\_utility::dialogue_queue( "fus_prt_understood" );
    common_scripts\utility::flag_wait( "vo_reactor_exit" );
}

vo_interior_turbine_elevator()
{
    common_scripts\utility::flag_wait( "vo_turbine_elevator_near" );
    level.burke maps\_utility::dialogue_queue( "fus_gdn_prophetwereatthecargo" );
    level maps\_utility::dialogue_queue( "fus_prt_uponefloortothe" );
    common_scripts\utility::flag_wait( "vo_turbine_elevator_ready" );
    thread vo_interior_turbine_elevator_nag();
    common_scripts\utility::flag_wait( "vo_turbine_elevator" );
    wait 1;
    level.burke maps\_utility::dialogue_queue( "fus_gdn_deploycoveratthedoor" );
    common_scripts\utility::flag_set( "joker_place_elevator_cover" );
    level.joker maps\_utility::dialogue_queue( "fus_jkr_copythat" );
    common_scripts\utility::flag_wait( "turbine_room_combat_start" );
    level.burke maps\_utility::dialogue_queue( "fus_gdn_mitchelluseyourassaultdrone" );
}

vo_interior_turbine_elevator_nag()
{
    level endon( "vo_turbine_elevator" );

    for (;;)
    {
        level.burke maps\_utility::dialogue_queue( "fus_gdn_mitchellhittheswitch" );
        wait(randomintrange( 5, 10 ));
        level.burke maps\_utility::dialogue_queue( "fus_gdn_hitthebuttonmitchell" );
        wait(randomintrange( 5, 10 ));
    }
}

vo_interior_turbine_room()
{
    common_scripts\utility::flag_wait( "vo_turbine_room_entrance" );
    thread vo_turbine_room_clear();
    level.burke maps\_utility::dialogue_queue( "fus_gdn_exitsontheupperwalkway" );
    level.joker maps\_utility::dialogue_queue( "fus_jkr_what" );
    level.burke maps\_utility::dialogue_queue( "fus_gdn_upperwalkwaymove" );
    level.joker maps\_utility::dialogue_queue( "fus_jkr_icanthearagoddamn" );
    common_scripts\utility::flag_wait( "vo_turbine_keep_moving" );
    level.burke maps\_utility::dialogue_queue( "fus_gdn_keepmovingwerealmostthere" );
    common_scripts\utility::flag_wait( "vo_turbine_explosion" );
    level maps\_utility::dialogue_queue( "fus_prt_bravooutputjustspiked" );
    level.burke maps\_utility::dialogue_queue( "fus_gdn_werealmostthere" );
}

vo_turbine_room_clear()
{
    level endon( "player_drone_attack_done" );
    common_scripts\utility::flag_wait( "flag_turbine_pdrone_combat_complete" );
    wait 1;
    level.burke maps\_utility::dialogue_queue( "fus_gdn_areaclearletsmove" );
    wait 1;
    level.burke maps\_utility::dialogue_queue( "fus_gdn_wevegottogetto" );
}

vo_interior_control_room_explosion()
{
    common_scripts\utility::flag_wait( "vo_control_hall_door_stack" );
    maps\_utility::autosave_by_name( "control_room_start" );
    level maps\_utility::dialogue_queue( "fus_prt_controlroomdeadahead" );
    common_scripts\utility::flag_wait( "vo_control_hall_door_kicked" );
    level.burke maps\_utility::dialogue_queue( "fus_gdn_thereitis" );
    common_scripts\utility::flag_wait( "vo_control_room_explosion" );
    wait 0.1;
    level.carter maps\_utility::dialogue_queue( "fus_ctr_painexertion" );
    wait 1.2;
    level.burke maps\_utility::dialogue_queue( "fus_gdn_carteryoualright" );
    level.carter maps\_utility::dialogue_queue( "fus_ctr_imgood" );
    level.joker maps\_utility::dialogue_queue( "fus_jkr_thehelljusthappened" );
    level.burke maps\_utility::dialogue_queue( "fus_gdn_theyriggedthedoor" );
    wait 0.5;
    wait 4;
    level.carter maps\_utility::dialogue_queue( "fus_gdn_thisconsoleisstilllive" );
    level maps\_utility::dialogue_queue( "fus_prt_patchinandrundiagnostics" );
    common_scripts\utility::flag_set( "update_obj_pos_control_room_console" );
    common_scripts\utility::flag_set( "control_room_console_enable" );
    thread vo_interior_control_room_nag();
}

vo_interior_control_room_nag()
{
    level endon( "vo_control_room_scene" );

    for (;;)
    {
        level.burke maps\_utility::dialogue_queue( "fus_gdn_mitchellgetonthatconsole" );
        common_scripts\utility::flag_wait( "control_room_scene_ready" );
        wait(randomintrange( 5, 10 ));
        level.burke maps\_utility::dialogue_queue( "fus_gdn_mitchellgetontheconsole" );
        wait(randomintrange( 5, 10 ));
        level.burke maps\_utility::dialogue_queue( "fus_gdn_checkthecoolantlevelsmitchell" );
        wait(randomintrange( 5, 10 ));
    }
}

vo_interior_control_room()
{
    common_scripts\utility::flag_wait( "vo_control_room_scene" );
    wait 16.5;
    level notify( "control_room_event_1" );
    wait 3.4;
    level notify( "control_room_event_2" );
    wait 3.4;
    level notify( "control_room_event_3" );
    wait 1.7;
    maps\_utility::autosave_by_name( "control_room_complete" );
    wait 3;
    level waittill( "fusion_controlroom_dialog_done" );
    common_scripts\utility::flag_set( "shutdown_reactor_failed" );
    self notify( "control_room_scene_complete" );
    common_scripts\utility::flag_wait( "raise_control_room_emergency_exit_door" );
    wait 1;
    level maps\_utility::dialogue_queue( "fus_pa_warningreactorcritical" );
}

vo_tower_debris_radio_chatter()
{
    common_scripts\utility::flag_wait( "tower_debris" );
    soundscripts\_snd::snd_music_message( "mus_ending" );
    level maps\_utility::delaythread( 4, maps\_utility::dialogue_queue, "fus_alr_ivegottencasualtiesand" );
    level maps\_utility::delaythread( 10, maps\_utility::dialogue_queue, "fus_ch1_wraithtwofiveisdown" );
    level maps\_utility::delaythread( 14, maps\_utility::dialogue_queue, "fus_prt_allunitsgetrotorson" );
    level maps\_utility::delaythread( 20, maps\_utility::dialogue_queue, "fus_jkr_hesdeadcartersdead" );
    level maps\_utility::delaythread( 25, maps\_utility::dialogue_queue, "fus_alr_wheresourgoddamnairsupport" );
    level maps\_utility::delaythread( 28, maps\_utility::dialogue_queue, "fus_alr_wevelostcontactwithbravo" );
    level maps\_utility::delaythread( 31, maps\_utility::dialogue_queue, "fus_ch1_ineedcasevacunitsby" );
}

vo_fus_silo_collapse_burke()
{
    common_scripts\utility::flag_wait( "tower_debris" );
    level.burke maps\_utility::delaythread( 16, maps\_utility::dialogue_queue, "fus_gdn_thereheis" );
    level.burke maps\_utility::delaythread( 21, maps\_utility::dialogue_queue, "fus_gdn_prophetatlasteamisevacuating" );
    level.burke maps\_utility::delaythread( 27, maps\_utility::dialogue_queue, "fus_gdn_mitchellcomeon" );
}

init_pcap_vo()
{
    if ( level.nextgen )
    {
        init_pcap_vo_intro();
        init_pcap_vo_outro();
    }
    else if ( _func_21E( "fusion_intro_tr" ) )
    {
        init_pcap_vo_intro();
        level waittill( "tff_post_transition_middle_to_outro" );
        init_pcap_vo_outro();
    }
    else if ( _func_21E( "fusion_outro_tr" ) )
        init_pcap_vo_outro();
}

#using_animtree("generic_human");

init_pcap_vo_intro()
{
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %fusion_fly_in_intro_burke, "aud_fusion_fly_in_intro_burke_start", ::pcap_vo_fus_intro_burke );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %fusion_fly_in_pt2_burke, "aud_start_fusion_fly_in_pt2", ::pcap_vo_fus_intro_panama_burke );
}

init_pcap_vo_outro()
{
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %fusion_control_room_burke, "aud_start_fusion_controlroom_dialog", ::pcap_vo_fus_control_room_burke );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %fusion_control_room_npc_b, "aud_start_fusion_controlroom_dialog", ::pcap_vo_fus_control_room_joker );
}

pcap_vo_fus_intro_burke( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fus_gdn_everyoneseeingthisalright", 7.24 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fus_gdn_wereinsertinginthesouth", 15.09 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fus_gdn_getinposition2", 21.18, "aud_start_fusion_fly_in_intro_vo_done" );
}

pcap_vo_fus_intro_panama_burke( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fus_gdn_gonnabeagoodone", 4.03, "aud_start_fusion_fly_in_pt2_vo_done" );
}

pcap_vo_fus_control_room_burke( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fus_gdn_prophetyougotthis", 0.06 );
    level soundscripts\_snd_pcap::snd_pcap_play_radio_vo_60fps( "fus_prt_copy2", 1.36 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fus_gdn_okcoretempismaintaining", 3.24 );
    level soundscripts\_snd_pcap::snd_pcap_play_radio_vo_60fps( "fus_prt_thesteamreleaselineshave", 12.3 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fus_gdn_damnitwasstablea", 16.27 );
    level soundscripts\_snd_pcap::snd_pcap_play_radio_vo_60fps( "fus_prt_burkecoretemperatureiscritical", 19.23 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fus_gdn_ivegotthis", 24.04 );
    level soundscripts\_snd_pcap::snd_pcap_play_radio_vo_60fps( "fus_prt_wehavealevel7", 25.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fus_gdn_shit", 29.06 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "fus_gdn_copythat3", 32.12, "fusion_controlroom_dialog_done" );
}

pcap_vo_fus_control_room_joker( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo( "fus_jkr_boss", 16.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo( "fus_jkr_burke", 23.36 );
}

dialogue_queue_global( var_0, var_1 )
{
    if ( isdefined( level.scr_sound[self.animname][var_0] ) )
        global_dialogue_internal( var_0, self, var_1 );
}

radio_dialogue_queue_global( var_0, var_1 )
{
    if ( isdefined( level.scr_radio[var_0] ) )
        global_dialogue_internal( var_0, undefined, var_1 );
}

global_dialogue_internal( var_0, var_1, var_2 )
{
    if ( !isdefined( level.global_dialogue_function_stack ) )
        level.global_dialogue_function_stack = spawnstruct();

    if ( isdefined( var_1 ) )
    {
        if ( isdefined( var_2 ) )
            level.global_dialogue_function_stack maps\_utility::function_stack_timeout( var_2, ::global_dialogue_internal_play_dialogue, var_0, var_1 );
        else
            level.global_dialogue_function_stack maps\_utility::function_stack( ::global_dialogue_internal_play_dialogue, var_0, var_1 );
    }
    else if ( isdefined( var_2 ) )
        level.global_dialogue_function_stack maps\_utility::function_stack_timeout( var_2, ::global_dialogue_internal_play_radio, var_0 );
    else
        level.global_dialogue_function_stack maps\_utility::function_stack( ::global_dialogue_internal_play_radio, var_0 );
}

global_dialogue_internal_play_dialogue( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
    {
        common_scripts\utility::flag_set( "dialogue_playing" );
        maps\_utility::bcs_scripted_dialogue_start();
        var_1 maps\_anim::anim_single_queue( var_1, var_0 );
        common_scripts\utility::flag_clear( "dialogue_playing" );
    }
    else
    {

    }
}

global_dialogue_internal_play_radio( var_0 )
{
    common_scripts\utility::flag_set( "dialogue_playing" );
    level maps\_utility::dialogue_queue( var_0 );
    common_scripts\utility::flag_clear( "dialogue_playing" );
}
