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
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %crash_atlas_plane_crash_ilona, "aud_crash_atlas_plane_crash_ilona_start", ::crash_plane_crash_ilona );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %crash_gideon_rescue_gideon, "aud_crash_gideon_rescue_gideon_start", ::crash_gideon_rescue_gideon );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %crash_gideon_rescue_gideon, "aud_crash_gideon_rescue_gideon_start2", ::crash_gideon_rescue2_gideon );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %crash_gideon_rescue_cormack, "aud_crash_gideon_rescue_cormack_start", ::crash_gideon_rescue_cormack );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %crash_gideon_rescue_cormack, "aud_crash_gideon_rescue_cormack_start2", ::crash_gideon_rescue2_cormack );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %crash_gideon_rescue_ilana, "aud_crash_gideon_rescue_ilona_start", ::crash_gideon_rescue_ilona );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %crash_gideon_rescue_ilana, "aud_crash_gideon_rescue_ilona_start2", ::crash_gideon_rescue2_ilona );
}

crash_plane_crash_ilona( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "crsh_iln_securingcargo", 2.24 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "crsh_iln_punctual", 13.21 );
}

crash_gideon_rescue_gideon( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "crsh_gdn_trustme", 1.18 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "crsh_gdn_exertion1", 5.03 );
}

crash_gideon_rescue2_gideon( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "crsh_gdn_exertion2", 0.27 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "crsh_gdn_thisisatlaszeroone", 6.27 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "crsh_gdn_andweallwouldbe", 17.24 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "crsh_gdn_ironsisplanninga", 23.15 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "crsh_gdn_ironshasbetrayed", 35.24 );
}

crash_gideon_rescue_cormack( var_0 )
{

}

crash_gideon_rescue2_cormack( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "crsh_crk_ifhewantedtokillus", 31.18 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "crsh_crk_okaythenleadtheway", 45.18 );
}

crash_gideon_rescue_ilona( var_0 )
{

}

crash_gideon_rescue2_ilona( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "crsh_iln_gideon", 2.24 );
    soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps( "crsh_atr_report", 4.21 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "crsh_as1_what", 10.15 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "crsh_iln_whynowgideon", 14.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "crsh_iln_andweresupposedtofollow", 29.15 );
}
