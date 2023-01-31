// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    hms_greece_jump_over_36_down_180();
}

#using_animtree("generic_human");

hms_greece_jump_over_36_down_180()
{
    var_0[0] = %hms_greece_traverse_balcony_ledge_180;
    var_0[1] = %hms_greece_traverse_balcony_ledge_180_b;
    var_1 = [];
    var_1["traverseAnim"] = var_0[randomint( var_0.size )];
    var_1["traverseHeight"] = 36.0;
    animscripts\traverse\shared::dotraverse( var_1 );
}
