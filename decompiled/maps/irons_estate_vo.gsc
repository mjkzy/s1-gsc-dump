// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    init_dialogue_flags();
    setup_vo();
    thread start_dialogue_threads();
    thread init_pcap_vo();
}

init_dialogue_flags()
{

}

setup_vo()
{

}

start_dialogue_threads()
{

}

#using_animtree("generic_human");

init_pcap_vo()
{
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %ie_intro_ally_1, "aud_ie_intro_ally_1", ::ie_intro_cormack );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %ie_briefing_start_ilona, "aud_ie_briefing_start_ilona_start", ::ie_briefing_start_ilona );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %ie_briefing_start_cormack, "aud_ie_briefing_start_cormack_start", ::ie_briefing_start_cormack );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %ie_briefing_start_cormack, "cormack_briefing_anim_start", ::ie_briefing_start_cormack_2 );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %ie_hangar_kva, "aud_ie_hangar_kva_start", ::ie_hangar_kva );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %ie_hangar_irons, "aud_ie_hangar_irons_start", ::ie_hangar_irons );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %ie_car_ride_driving_cormack, "aud_ie_car_ride_driving_cormack_start", ::ie_car_ride );
}

ie_intro_cormack( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_crmk_frontdoor", 18.35 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_crmk_readyhooks", 23.25 );
}

ie_briefing_start_ilona( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_iln_herehecomes", 2.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_iln_upagainstold", 9.03 );
}

ie_briefing_start_cormack( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_crk_goodtohaveyou", 5.12 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_crk_knowthisisdiff", 17.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_crk_thisisbigger", 21.27 );
}

ie_briefing_start_cormack_2( var_0 )
{
    wait 5.95;
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_crmk_greenlight", 0.09 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_crmk_privateestate", 4.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_crmk_insertionteam", 9.06 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_crmk_gatherintel", 14.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_crmk_getitdone", 20.0 );
}

ie_hangar_kva( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_doc_aslongas", 1.09 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_doc_wearemoving", 10.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_doc_iwillhavefailed", 17.12 );
}

ie_hangar_irons( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_irs_veryserious", 5.21 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_irs_concernforsafety", 14.27 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_irs_dontworry", 22.12 );
}

ie_car_ride( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_crk_runthatname", 0.09 );
    soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps( "ie_knx_alreadyonit", 3.15 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_crk_thekvadoc", 8.12 );
    soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps( "ie_iln_sodidi", 12.27 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_crk_getallthis", 14.15 );
    soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps( "ie_knx_copythat", 19.18 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "ie_crk_readynow", 26.21 );
}
