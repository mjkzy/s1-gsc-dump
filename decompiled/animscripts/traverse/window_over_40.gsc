// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( self.type == "dog" )
        animscripts\traverse\shared::dog_wall_and_window_hop( "window_40", 40 );
    else
        jump_through_window_human();
}

#using_animtree("generic_human");

jump_through_window_human()
{
    var_0 = [];
    var_0["traverseAnim"] = %traverse_window_m_2_run;
    var_0["traverseToCoverAnim"] = %traverse_window_m_2_stop;
    var_0["coverType"] = "Cover Crouch";
    var_0["traverseHeight"] = 36.0;
    var_0["interruptDeathAnim"][0] = animscripts\utility::array( %traverse_window_death_start );
    var_0["interruptDeathAnim"][1] = animscripts\utility::array( %traverse_window_death_end );
    animscripts\traverse\shared::dotraverse( var_0 );
}
