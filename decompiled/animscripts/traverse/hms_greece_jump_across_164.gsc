// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    hms_greece_jump_across_164();
}

#using_animtree("generic_human");

hms_greece_jump_across_164()
{
    var_0 = [];
    var_0["traverseAnim"] = %hms_greece_gap_jump_164_npc;
    animscripts\traverse\shared::dotraverse( var_0 );
}
