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
    level waittill( "load_finished" );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %dogfight_finale_knoxdeath_gideon, "aud_dogfight_finale_knoxdeath_gideon_start", ::dogfight_finale_knoxdeath_gideon );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %dogfight_finale_knoxdeath_knox, "aud_dogfight_finale_knoxdeath_knox_start", ::dogfight_finale_knoxdeath_knox );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %dogfight_finale_knoxdeath_ilona, "aud_dogfight_finale_knoxdeath_ilona_start", ::dogfight_finale_knoxdeath_ilona );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %dogfight_vtol_ride_enter_ilona, "aud_dogfight_vtol_ride_enter_ilona", ::dogfight_vtol_ride_enter_ilona );
    soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping( %dogfight_vtol_ride_enter_knox, "aud_dogfight_vtol_ride_enter_knox", ::dogfight_vtol_ride_enter_knox );
}

dogfight_finale_knoxdeath_gideon( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "df_gdn_knoxisdown", 9.0 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "df_gdn_ironsengineered", 26.21 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "df_gdn_returnfire", 33.24 );
}

dogfight_finale_knoxdeath_knox( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "df_knx_goddamn", 1.15 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "df_knx_manticore", 11.21 );
}

dogfight_finale_knoxdeath_ilona( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "df_iln_whatshappeningpcap", 7.21 );
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "df_iln_whyarentwe", 25.03 );
}

dogfight_vtol_ride_enter_ilona( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "df_iln_themainassault", 0.15 );
}

dogfight_vtol_ride_enter_knox( var_0 )
{
    var_0 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps( "df_knx_getonthat", 3.12 );
}

dogfight_irons_speech_bink()
{
    level.player _meth_8512( 56, "df_irs_citizensofbaghdad" );
    level.player _meth_8512( 273, "df_irs_lookaroundyou" );
    level.player _meth_8512( 468, "df_irs_eachandevery" );
    level.player _meth_8512( 674, "df_irs_wewillsuffer" );
    level.player _meth_8512( 870, "df_irs_thesecurity" );
    level.player _meth_8512( 1076, "df_irs_butitcanonly" );
}
