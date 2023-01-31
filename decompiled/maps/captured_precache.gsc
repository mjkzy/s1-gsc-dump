// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    common_scripts\utility::add_destructible_type_function( "container_plastic_72x56x48_01_destp", destructible_scripts\container_plastic_72x56x48_01_destp::main );
    destructible_scripts\container_plastic_72x56x48_01_destp::main();
    vehicle_scripts\_mil_cargo_truck::main( "vehicle_mil_cargo_truck_physics_wide", "mil_cargo_truck_physics", "script_vehicle_mil_cargo_truck_physics_wide" );
    vehicle_scripts\_mil_cargo_truck::main( "vehicle_mil_cargo_truck_captured_ai", undefined, "script_vehicle_mil_cargo_truck_wide" );
    vehicle_scripts\_pdrone::main( "vehicle_atlas_assault_drone_large", undefined, "script_vehicle_pdrone_atlas_large" );
    vehicle_scripts\_vrap::main( "vehicle_mil_humvee", undefined, "script_vehicle_vrap" );
    vehicle_scripts\_xh9_warbird::main( "vehicle_xh9_warbird", undefined, "script_vehicle_xh9_warbird_no_turret" );
}
