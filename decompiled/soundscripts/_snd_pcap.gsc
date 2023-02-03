// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

snd_pcap_play_vo( var_0, var_1, var_2, var_3 )
{
    thread sndx_pcap_play_vo_thread( var_0, var_1, var_2, var_3 );
}

snd_pcap_play_vo_30fps( var_0, var_1, var_2, var_3 )
{
    thread sndx_pcap_play_vo_thread( var_0, var_1, var_2, 30, var_3 );
}

snd_pcap_play_vo_20fps( var_0, var_1, var_2 )
{
    thread sndx_pcap_play_vo_thread( var_0, var_1, var_2, 20 );
}

snd_pcap_play_radio_vo( var_0, var_1, var_2, var_3 )
{
    thread sndx_pcap_play_radio_vo_thread( var_0, var_1, var_2, var_3 );
}

snd_pcap_play_radio_vo_60fps( var_0, var_1, var_2 )
{
    thread sndx_pcap_play_radio_vo_thread( var_0, var_1, var_2, 60 );
}

snd_pcap_play_radio_vo_30fps( var_0, var_1, var_2 )
{
    thread sndx_pcap_play_radio_vo_thread( var_0, var_1, var_2, 30 );
}

snd_pcap_add_notetrack_mapping( var_0, var_1, var_2 )
{
    var_3 = sndx_pcap_find_anime_and_animname( var_0 );
    var_4 = var_3["animname"];
    var_5 = var_3["anime"];
    maps\_anim::addnotetrack_customfunction( var_4, var_1, var_2, var_5 );
}

sndx_pcap_play_vo_thread( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = self;
    var_2 = soundscripts\_audio::aud_get_optional_param( undefined, var_2 );
    var_5 = soundscripts\_audio::aud_get_optional_param( 0.1, var_5 );
    sndx_pcap_wait( var_1, var_3 );
    var_7 = spawn( "script_origin", var_6.origin );
    var_7 linkto( var_6 );
    var_7 scalevolume( 1.0, 0.0 );
    var_7 soundscripts\_snd_playsound::snd_play( var_0, "sound_done" );
    var_7 endon( "death" );

    if ( isstring( var_4 ) )
        var_7 thread sndx_pcap_play_vo_monitor_stopnotify( var_5, var_4 );

    var_7 waittill( "sound_done" );

    if ( isstring( var_2 ) )
        level notify( var_2 );

    wait 0.05;
    var_7 delete();
}

sndx_pcap_play_vo_monitor_stopnotify( var_0, var_1 )
{
    self endon( "death" );
    var_2 = self;
    level waittill( var_1 );
    var_2 thread sndx_pcap_play_vo_fade_delete( var_0 );
}

sndx_pcap_play_vo_fade_delete( var_0 )
{
    var_1 = self;

    if ( isdefined( var_1 ) )
    {
        if ( isdefined( var_0 ) )
        {
            var_1 scalevolume( 0, var_0 );
            wait(var_0);
            waittillframeend;
        }

        if ( isdefined( var_1 ) )
            var_1 delete();
    }
}

sndx_pcap_play_radio_vo_thread( var_0, var_1, var_2, var_3 )
{
    var_2 = soundscripts\_audio::aud_get_optional_param( undefined, var_2 );
    sndx_pcap_wait( var_1, var_3 );
    level maps\_utility::dialogue_queue( var_0 );

    if ( isstring( var_2 ) )
        level notify( var_2 );
}

sndx_pcap_wait( var_0, var_1 )
{
    var_0 = soundscripts\_audio::aud_get_optional_param( 0, var_0 );
    var_1 = soundscripts\_audio::aud_get_optional_param( 60, var_1 );
    var_2 = floor( var_0 );
    var_3 = ( var_0 - var_2 ) * 100;
    var_4 = var_2 + var_3 * 1 / var_1;
    wait(var_4);
}

sndx_pcap_find_anime_and_animname( var_0 )
{
    foreach ( var_7, var_2 in level.scr_anim )
    {
        if ( isstring( var_7 ) && isarray( var_2 ) )
        {
            foreach ( var_6, var_4 in var_2 )
            {
                if ( isstring( var_6 ) && !isarray( var_4 ) )
                {
                    if ( var_0 == var_4 )
                    {
                        var_5 = [];
                        var_5["anime"] = var_6;
                        var_5["animname"] = var_7;
                        return var_5;
                    }
                }
            }
        }
    }
}
