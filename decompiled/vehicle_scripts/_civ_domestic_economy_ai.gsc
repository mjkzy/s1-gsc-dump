// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("vehicles");

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "civ_domestic_economy_ai", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_drive( %technical_driving_idle_forward, %technical_driving_idle_backward, 10 );
    maps\_vehicle::build_treadfx( var_2, "default", "vfx/treadfx/tread_dust_default" );
    maps\_vehicle::build_treadfx_script_model( var_2, "default", "vfx/treadfx/tread_dust_sedan_bright" );
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_aianims( ::setanims, ::set_vehicle_anims );
    maps\_vehicle::build_light( var_2, "headlight_set", "tag_origin", "vfx/lights/veh_compact_head_light", "headlights" );
    maps\_vehicle::build_light( var_2, "taillight_scroll_right", "tag_brakelight_right", "vfx/lights/veh_compact_signal_light_back_rt", "taillights" );
    maps\_vehicle::build_light( var_2, "taillight_scroll_left", "tag_brakelight_left", "vfx/lights/veh_compact_signal_light_back_lt", "taillights" );
    maps\_vehicle::build_light( var_2, "frontsignal_right", "tag_headlight_right", "vfx/lights/veh_compact_signal_light_front_rt", "taillights" );
    maps\_vehicle::build_light( var_2, "frontsignal_left", "tag_headlight_left", "vfx/lights/veh_compact_signal_light_front_lt", "taillights" );
    maps\_vehicle::build_light( var_2, "brakelight_set", "tag_origin", "vfx/lights/veh_compact_stop_light", "brakelights" );
    maps\_vehicle::build_deathmodel( "vehicle_civ_domestic_economy_ai", "vehicle_civ_domestic_economy_dstrypv", 0 );
    maps\_vehicle::build_deathmodel( "vehicle_civ_domestic_economy_clr02_ai", "vehicle_civ_domestic_economy_dstrypv", 0 );
    maps\_vehicle::build_deathmodel( "vehicle_civ_domestic_economy_clr03_ai", "vehicle_civ_domestic_economy_dstrypv", 0 );
    maps\_vehicle::build_deathmodel( "vehicle_civ_domestic_economy_clr04_ai", "vehicle_civ_domestic_economy_dstrypv", 0 );
    maps\_vehicle::build_deathmodel( "vehicle_civ_domestic_economy_clr05_ai", "vehicle_civ_domestic_economy_dstrypv", 0 );
    maps\_vehicle::build_deathmodel( "vehicle_civ_domestic_economy_clr06_ai", "vehicle_civ_domestic_economy_dstrypv", 0 );
    maps\_vehicle::build_deathfx( "vfx/explosion/vehicle_civ_ai_explo_small_runner", "TAG_DEATH_FX", "lag_rndabt_car_small_explo", undefined, undefined, undefined, 0 );
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
    var_0[0].idle = %humvee_idle_frontl;
    return var_0;
}
