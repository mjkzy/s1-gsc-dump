// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    common_scripts\utility::add_destructible_type_function( "powerbox_112x64_01_green_destp", destructible_scripts\powerbox_112x64_01_green_destp::main );
    common_scripts\utility::add_destructible_type_function( "toy_electricbox4", destructible_scripts\toy_electricbox4::main );
    destructible_scripts\powerbox_112x64_01_green_destp::main();
    vehicle_scripts\_atlas_jet::main( "atlas_fighter_jet", undefined, "script_vehicle_atlas_jet" );
    vehicle_scripts\_s19::main( "vehicle_sentinel_fighter_jet", undefined, "script_vehicle_s19_player" );
}
