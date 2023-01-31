// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    common_scripts\utility::add_destructible_type_function( "container_plastic_72x56x48_01_destp", destructible_scripts\container_plastic_72x56x48_01_destp::main );
    common_scripts\utility::add_destructible_type_function( "vehicle_suv_atlas_destpv", destructible_scripts\vehicle_suv_atlas_destpv::main );
    destructible_scripts\container_plastic_72x56x48_01_destp::main();
    destructible_scripts\vehicle_suv_atlas_destpv::main();
    vehicle_scripts\_attack_drone_queen::main( "vehicle_mil_attack_drone_static", undefined, "script_vehicle_attack_drone_queen" );
    vehicle_scripts\_attack_drone_queen::main( "vehicle_atlas_assault_drone_large_static", undefined, "script_vehicle_attack_drone_queen_atlas" );
    vehicle_scripts\_ft101_tank::main( "vehicle_ft101_tank", "ft101_tank_physics", "script_vehicle_ft101_tank_physics" );
    vehicle_scripts\_mig29::main( "vehicle_mig29", undefined, "script_vehicle_mig29" );
    vehicle_scripts\_gaz::main( "vehicle_mil_gaz_ai", undefined, "script_vehicle_mil_gaz_ai" );
    vehicle_scripts\_razorback::main( "vehicle_razorback", undefined, "script_vehicle_razorback" );
    vehicle_scripts\_shrike::main( "vehicle_airplane_shrike", undefined, "script_vehicle_shrike" );
    vehicle_scripts\_walker_tank::main( "vehicle_walker_tank", undefined, "script_vehicle_walker_tank" );
    vehicle_scripts\_walker_tank::main( "vehicle_walker_tank", undefined, "script_vehicle_walker_tank_generic" );
    vehicle_scripts\_x4walker_wheels_turret_closed::main( "vehicle_npc_x4walkersplit_wheels", undefined, "script_vehicle_x4walker_wheels_turret_closed" );
    vehicle_scripts\_xh9_warbird::main( "vehicle_xh9_warbird", undefined, "script_vehicle_xh9_warbird" );
    vehicle_scripts\_xh9_warbird::main( "vehicle_xh9_warbird_low", undefined, "script_vehicle_xh9_warbird_cheap" );
    vehicle_scripts\_xh9_warbird::main( "vehicle_xh9_warbird", undefined, "script_vehicle_xh9_warbird_no_zipline_atlas_desert" );
    vehicle_scripts\_xh9_warbird::main( "vehicle_xh9_warbird_stealth", undefined, "script_vehicle_xh9_warbird_stealth" );
    vehicle_scripts\_xh9_warbird::main( "vehicle_xh9_warbird_stealth_col", undefined, "script_vehicle_xh9_warbird_stealth_col" );
    vehicle_scripts\_xh9_warbird::main( "vehicle_xh9_warbird_low", undefined, "script_vehicle_xh9_warbird_stealth_low" );
}
