// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    common_scripts\_destructible::destructible_create( "wall_firebox_destp", "tag_origin", 50 );
    common_scripts\_destructible::destructible_fx( undefined, "vfx/destructible/wall_firebox_init_xplod", 1 );
    common_scripts\_destructible::destructible_state( "tag_origin", "destp_invisible_poly_01" );
}
