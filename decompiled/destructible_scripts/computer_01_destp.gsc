// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    common_scripts\_destructible::destructible_create( "computer_01_destp", "tag_origin", 200 );
    common_scripts\_destructible::destructible_fx_spawn_immediate( "tag_fx", "vfx/test/ui_prototype/ui_compscrn_proto", 1, undefined, undefined, undefined, 2 );
    common_scripts\_destructible::destructible_fx( "tag_fx", "vfx/glass/glass_shatter_01", 1 );
    common_scripts\_destructible::destructible_state( undefined, "computer_screen_01_dstry_destp", 300 );
    common_scripts\_destructible::destructible_state();
}
