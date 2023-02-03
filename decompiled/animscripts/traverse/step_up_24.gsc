// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( self.type == "dog" )
        animscripts\traverse\shared::dog_jump_up( 24.0, 5 );
    else
        human_traverse();
}

#using_animtree("generic_human");

human_traverse()
{
    var_0 = [];
    var_0["traverseAnim"] = %sw_traversal_suspension_on;
    var_0["traverseHeight"] = 24.0;
    animscripts\traverse\shared::dotraverse( var_0 );
}
