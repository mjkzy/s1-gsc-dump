// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("vehicles");

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "ind_semi_truck_fuel_tanker", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_drive( %technical_driving_idle_forward, %technical_driving_idle_backward, 10 );
    maps\_vehicle::build_treadfx( var_2, "default", "vfx/treadfx/tread_dust_default" );
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_aianims( ::setanims, ::set_vehicle_anims );
    maps\_vehicle::build_light( var_2, "headlight_left", "tag_headlight_left", "vfx/lights/veh_default_front_signal_light_l", "headlights" );
    maps\_vehicle::build_light( var_2, "headlight_right", "tag_headlight_right", "vfx/lights/veh_default_front_signal_light_r", "headlights" );
    maps\_vehicle::build_light( var_2, "taillight_right", "tag_brakelight_right", "vfx/lights/veh_default_tail_light_r", "taillights" );
    maps\_vehicle::build_light( var_2, "taillight_left", "tag_brakelight_left", "vfx/lights/veh_default_tail_light_l", "taillights" );
    maps\_vehicle::build_deathfx( "vfx/explosion/vehicle_generic_ai_explo_lrg_runner", "TAG_DEATH_FX", undefined, undefined, undefined, undefined, 0 );
}

init_local()
{
    soundscripts\_snd::snd_message( "atlas_van_explode" );
}

set_vehicle_anims( var_0 )
{
    return var_0;
}

setanims()
{
    var_0 = [];
    return var_0;
    return var_0;
}
