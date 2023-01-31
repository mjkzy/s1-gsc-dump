// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

transition_unload_then_load_safely( var_0, var_1, var_2 )
{
    if ( _func_21E( var_0 ) )
        _func_219( var_0 );

    for (;;)
    {
        if ( !_func_21E( var_0 ) )
            break;

        wait 0.1;
    }

    _func_218( var_1 );

    for (;;)
    {
        if ( _func_21E( var_1 ) )
            break;

        wait 0.1;
    }

    level notify( var_2 );
}

check_wait_on_cg_notetracks( var_0, var_1, var_2 )
{
    if ( level.currentgen )
    {
        if ( !issubstr( level.transient_zone, var_0 ) )
            level waittill( var_1 );
    }

    [[ var_2 ]]();
}

setup_start_points_for_transients()
{
    var_0 = [ "greece_intro_tr", "greece_market_audio_tr" ];
    maps\_utility::set_start_transients( "start_safehouse_intro", var_0 );
    maps\_utility::set_start_transients( "start_safehouse_follow", var_0 );
    var_0 = [ "greece_intro_tr" ];
    maps\_utility::set_start_transients( "start_safehouse_xslice", var_0 );
    maps\_utility::set_start_transients( "start_safehouse_clear", var_0 );
    maps\_utility::set_start_transients( "start_safehouse_transition", var_0 );
    maps\_utility::set_start_transients( "start_conf_center_intro", var_0 );
    var_0 = [ "greece_confcenter_tr" ];
    maps\_utility::set_start_transients( "start_conf_center_support1", var_0 );
    maps\_utility::set_start_transients( "start_conf_center_support2", var_0 );
    maps\_utility::set_start_transients( "start_conf_center_support3", var_0 );
    maps\_utility::set_start_transients( "start_conf_center_kill", var_0 );
    maps\_utility::set_start_transients( "start_conf_center_combat", var_0 );
    maps\_utility::set_start_transients( "start_conf_center_outro", var_0 );
    var_0 = [ "greece_intro_tr" ];
    maps\_utility::set_start_transients( "start_safehouse_exit", var_0 );
    maps\_utility::set_start_transients( "start_alleys_transition", var_0 );
    var_0 = [ "greece_middle_tr" ];
    maps\_utility::set_start_transients( "start_alleys", var_0 );
    maps\_utility::set_start_transients( "start_alleys_art", var_0 );
    maps\_utility::set_start_transients( "start_alleys_art", var_0 );
    maps\_utility::set_start_transients( "start_alleys_end", var_0 );
    maps\_utility::set_start_transients( "start_sniper_scramble_intro", var_0 );
    var_0 = [ "greece_outro_tr" ];
    maps\_utility::set_start_transients( "start_sniper_scramble_hotel", var_0 );
    maps\_utility::set_start_transients( "start_sniper_scramble_drones", var_0 );
    maps\_utility::set_start_transients( "start_sniper_scramble_finale", var_0 );
    var_0 = [ "greece_hades_fight_tr" ];
    maps\_utility::set_start_transients( "start_ending_ambush", var_0 );
    maps\_utility::set_start_transients( "start_ending_fight", var_0 );
    maps\_utility::set_start_transients( "start_ending_hades", var_0 );
    level.transient_zone = "";

    if ( _func_21E( "greece_intro_tr" ) )
        level.transient_zone = "intro";

    if ( _func_21E( "greece_confCenter_tr" ) )
        level.transient_zone += "_confCenter";
    else if ( _func_21E( "greece_middle_tr" ) )
        level.transient_zone += "_middle";
    else if ( _func_21E( "greece_outro_tr" ) )
        level.transient_zone += "_outro";
    else if ( _func_21E( "greece_hades_fight_tr" ) )
        level.transient_zone += "_hades_fight";

    if ( level.transient_zone == "intro" )
        level notify( "transients_intro" );
}
