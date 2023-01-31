// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("vehicles");

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "vrap_base", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_unload_groups( ::unload_groups );
    maps\_vehicle::build_drive( %humvee_50cal_driving_idle_forward, %humvee_50cal_driving_idle_backward, 10 );
    maps\_vehicle::build_treadfx();
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_team( "axis" );

    if ( issubstr( var_2, "turret" ) )
    {
        maps\_vehicle::build_aianims( ::setanims_turret, ::set_vehicle_anims );
        maps\_vehicle::build_turret( "vrap_turret", "tag_turret", "weapon_vrap_turret", undefined, "auto_nonai", 0.2, 10, -14 );
    }
    else
        maps\_vehicle::build_aianims( ::setanims, ::set_vehicle_anims );

    build_vrap_death( var_2 );
    maps\_vehicle::build_light( var_2, "headlight_L", "TAG_HEADLIGHT_LEFT", "vfx/lights/headlight_gaz_bright", "running", 0.0 );
    maps\_vehicle::build_light( var_2, "headlight_R", "TAG_HEADLIGHT_RIGHT", "vfx/lights/headlight_gaz_bright", "running", 0.0 );
    maps\_vehicle::build_light( var_2, "brakelight_L", "TAG_BRAKELIGHT_LEFT", "vfx/lights/taillight_gaz", "running", 0.0 );
    maps\_vehicle::build_light( var_2, "brakelight_R", "TAG_BRAKELIGHT_RIGHT", "vfx/lights/taillight_gaz", "running", 0.0 );
    maps\_vehicle::build_light( var_2, "headlight_L", "TAG_HEADLIGHT_LEFT", "vfx/lights/headlight_gaz_bright", "headlights", 0.0 );
    maps\_vehicle::build_light( var_2, "headlight_R", "TAG_HEADLIGHT_RIGHT", "vfx/lights/headlight_gaz_bright", "headlights", 0.0 );
    maps\_vehicle::build_light( var_2, "brakelight_L", "TAG_BRAKELIGHT_LEFT", "vfx/lights/taillight_gaz", "headlights", 0.0 );
    maps\_vehicle::build_light( var_2, "brakelight_R", "TAG_BRAKELIGHT_RIGHT", "vfx/lights/taillight_gaz", "headlights", 0.0 );
    maps\_vehicle::build_deathfx( "vfx/explosion/vehicle_civ_ai_explo_lrg_runner", "TAG_DEATH_FX" );
}

init_local()
{
    soundscripts\_snd::snd_message( "vrap_spawn", self );
    soundscripts\_snd::snd_message( "vrap_explode" );
    self.playermech_rocket_targeting_allowed = 1;
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

build_vrap_death( var_0 )
{
    maps\_vehicle::build_deathmodel( "vehicle_mil_humvee", "vehicle_atlas_humvee_dstrypv" );
    maps\_vehicle::build_deathquake( 1, 1.6, 500 );
    maps\_vehicle::build_radiusdamage( ( 0, 0, 32 ), 300, 200, 0, 0 );
}

set_vehicle_anims( var_0 )
{
    var_0[0].vehicle_getoutanim = %mil_humvee_vrap_driver_out_door;
    var_0[1].vehicle_getoutanim = %mil_humvee_vrap_passenger_out_door;
    var_0[2].vehicle_getoutanim = %gaz_dismount_backl_door;
    var_0[3].vehicle_getoutanim = %gaz_dismount_backr_door;
    var_0[0].vehicle_getinanim = %mil_humvee_vrap_driver_in_m_door;
    var_0[1].vehicle_getinanim = %mil_humvee_vrap_passenger_in_m_door;
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
    var_0[0].idle = %mil_humvee_vrap_driver_idle;
    var_0[1].idle = %mil_humvee_vrap_passenger_idle;
    var_0[2].idle = %gaz_idle_backl;
    var_0[3].idle = %gaz_idle_backr;
    var_0[0].getout = %mil_humvee_vrap_driver_out;
    var_0[1].getout = %mil_humvee_vrap_passenger_out;
    var_0[2].getout = %gaz_dismount_backl;
    var_0[3].getout = %gaz_dismount_backr;
    var_0[0].getin = %mil_humvee_vrap_driver_in_m;
    var_0[1].getin = %mil_humvee_vrap_passenger_in_m;
    var_0[2].getin = %gaz_enter_backr;
    var_0[3].getin = %gaz_enter_backl;
    var_0[0].death_flop_dir = ( 0, 2500, 0 );
    var_0[1].death_flop_dir = ( 0, -2500, 0 );
    var_0[2].death_flop_dir = ( -2500, 0, 0 );
    var_0[3].death_flop_dir = ( -2500, 0, 0 );
    var_0[0].min_unload_frac_to_flop = undefined;
    var_0[1].min_unload_frac_to_flop = undefined;
    var_0[2].min_unload_frac_to_flop = 0.6;
    var_0[3].min_unload_frac_to_flop = 0.45;
    return var_0;
}

setanims_turret()
{
    var_0 = setanims();
    var_0[3].mgturret = 0;
    var_0[3].passenger_2_turret_func = ::gaz_turret_guy_gettin_func;
    var_0[3].sittag = "tag_guy_turret";
    return var_0;
}

gaz_turret_guy_gettin_func( var_0, var_1, var_2, var_3 )
{

}
