// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

main()
{
    maps\_props::add_cellphone_notetracks( "generic" );
    level.scr_anim["generic"]["phone_idle"][0] = %patrol_bored_idle_cellphone;
    level.scr_anim["generic"]["phone_react"] = %patrol_bored_react_look_retreat;
}
