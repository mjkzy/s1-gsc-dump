// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( self.type == "dog" )
        animscripts\traverse\shared::dog_jump_up( 38.0, 5 );
    else
        low_wall_human();
}

#using_animtree("generic_human");

low_wall_human()
{
    var_0 = [];
    var_0["traverseAnim"] = %berlin_jumping_column_sandman;
    var_0["traverseHeight"] = 38.0;
    animscripts\traverse\shared::dotraverse( var_0 );
}
