// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    dest_onestate( "berlin_hotel_lights_wall2", "berlin_hotel_lights_wall2_destroyed", "fx/misc/light_blowout_wall_runner" );
}

dest_onestate( var_0, var_1, var_2, var_3 )
{
    common_scripts\_destructible::destructible_create( var_0, "tag_origin", 150, undefined, 32 );
    common_scripts\_destructible::destructible_fx( "tag_fx", var_2 );
    common_scripts\_destructible::destructible_state( "tag_origin", var_1, undefined, undefined, "no_meele" );

    if ( isdefined( var_3 ) )
        common_scripts\_destructible::destructible_sound( var_3 );
}
