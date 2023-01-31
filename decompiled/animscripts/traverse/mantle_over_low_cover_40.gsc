// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( self.type == "dog" )
        animscripts\traverse\shared::dog_wall_and_window_hop( "window_40", 40 );
    else
        mantle_over_low_wall_40_human();
}

#using_animtree("generic_human");

mantle_over_low_wall_40_human()
{
    var_0 = [];
    var_0["traverseAnim"] = common_scripts\utility::random( [ %traverse_mantle_over_low_cover_40_var1, %traverse_mantle_over_low_cover_40_var2 ] );
    var_0["traverseHeight"] = 0;
    animscripts\traverse\shared::dotraverse( var_0 );
}
