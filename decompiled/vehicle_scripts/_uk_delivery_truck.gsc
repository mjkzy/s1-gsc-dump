// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("vehicles");

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "uk_delivery_truck", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_deathmodel( var_0, "vehicle_uk_delivery_truck_destroyed" );
    maps\_vehicle::build_deathfx( "fx/explosions/large_vehicle_explosion", undefined, "car_explode", undefined, undefined, undefined, 0 );
    maps\_vehicle::build_radiusdamage( ( 0, 0, 32 ), 300, 200, 100, 0 );
    maps\_vehicle::build_drive( %uaz_driving_idle_forward, %uaz_driving_idle_backward, 10 );
    maps\_vehicle::build_deathquake( 1, 1.6, 500 );
    maps\_vehicle::build_treadfx();
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_team( "axis" );
    var_3 = ::setanims;
    maps\_vehicle::build_aianims( var_3, ::set_vehicle_anims );
}

init_local()
{

}

unload_groups()
{
    var_0 = [];
    var_1 = "passengers";
    var_0[var_1] = [];
    var_0[var_1][var_0[var_1].size] = 1;
    var_1 = "all";
    var_0[var_1] = [];
    var_0[var_1][var_0[var_1].size] = 0;
    var_0[var_1][var_0[var_1].size] = 1;
    var_0["default"] = var_0["all"];
    return var_0;
}

set_vehicle_anims( var_0 )
{
    var_0[0].vehicle_getoutanim = %uaz_driver_exit_into_run_door;
    var_0[0].vehicle_getoutanim_clear = 0;
    var_0[1].vehicle_getoutanim = %innocent_truck_exit_passenger_fwd_truck;
    var_0[1].vehicle_getoutanim_clear = 0;
    var_0[0].vehicle_getinanim = %humvee_mount_frontl_door;
    var_0[1].vehicle_getinanim = %humvee_mount_frontr_door;
    var_0[0].vehicle_getoutsound = "ukdelivery_door_open";
    var_0[1].vehicle_getoutsound = "ukdelivery_door_open";
    var_0[0].vehicle_getinsound = "ukdelivery_door_close";
    var_0[1].vehicle_getinsound = "ukdelivery_door_close";
    return var_0;
}

#using_animtree("generic_human");

setanims()
{
    var_0 = [];

    for ( var_1 = 0; var_1 < 4; var_1++ )
        var_0[var_1] = spawnstruct();

    var_0[0].sittag = "tag_driver";
    var_0[1].sittag = "tag_passenger";
    var_0[0].bhasgunwhileriding = 0;
    var_0[0].idle = %technical_driver_idle;
    var_0[1].idle = %technical_passenger_idle;
    var_0[0].getout = %pickup_passenger_climb_out;
    var_0[1].getout = %innocent_truck_exit_passenger_fwd;
    var_0[0].getin = %pickup_driver_climb_in;
    var_0[1].getin = %pickup_passenger_climb_in;
    return var_0;
}
