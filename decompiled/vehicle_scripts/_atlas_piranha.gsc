// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2, var_3 )
{
    precachemodel( "vehicle_speedboat_piranha_turret" );
    precacheturret( "warbird_turret" );
    maps\_vehicle::build_template( "atlas_piranha", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_team( "axis" );

    if ( isdefined( var_3 ) )
        maps\_vehicle::build_turret( var_3, "tag_turret", "vehicle_speedboat_piranha_turret", undefined, "manual", 0.5, 20, -14 );
}

init_local()
{

}
