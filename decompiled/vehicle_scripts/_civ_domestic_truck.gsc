// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("vehicles");

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "civ_domestic_truck", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_drive( %technical_driving_idle_forward, %technical_driving_idle_backward, 10 );
    maps\_vehicle::build_treadfx( var_2, "default", "vfx/treadfx/tread_dust_default" );
    maps\_vehicle::build_treadfx_script_model( var_2, "default", "vfx/treadfx/tread_dust_van_bright" );
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_aianims( ::setanims, ::set_vehicle_anims );
    maps\_vehicle::build_deathmodel( "vehicle_civ_domestic_truck", "vehicle_civ_domestic_truck_dstrypv", 0 );
    maps\_vehicle::build_deathmodel( "vehicle_civ_domestic_truck_blue", "vehicle_civ_domestic_truck_dstrypv", 0 );
    maps\_vehicle::build_deathmodel( "vehicle_civ_domestic_truck_gold", "vehicle_civ_domestic_truck_dstrypv", 0 );
    maps\_vehicle::build_deathmodel( "vehicle_civ_domestic_truck_grn", "vehicle_civ_domestic_truck_dstrypv", 0 );
    maps\_vehicle::build_deathmodel( "vehicle_civ_domestic_truck_slvr", "vehicle_civ_domestic_truck_dstrypv", 0 );
    maps\_vehicle::build_deathfx( "vfx/explosion/vehicle_civ_ai_explo_med_runner", "TAG_DEATH_FX", "lag_rndabt_car_large_explo", undefined, undefined, undefined, 0 );
}

init_local()
{
    soundscripts\_snd::snd_message( "civ_domestic_truck_spawn", self );
    soundscripts\_snd::snd_message( "atlas_van_explode" );
}

set_vehicle_anims( var_0 )
{
    return var_0;
}

#using_animtree("generic_human");

setanims()
{
    var_0 = [];

    for ( var_1 = 0; var_1 < 2; var_1++ )
        var_0[var_1] = spawnstruct();

    var_0[0].sittag = "tag_driver";
    var_0[1].sittag = "tag_passenger";
    var_0[0].idle = %civ_domestic_truck_driver_idle;
    var_0[1].idle = %civ_domestic_truck_passenger_idle;
    return var_0;
}
