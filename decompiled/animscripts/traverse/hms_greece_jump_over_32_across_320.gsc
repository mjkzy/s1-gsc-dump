// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    hms_greece_jump_over_32_across_320();
}

#using_animtree("generic_human");

hms_greece_jump_over_32_across_320()
{
    var_0 = [];
    var_0["traverseAnim"] = %hms_greece_traverse_balcony_custom_01;
    var_0["traverseHeight"] = 32.0;
    animscripts\traverse\shared::dotraverse( var_0 );
}
