// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("vehicles");

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "gaz_tigr_harbor", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_unload_groups( ::unload_groups );
    maps\_vehicle::build_drive( %humvee_50cal_driving_idle_forward, %humvee_50cal_driving_idle_backward, 10 );
    maps\_vehicle::build_treadfx();
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_team( "axis" );

    if ( issubstr( var_2, "turret" ) )
    {
        maps\_vehicle::build_aianims( ::setanims_turret, ::set_vehicle_anims_turret );

        if ( issubstr( var_2, "_paris" ) || issubstr( var_2, "_hijack" ) )
            maps\_vehicle::build_turret( "dshk_gaz_damage_player", "tag_turret", "weapon_dshk_turret", undefined, "auto_ai", 0.2, -20, -14 );
        else if ( issubstr( var_2, "_recovery" ) )
            maps\_vehicle::build_turret( "dshk_gaz_recovery", "tag_turret", "weapon_dshk_turret", undefined, "auto_ai", 0.2, -20, -14 );
        else if ( issubstr( var_2, "_factory" ) )
            maps\_vehicle::build_turret( "dshk_gaz_factory", "tag_turret", "weapon_dshk_turret", undefined, "auto_ai", 0.2, -20, -14 );
        else
            maps\_vehicle::build_turret( "dshk_gaz", "tag_turret", "weapon_dshk_turret", undefined, "auto_ai", 0.2, -20, -14 );
    }
    else
        maps\_vehicle::build_aianims( ::setanims, ::set_vehicle_anims );

    if ( var_2 == "script_vehicle_gaz_tigr_turret_physics_paris" )
    {

    }
    else
        build_gaz_death( var_2 );

    maps\_vehicle::build_light( var_2, "running_headlight_L", "TAG_HEADLIGHT_LEFT", "vfx/lights/headlight_gaz", "running", 0.0 );
    maps\_vehicle::build_light( var_2, "running_headlight_R", "TAG_HEADLIGHT_RIGHT", "vfx/lights/headlight_gaz", "running", 0.0 );
    maps\_vehicle::build_light( var_2, "running_brakelight_L", "TAG_BRAKELIGHT_LEFT", "vfx/lights/taillight_gaz", "running", 0.0 );
    maps\_vehicle::build_light( var_2, "running_brakelight_R", "TAG_BRAKELIGHT_RIGHT", "vfx/lights/taillight_gaz", "running", 0.0 );
    maps\_vehicle::build_light( var_2, "headlights_headlight_L", "TAG_HEADLIGHT_LEFT", "vfx/lights/headlight_gaz", "headlights", 0.0 );
    maps\_vehicle::build_light( var_2, "headlights_headlight_R", "TAG_HEADLIGHT_RIGHT", "vfx/lights/headlight_gaz", "headlights", 0.0 );
    maps\_vehicle::build_light( var_2, "headlights_brakelight_L", "TAG_BRAKELIGHT_LEFT", "vfx/lights/taillight_gaz", "headlights", 0.0 );
    maps\_vehicle::build_light( var_2, "headlights_brakelight_R", "TAG_BRAKELIGHT_RIGHT", "vfx/lights/taillight_gaz", "headlights", 0.0 );
    maps\_vehicle::build_light( var_2, "headlights_cheap_headlight_L_cheap", "TAG_HEADLIGHT_LEFT", "vfx/lights/headlight_gaz_cheap", "headlights_cheap", 0.0 );
    maps\_vehicle::build_light( var_2, "headlights_cheap_headlight_R_cheap", "TAG_HEADLIGHT_RIGHT", "vfx/lights/headlight_gaz_cheap", "headlights_cheap", 0.0 );
    maps\_vehicle::build_light( var_2, "headlights_cheap_brakelight_L_cheap", "TAG_BRAKELIGHT_LEFT", "vfx/lights/taillight_gaz_cheap", "headlights_cheap", 0.0 );
    maps\_vehicle::build_light( var_2, "headlights_cheap_brakelight_R_cheap", "TAG_BRAKELIGHT_RIGHT", "vfx/lights/taillight_gaz_cheap", "headlights_cheap", 0.0 );
    maps\_vehicle::build_light( var_2, "taillights_cheap_headlight_L_cheap", "TAG_HEADLIGHT_LEFT", "vfx/lights/headlight_gaz", "taillights_cheap", 0.0 );
    maps\_vehicle::build_light( var_2, "taillights_cheap_headlight_R_cheap", "TAG_HEADLIGHT_RIGHT", "vfx/lights/headlight_gaz", "taillights_cheap", 0.0 );
    maps\_vehicle::build_light( var_2, "taillights_cheap_brakelight_L_cheap", "TAG_BRAKELIGHT_LEFT", "vfx/lights/taillight_gaz_cheap", "taillights_cheap", 0.0 );
    maps\_vehicle::build_light( var_2, "taillights_cheap_brakelight_R_cheap", "TAG_BRAKELIGHT_RIGHT", "vfx/lights/taillight_gaz_cheap", "taillights_cheap", 0.0 );
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
    var_0[var_1][var_0[var_1].size] = 2;
    var_0[var_1][var_0[var_1].size] = 3;
    var_1 = "all_but_gunner";
    var_0[var_1] = [];
    var_0[var_1][var_0[var_1].size] = 0;
    var_0[var_1][var_0[var_1].size] = 1;
    var_0[var_1][var_0[var_1].size] = 2;
    var_1 = "rear_driver_side";
    var_0[var_1] = [];
    var_0[var_1][var_0[var_1].size] = 2;
    var_1 = "all";
    var_0[var_1] = [];
    var_0[var_1][var_0[var_1].size] = 0;
    var_0[var_1][var_0[var_1].size] = 1;
    var_0[var_1][var_0[var_1].size] = 2;
    var_0[var_1][var_0[var_1].size] = 3;
    var_0["default"] = var_0["all"];
    return var_0;
}

build_gaz_death( var_0 )
{
    level._effect["gazfire"] = loadfx( "vfx/fire/fire_lp_s_no_light" );
    level._effect["gazexplode"] = loadfx( "vfx/explosion/vehicle_civ_ai_explo_lrg_runner" );
    level._effect["gazsmfire"] = loadfx( "vfx/fire/fire_lp_xs_no_light" );
    maps\_vehicle::build_deathmodel( "vehicle_gaz_tigr_harbor", "vehicle_gaz_tigr_harbor_destroyed" );
    maps\_vehicle::build_deathmodel( "vehicle_gaz_tigr_base", "vehicle_gaz_tigr_harbor_destroyed" );
    maps\_vehicle::build_deathmodel( "vehicle_mil_gaz_ai", "vehicle_mil_gaz_dstrypv" );
    maps\_vehicle::build_deathmodel( "vehicle_mil_humvee_north_korean_01_ai", "vehicle_gaz_tigr_harbor_destroyed" );

    if ( var_0 != "script_vehicle_gaz_tigr_cleanup" && var_0 != "script_vehicle_gaz_tigr_cleanup_phys" )
    {
        maps\_vehicle::build_deathfx( "vfx/explosion/vehicle_civ_ai_explo_lrg_runner", "tag_death_fx", "veh_gaz_expl_3d" );
        maps\_vehicle::build_deathfx( "vfx/fire/fire_lp_s_no_light", "tag_cab_fx", undefined, undefined, undefined, 1, 0 );
        maps\_vehicle::build_deathfx( "vfx/fire/firelp_small", "tag_trunk_fx", undefined, undefined, undefined, 1, 3 );
    }

    maps\_vehicle::build_deathquake( 1, 1.6, 500 );

    if ( var_0 != "script_vehicle_gaz_tigr_turret_physics_factory" )
        maps\_vehicle::build_radiusdamage( ( 0, 0, 32 ), 300, 200, 0, 0 );
}

set_vehicle_anims( var_0 )
{
    var_0[0].vehicle_getoutanim = %gaz_dismount_frontl_door;
    var_0[1].vehicle_getoutanim = %gaz_dismount_frontr_door;
    var_0[2].vehicle_getoutanim = %gaz_dismount_backl_door;
    var_0[3].vehicle_getoutanim = %gaz_dismount_backr_door;
    var_0[0].vehicle_getinanim = %gaz_mount_frontl_door;
    var_0[1].vehicle_getinanim = %gaz_mount_frontr_door;
    var_0[2].vehicle_getinanim = %gaz_enter_back_door;
    var_0[3].vehicle_getinanim = %gaz_enter_back_door;
    var_0[0].vehicle_getoutsound = "gaz_door_open";
    var_0[1].vehicle_getoutsound = "gaz_door_open";
    var_0[2].vehicle_getoutsound = "gaz_door_open";
    var_0[3].vehicle_getoutsound = "gaz_door_open";
    var_0[0].vehicle_getinsound = "gaz_door_close";
    var_0[1].vehicle_getinsound = "gaz_door_close";
    var_0[2].vehicle_getinsound = "gaz_door_close";
    var_0[3].vehicle_getinsound = "gaz_door_close";
    return var_0;
}

set_vehicle_anims_turret( var_0 )
{
    var_0 = set_vehicle_anims( var_0 );
    var_0[3].vehicle_getoutanim = %gaz_turret_getout_gaz;
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
    var_0[2].sittag = "tag_guy0";
    var_0[3].sittag = "tag_guy1";
    var_0[0].bhasgunwhileriding = 0;
    var_0[0].death = %gaz_dismount_frontl;
    var_0[0].death_delayed_ragdoll = 3;
    var_0[0].idle = %gaz_idle_frontl;
    var_0[1].idle = %gaz_idle_frontr;
    var_0[2].idle = %gaz_idle_backl;
    var_0[3].idle = %gaz_idle_backr;
    var_0[0].getout = %gaz_dismount_frontl;
    var_0[1].getout = %gaz_dismount_frontr;
    var_0[2].getout = %gaz_dismount_backl;
    var_0[3].getout = %gaz_dismount_backr;
    var_0[0].getin = %gaz_mount_frontl;
    var_0[1].getin = %gaz_mount_frontr;
    var_0[2].getin = %gaz_enter_backr;
    var_0[3].getin = %gaz_enter_backl;
    var_0[0].death_flop_dir = ( 0, 2500, 0 );
    var_0[1].death_flop_dir = ( 0, -2500, 0 );
    var_0[2].death_flop_dir = ( 0, 2500, 0 );
    var_0[3].death_flop_dir = ( 0, -2500, 0 );
    var_0[0].min_unload_frac_to_flop = undefined;
    var_0[1].min_unload_frac_to_flop = undefined;
    var_0[2].min_unload_frac_to_flop = 0.6;
    var_0[3].min_unload_frac_to_flop = 0.45;
    return var_0;
}

setanims_turret()
{
    var_0 = setanims();
    var_1 = 0;

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3.getout ) )
        {
            var_4 = getanimlength( var_3.getout );

            if ( var_4 > var_1 )
                var_1 = var_4;
        }
    }

    var_0[3].mgturret = 0;
    var_0[3].passenger_2_turret_func = ::gaz_turret_guy_gettin_func;
    var_0[3].sittag = "tag_guy_turret";
    var_0[3].getout = %gaz_turret_getout_guy1;
    var_0[3].delay = var_1;
    return var_0;
}

gaz_turret_guy_gettin_func( var_0, var_1, var_2, var_3 )
{

}
