// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    hms_greece_window_over_40();
}

#using_animtree("generic_human");

hms_greece_window_over_40()
{
    var_0 = [];
    var_0[0] = %hms_greece_alleys_trav_over_40_window_quick;
    var_0[1] = %hms_greece_alleys_trav_over_40_window_run_01;
    var_0[2] = %hms_greece_alleys_trav_over_40_window_run_02;
    var_0[3] = %hms_greece_alleys_trav_over_40_window_run_03;
    var_1 = [];
    var_1["traverseAnim"] = var_0[randomint( var_0.size )];
    thread glass_break();
    animscripts\traverse\shared::dotraverse( var_1 );
}

glass_break()
{
    level waittill( "glass_break" );

    if ( isdefined( self ) )
        glassradiusdamage( self.origin, 48, 1000, 1000 );
}
