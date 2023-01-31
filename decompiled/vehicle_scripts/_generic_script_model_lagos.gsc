// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "script_model", var_0, var_1, var_2 );
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_deathmodel( "ac_prs_veh_civ_car_a_1", "ac_prs_veh_civ_car_a_dam1", 0 );
    maps\_vehicle::build_deathmodel( "ac_prs_veh_civ_car_a_2", "ac_prs_veh_civ_car_a_dam2", 0 );
    maps\_vehicle::build_deathmodel( "ac_prs_veh_civ_car_a_3", "ac_prs_veh_civ_car_a_dam3", 0 );
    maps\_vehicle::build_deathmodel( "ac_prs_veh_civ_car_a_4", "ac_prs_veh_civ_car_a_dam4", 0 );
    maps\_vehicle::build_deathmodel( "ac_prs_veh_civ_car_a_5", "ac_prs_veh_civ_car_a_dam5", 0 );
    maps\_vehicle::build_deathmodel( "ac_prs_veh_civ_car_a_6", "ac_prs_veh_civ_car_a_dam6", 0 );
    maps\_vehicle::build_deathmodel( "ac_prs_veh_civ_car_a_7", "ac_prs_veh_civ_car_a_dam7", 0 );
    maps\_vehicle::build_deathfx_generic_script_model( "vfx/explosion/vehicle_civ_ai_explo_small_runner", "TAG_ORIGIN", "lag_rndabt_car_small_explo", undefined, undefined, undefined, 0 );
}

init_local()
{
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

    for ( var_1 = 0; var_1 < 1; var_1++ )
        var_0[var_1] = spawnstruct();

    var_0[0].sittag = "tag_driver";
    var_0[0].idle = %civ_domestic_smartcar_driver_idle;
    return var_0;
}
