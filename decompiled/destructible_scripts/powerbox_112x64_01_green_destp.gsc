// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    common_scripts\_destructible::destructible_create( "powerbox_112x64_01_green_destp", "tag_origin", 500, undefined, 32, "no_melee" );
    common_scripts\_destructible::destructible_fx( "tag_fx", "vfx/destructible/powerbox_112x64_01_green", 1 );
    common_scripts\_destructible::destructible_explode( 30000, 34000, 100, 100, 10, 20 );
    common_scripts\_destructible::destructible_state( "tag_origin", "powerbox_112x64_01_green_dstry_destp", undefined, undefined, undefined, undefined, undefined, 0 );
    common_scripts\_destructible::destructible_part( "tag_door", "powerbox_112x64_01_green_door_part_a_destp", undefined, undefined, undefined, undefined, 1.0, 1.0 );
}
