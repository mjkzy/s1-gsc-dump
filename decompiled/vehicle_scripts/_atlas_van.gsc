// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("vehicles");

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "atlas_van", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_deathmodel( "vehicle_armored_van", "vehicle_civ_workvan_dstrypv" );
    maps\_vehicle::build_deathfx( "vfx/explosion/vehicle_civ_ai_explo_med_runner", "TAG_DEATH_FX", "car_explode", undefined, undefined, undefined, 0 );
    maps\_vehicle::build_light( var_2, "brakelight_set", "tag_origin", "vfx/lights/veh_ind_van_utility_stop_light", "brakelights" );
    maps\_vehicle::build_radiusdamage( ( 0, 0, 32 ), 300, 200, 100, 0 );
    maps\_vehicle::build_drive( %uaz_driving_idle_forward, %uaz_driving_idle_backward, 10 );
    maps\_vehicle::build_deathquake( 1, 1.6, 500 );
    maps\_vehicle::build_life( 999, 5000, 6000 );
    maps\_vehicle::build_team( "axis" );
    maps\_vehicle::build_treadfx( var_2, "default", "vfx/treadfx/tread_dust_default" );
    maps\_vehicle::build_aianims( ::setanims, ::set_vehicle_anims );
    maps\_vehicle::build_unload_groups( ::unload_groups );
}

init_local()
{
    self _meth_8048( "rear_handle_obj_left_jnt" );
    self _meth_8048( "rear_handle_obj_right_jnt" );
}

set_vehicle_anims( var_0 )
{
    var_0[0].vehicle_getoutanim = %russian_swat_van_driver_getout_door;
    var_0[0].vehicle_getoutsoundtag = "front_door_left_jnt";
    var_0[0].vehicle_getoutanim_clear = 1;
    var_0[1].vehicle_getoutanim_clear = 0;
    var_0[2].vehicle_getoutanim_clear = 0;
    var_0[3].vehicle_getoutanim_clear = 0;
    var_0[4].vehicle_getoutanim_clear = 0;
    var_0[5].vehicle_getoutanim_clear = 0;
    var_0[6].vehicle_getoutanim_clear = 0;
    var_0[7].vehicle_getoutanim_clear = 0;
    var_0[8].vehicle_getoutanim_clear = 0;
    return var_0;
}

#using_animtree("generic_human");

setanims()
{
    var_0 = [];

    for ( var_1 = 0; var_1 < 9; var_1++ )
        var_0[var_1] = spawnstruct();

    var_0[0].sittag = "tag_driver";
    var_0[0].idle = %russian_swat_van_driver_idle;
    var_0[0].getout = %russian_swat_van_driver_getout;
    var_0[1].sittag = "tag_detach";
    var_0[1].idle = %humvee_idle_frontl;
    var_0[1].getout = %russian_swat_van_guyl1_getout;
    var_0[1].getout_secondary = %russian_swat_van_guyl_runoff;
    var_0[1].explosion_death = %death_explosion_stand_b_v1;
    var_0[2].sittag = "tag_detach";
    var_0[2].idle = %russian_swat_van_guyr1_idle;
    var_0[2].getout = %russian_swat_van_guyr1_getout;
    var_0[2].getout_secondary = %russian_swat_van_guyr_runoff;
    var_0[2].explosion_death = %death_explosion_stand_b_v2;
    var_0[3].sittag = "tag_detach";
    var_0[3].idle = %russian_swat_van_guyl2_idle;
    var_0[3].getout = %russian_swat_van_guyl2_getout;
    var_0[3].getout_secondary = %russian_swat_van_guyl_runoff;
    var_0[3].explosion_death = %death_explosion_stand_b_v3;
    var_0[4].sittag = "tag_detach";
    var_0[4].idle = %russian_swat_van_guyr2_idle;
    var_0[4].getout = %russian_swat_van_guyr2_getout;
    var_0[4].getout_secondary = %russian_swat_van_guyr_runoff;
    var_0[4].explosion_death = %death_explosion_stand_b_v4;
    var_0[5].sittag = "tag_detach";
    var_0[5].idle = %russian_swat_van_guyl3_idle;
    var_0[5].getout = %russian_swat_van_guyl3_getout;
    var_0[5].getout_secondary = %russian_swat_van_guyl_runoff;
    var_0[5].explosion_death = %death_explosion_stand_b_v2;
    var_0[6].sittag = "tag_detach";
    var_0[6].idle = %russian_swat_van_guyr3_idle;
    var_0[6].getout = %russian_swat_van_guyr3_getout;
    var_0[6].getout_secondary = %russian_swat_van_guyr_runoff;
    var_0[6].explosion_death = %death_explosion_stand_b_v1;
    var_0[7].sittag = "tag_detach";
    var_0[7].idle = %russian_swat_van_guyl4_idle;
    var_0[7].getout = %russian_swat_van_guyl4_getout;
    var_0[7].getout_secondary = %russian_swat_van_guyl_runoff;
    var_0[7].explosion_death = %death_explosion_stand_b_v4;
    var_0[8].sittag = "tag_detach";
    var_0[8].idle = %russian_swat_van_guyr4_idle;
    var_0[8].getout = %russian_swat_van_guyr4_getout;
    var_0[8].getout_secondary = %russian_swat_van_guyr_runoff;
    var_0[8].explosion_death = %death_explosion_stand_b_v3;
    return var_0;
}

unload_groups()
{
    var_0 = [];
    var_0["passengers"] = [];
    var_0["all"] = [];
    var_1 = "passengers";
    var_0[var_1][var_0[var_1].size] = 1;
    var_0[var_1][var_0[var_1].size] = 2;
    var_0[var_1][var_0[var_1].size] = 3;
    var_0[var_1][var_0[var_1].size] = 4;
    var_0[var_1][var_0[var_1].size] = 5;
    var_0[var_1][var_0[var_1].size] = 6;
    var_0[var_1][var_0[var_1].size] = 7;
    var_0[var_1][var_0[var_1].size] = 8;
    var_1 = "all";
    var_0[var_1][var_0[var_1].size] = 0;
    var_0[var_1][var_0[var_1].size] = 1;
    var_0[var_1][var_0[var_1].size] = 2;
    var_0[var_1][var_0[var_1].size] = 3;
    var_0[var_1][var_0[var_1].size] = 4;
    var_0[var_1][var_0[var_1].size] = 5;
    var_0[var_1][var_0[var_1].size] = 6;
    var_0[var_1][var_0[var_1].size] = 7;
    var_0[var_1][var_0[var_1].size] = 8;
    var_0["default"] = var_0["all"];
    return var_0;
}
