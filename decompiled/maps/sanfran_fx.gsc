// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    precachefx();
    maps\createfx\sanfran_fx::main();

    if ( !isdefined( level.createfxent ) )
        level.createfxent = [];

    set_reactive_motion_values();
    maps\_shg_fx::setup_shg_fx();
    precacheshader( "overlay_static_digital" );
    common_scripts\utility::flag_init( "fx_pitbull_mud_spray" );
    thread maps\_shg_fx::fx_zone_watcher( 1000, "msg_vfx_zone1_tunnel" );
    thread maps\_shg_fx::fx_zone_watcher( 2000, "msg_vfx_zone2_driving_chase" );
    thread maps\_shg_fx::fx_zone_watcher( 3000, "msg_vfx_zone3_bridge_on_foot" );
    thread maps\_shg_fx::fx_zone_watcher( 4000, "msg_vfx_zone4_collapse" );
    thread cop_car_lights_on();
    thread vfx_bridge_fog_on();
    thread vfx_bridge_seagulls_on();
    thread vfx_bridge_traffic_intro();
    thread pause_bigmoment_vfx();
    thread flares_during_standoff();
    thread vfx_pitbull_mud_spray();
    thread treadfx_override();
}

set_reactive_motion_values()
{
    setsaveddvar( "r_reactiveMotionWindAmplitudeScale", "0.3" );
}

precachefx()
{
    level._effect["tanker_explosion"] = loadfx( "vfx/explosion/vehicle_fireball_explosion_01" );
    level._effect["tanker_burst"] = loadfx( "vfx/explosion/ambient_explosion_fireball" );
    level._effect["stinger_impact"] = loadfx( "vfx/explosion/ambient_explosion_fireball" );
    level._effect["bird_seagull_flock_large"] = loadfx( "vfx/animal/bird_seagull_flock_large" );
    level._effect["sfa_traffic_intro"] = loadfx( "vfx/map/sanfran_a/sfa_traffic_intro" );
    level._effect["flare_ambient"] = loadfx( "vfx/props/flare_ambient" );
    level._effect["fog_distant_vista_dense"] = loadfx( "vfx/fog/fog_distant_vista_dense" );
    level._effect["fog_close_onbridge"] = loadfx( "vfx/fog/fog_close_onbridge" );
    level._effect["fog_distant_aerialview"] = loadfx( "vfx/fog/fog_distant_aerialview" );
    level._effect["fog_over_hill_slow"] = loadfx( "vfx/fog/fog_over_hill_slow" );
    level._effect["car_contact_spark_lrg"] = loadfx( "vfx/vehiclecollision/veh_collision_sparks" );
    level._effect["car_contact_asphalt_lrg"] = loadfx( "vfx/vehiclecollision/veh_collision_asphalt" );
    level._effect["car_contact_asphalt_a"] = loadfx( "vfx/vehiclecollision/veh_collision_asphalt_a" );
    level._effect["car_contact_concrete_lrg"] = loadfx( "vfx/vehiclecollision/veh_collision_concrete" );
    level._effect["car_contact_dirt_lrg"] = loadfx( "vfx/vehiclecollision/veh_collision_dirt" );
    level._effect["car_contact_spark_med"] = loadfx( "vfx/vehiclecollision/veh_collision_sparks_med" );
    level._effect["car_contact_asphalt_med"] = loadfx( "vfx/vehiclecollision/veh_collision_asphalt_med" );
    level._effect["car_contact_concrete_med"] = loadfx( "vfx/vehiclecollision/veh_collision_concrete_med" );
    level._effect["car_contact_dirt_med"] = loadfx( "vfx/vehiclecollision/veh_collision_dirt_med" );
    level._effect["car_contact_asphalt_sml"] = loadfx( "vfx/vehiclecollision/veh_collision_asphalt_sml" );
    level._effect["car_contact_concrete_sml"] = loadfx( "vfx/vehiclecollision/veh_collision_concrete_sml" );
    level._effect["car_contact_dirt_sml"] = loadfx( "vfx/vehiclecollision/veh_collision_dirt_sml" );
    level._effect["car_contact_spark_sml"] = loadfx( "vfx/vehiclecollision/veh_collision_sparks_sml" );
    level._effect["light_sedan_police_scroll"] = loadfx( "vfx/lights/light_sedan_police_scroll" );
    level._effect["lt_pt_pitbull_lft"] = loadfx( "vfx/lights/lt_pt_pitbull_lft" );
    level._effect["lt_pt_pitbull_rim"] = loadfx( "vfx/lights/lt_pt_pitbull_rim" );
    level._effect["lt_pt_pitbull_hud"] = loadfx( "vfx/lights/lt_pt_pitbull_hud" );
    level._effect["lt_pt_tunnel_car_pass"] = loadfx( "vfx/lights/lt_pt_tunnel_car_pass" );
    level._effect["sunflare"] = loadfx( "vfx/lights/sanfran_a/sunflare" );
    level._effect["cutter_ignite_light"] = loadfx( "vfx/lights/sanfran_a/lt_pt_van_cutter" );
    level._effect["headlight_gaz"] = loadfx( "vfx/lights/headlight_gaz" );
    level._effect["light_sanfran_streetlight_flare"] = loadfx( "vfx/lights/sanfran_a/light_sanfran_streetlight_flare" );
    level._effect["sanfran_sunflare_a"] = loadfx( "vfx/lensflare/sanfran/sanfran_sunflare_a" );
    level._effect["tunnel_light_flare_sanfran"] = loadfx( "vfx/lensflare/sanfran/tunnel_light_flare_sanfran" );
    level._effect["light_sanfran_tunnel_hazy"] = loadfx( "vfx/lights/sanfran_a/light_sanfran_tunnel_hazy" );
    level._effect["tunnelExit_light_sunflare_sanfran"] = loadfx( "vfx/lensflare/sanfran/tunnelExit_light_sunflare_sanfran" );
    level._effect["light_sanfran_pitbull_headlight"] = loadfx( "vfx/lights/sanfran_a/light_sanfran_pitbull_headlight" );
    level._effect["light_sanfran_pitbull_taillight"] = loadfx( "vfx/lights/sanfran_a/light_sanfran_pitbull_taillight" );
    level._effect["plastic_bag_01_blowing"] = loadfx( "vfx/wind/plastic_bag_01_blowing" );
    level._effect["plastic_bag_blowing_runner_lp"] = loadfx( "vfx/wind/plastic_bag_blowing_runner_lp" );
    level._effect["wind_blowing_debris"] = loadfx( "vfx/wind/wind_blowing_debris" );
    level._effect["smoldering_smk_direction_fast_s"] = loadfx( "vfx/smoke/smoldering_smk_direction_fast_s" );
    level._effect["smoldering_smk_direction_fast_m"] = loadfx( "vfx/smoke/smoldering_smk_direction_fast_m" );
    level._effect["smoldering_smk_direction_fast_m_shadow"] = loadfx( "vfx/smoke/smoldering_smk_direction_fast_m_shadow" );
    level._effect["fire_lp_l_blacksmk_thick_nonlit"] = loadfx( "vfx/fire/fire_lp_l_blacksmk_thick_nonlit" );
    level._effect["fireball_lp_smk_xlrg_tall_nonlit"] = loadfx( "vfx/fire/fireball_lp_smk_xlrg_tall_nonlit" );
    level._effect["sfa_oil_spill_fire_lp_low"] = loadfx( "vfx/map/sanfran_a/sfa_oil_spill_fire_lp_low" );
    level._effect["fire_vehicle_interior_small_1"] = loadfx( "vfx/fire/vehicle_fire_interior_small_1" );
    level._effect["fire_vehicle_interior_small_2"] = loadfx( "vfx/fire/vehicle_fire_interior_small_2" );
    level._effect["fire_vehicle_interior_small_3"] = loadfx( "vfx/fire/vehicle_fire_interior_small_3" );
    level._effect["fire_vehicle_interior_small_4"] = loadfx( "vfx/fire/vehicle_fire_interior_small_4" );
    level._effect["fire_vehicle_debris_small_1"] = loadfx( "vfx/map/sanfran_a/sfa_fire_debris_1_wind_sm" );
    level._effect["fire_vehicle_debris_small_2"] = loadfx( "vfx/map/sanfran_a/sfa_fire_debris_2_wind_sm" );
    level._effect["fire_vehicle_damage_smoke_1"] = loadfx( "vfx/map/sanfran_a/sfa_vehicle_engine_damage_smoke_1" );
    level._effect["sparks_vehicle_small_1"] = loadfx( "vfx/map/sanfran_a/sfa_vehicle_sparks_runner" );
    level._effect["pitbull_suv_impact"] = loadfx( "vfx/map/sanfran_a/sfa_pitbull_suv_impact" );
    level._effect["atlas_suv_explosion"] = loadfx( "vfx/destructible/veh_atlas_suv_explo_no_parts" );
    level._effect["pitbull_suv_impact_concrete"] = loadfx( "vfx/map/sanfran_a/sfa_pitbull_suv_impact_concrete" );
    level._effect["atlas_suv_mud_spray_bk_rt"] = loadfx( "vfx/map/sanfran_a/sfa_atlas_suv_mud_spray_bk_rt" );
    level._effect["atlas_suv_mud_spray_bk_lt"] = loadfx( "vfx/map/sanfran_a/sfa_atlas_suv_mud_spray_bk_lt" );
    level._effect["atlas_suv_mud_decal"] = loadfx( "vfx/map/sanfran_a/sfa_atlas_suv_mud_decal" );
    level._effect["atlas_suv_wheel_smk"] = loadfx( "vfx/map/sanfran_a/sfa_pitbull_suv_wheel_smk" );
    level._effect["car_window_shatter_01"] = loadfx( "vfx/glass/car_window_shatter_01" );
    level._effect["pitbull_skid_sparks"] = loadfx( "vfx/map/sanfran_a/pitbull_skid_sparks" );
    level._effect["sfa_pitbull_skid_stop_smoke"] = loadfx( "vfx/map/sanfran_a/sfa_pitbull_skid_stop_smoke" );
    level._effect["sfa_pitbull_crash_smoke"] = loadfx( "vfx/map/sanfran_a/sfa_pitbull_crash_smoke" );
    level._effect["atlas_suv_wheel_smk2"] = loadfx( "vfx/map/sanfran_a/sfa_pitbull_suv_wheel_smk2" );
    level._effect["pitbull_suv_impact2"] = loadfx( "vfx/map/sanfran_a/sfa_pitbull_suv_impact2" );
    level._effect["sfa_pitbull_incabin_flip_debris"] = loadfx( "vfx/map/sanfran_a/sfa_pitbull_incabin_flip_debris" );
    level._effect["burke_blood_spit"] = loadfx( "vfx/blood/blood_spit" );
    level._effect["blood_drip_sml_runner"] = loadfx( "vfx/blood/blood_drip_sml_runner" );
    level._effect["sfa_pitbull_flip_rail_impact"] = loadfx( "vfx/map/sanfran_a/sfa_pitbull_flip_rail_impact" );
    level._effect["gate_crash_dust"] = loadfx( "vfx/map/sanfran_a/sfa_gate_crash_dust" );
    level._effect["pitbull_gate_sparks"] = loadfx( "vfx/map/sanfran_a/sfa_pitbull_gate_sparks" );
    level._effect["pitbull_mud_spray"] = loadfx( "vfx/map/sanfran_a/sfa_pitbull_mud_spray" );
    level._effect["light_drone_beacon_red"] = loadfx( "vfx/lights/light_drone_beacon_red" );
    level._effect["drone_fan_distortion"] = loadfx( "vfx/distortion/drone_fan_distortion" );
    level._effect["drone_fan_distortion_large"] = loadfx( "vfx/distortion/drone_fan_distortion_large" );
    level._effect["drone_thruster_distortion"] = loadfx( "vfx/distortion/drone_thruster_distortion" );
    level._effect["boat_wake_vehicle_naval_littoral"] = loadfx( "vfx/treadfx/boat_wake_vehicle_naval_littoral" );
    level._effect["boat_wake_iw6_vehicle_lcs"] = loadfx( "vfx/treadfx/boat_wake_iw6_vehicle_lcs" );
    level._effect["boat_wake_vehicle_burke02"] = loadfx( "vfx/treadfx/boat_wake_vehicle_burke02" );
    level._effect["boat_wake_vehicle_san_antonio"] = loadfx( "vfx/treadfx/boat_wake_vehicle_san_antonio" );
    level._effect["boat_wake_vehicle_cvn_carrier"] = loadfx( "vfx/treadfx/boat_wake_vehicle_cvn_carrier" );
    level._effect["boat_wake_vehicle_atlas_decoy_cargo_ship"] = loadfx( "vfx/treadfx/boat_wake_vehicle_atlas_decoy_cargo_ship" );
    level._effect["boat_wake_vehicle_atlas_decoy_cargo_ship_side"] = loadfx( "vfx/treadfx/boat_wake_vehicle_atlas_decoy_cargo_ship_s" );
    level._effect["boat_wake_vehicle_mob"] = loadfx( "vfx/treadfx/boat_wake_vehicle_mob" );
    level._effect["veh_smartcar_stop_light_blinking"] = loadfx( "vfx/lights/veh_smartcar_stop_light_blinking" );
    level._effect["veh_civ_workvan_stop_light_blinking"] = loadfx( "vfx/lights/veh_civ_workvan_stop_light_blinking" );
    level._effect["veh_compact_stop_light_blinking"] = loadfx( "vfx/lights/veh_compact_stop_light_blinking" );
    level._effect["van_explosion"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_van_explo" );
    level._effect["van_front_door_open"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_vanfrontdoor_open" );
    level._effect["van_back_door_open"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_vanbackdoor_open" );
    level._effect["flesh_impact_body_fatal_exit"] = loadfx( "vfx/weaponimpact/flesh_impact_body_fatal_exit" );
    level._effect["sfa_dust_debris_fall_01"] = loadfx( "vfx/map/sanfran_a/sfa_dust_debris_fall_01" );
    level._effect["sfa_dust_debris_fall_02"] = loadfx( "vfx/map/sanfran_a/sfa_dust_debris_fall_02" );
    level._effect["sfa_dust_debris_fall_03"] = loadfx( "vfx/map/sanfran_a/sfa_dust_debris_fall_03" );
    level._effect["sfa_dust_debris_fall_runner"] = loadfx( "vfx/map/sanfran_a/sfa_dust_debris_fall_runner" );
    level._effect["sfa_bigm_debris_fall"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_debris_fall" );
    level._effect["sfa_bigm_ggb_part1_fall"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_ggb_part1_fall" );
    level._effect["ash_cloud_freq_lrg_loop"] = loadfx( "vfx/ash/ash_cloud_freq_lrg_loop" );
    level._effect["electrical_sparks_runner"] = loadfx( "vfx/explosion/electrical_sparks_runner" );
    level._effect["drone_explosion"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_drones_explo" );
    level._effect["vehicle_pdrone_explosion"] = loadfx( "vfx/explosion/vehicle_pdrone_explosion" );
    level._effect["sfa_bigm_gushingsmk"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_gushingsmk" );
    level._effect["sfa_bigm_van_explo_smk_stack"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_van_explo_smk_stack" );
    level._effect["sfa_bigm_player_hit_car"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_player_hit_car" );
    level._effect["sfa_bigm_falling_dust"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_falling_dust" );
    level._effect["sfa_bigm_heli_slide"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_heli_slide" );
    level._effect["sfa_bigm_copcar_hitspark"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_copcar_hitspark" );
    level._effect["cutter_spark"] = loadfx( "vfx/sparks/small_impact_flash_burst" );
    level._effect["cutter_ignite"] = loadfx( "vfx/unique/lazer_cutter_torch_vm" );
    level._effect["sfa_bigm_obscure_smk_lrg"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_obscure_smk_lrg" );
    level._effect["sfa_bigm_obscure_smk_m"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_obscure_smk_m" );
    level._effect["ambient_explosion_dirt_01"] = loadfx( "vfx/explosion/ambient_explosion_dirt_01" );
    level._effect["vehicle_civ_ai_explo_lrg_runner"] = loadfx( "vfx/explosion/vehicle_civ_ai_explo_lrg_runner" );
    level._effect["vehicle_generic_ai_explo_lrg_runner"] = loadfx( "vfx/explosion/vehicle_generic_ai_explo_lrg_runner" );
    level._effect["ambient_explosion_fireball"] = loadfx( "vfx/explosion/ambient_explosion_fireball" );
    level._effect["sfa_bigm_bus_slide"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_bus_slide" );
    level._effect["sfa_bigm_herocable_glowsmk"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_herocable_glowsmk" );
    level._effect["sfa_bigm_bridge_explo_main"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_bridge_explo_main" );
    level._effect["sfa_bigm_bridge_shake"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_bridge_shake" );
    level._effect["sfa_bigm_grnd_crack_burst"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_grnd_crack_burst" );
    level._effect["sfa_bigm_smk_grnd_linger"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_smk_grnd_linger" );
    level._effect["sfa_bigm_bridge_crackburst_big"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_bridge_crackburst_big" );
    level._effect["sfa_bigm_bridge_mob_explo1"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_bridge_mob_explo1" );
    level._effect["sfa_bigm_bridge_mob_explo1_debris"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_bridge_mob_explo1_debris" );
    level._effect["sfa_bigm_bridge_mob_explo1_burst"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_bridge_mob_explo1_burst" );
    level._effect["sfa_bigm_bridge_mob_explo2"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_bridge_mob_explo2" );
    level._effect["sfa_bigm_debrisfall_onchunk_lrg"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_debrisfall_onchunk_lrg" );
    level._effect["sfa_bigm_debrisfall_onchunk_sm"] = loadfx( "vfx/map/sanfran_a/sfa_bigm_debrisfall_onchunk_sm" );
    level._effect["dust_rolling_pebbles_runner"] = loadfx( "vfx/dust/dust_rolling_pebbles_runner" );
    level._effect["dust_rolling_pebbles_runner_lrg"] = loadfx( "vfx/dust/dust_rolling_pebbles_runner_lrg" );
    level._effect["dust_rolling_pebbles_runner_vm"] = loadfx( "vfx/dust/dust_rolling_pebbles_runner_vm" );
    level._effect["sfa_oil_tanker_fire_leak"] = loadfx( "vfx/map/sanfran_a/sfa_oil_tanker_fire_leak" );
    level._effect["sfa_oil_tanker_wheel_smk"] = loadfx( "vfx/map/sanfran_a/sfa_oil_tanker_wheel_smk" );
    level._effect["sfa_oil_tanker_skid_impact"] = loadfx( "vfx/map/sanfran_a/sfa_oil_tanker_skid_impact" );
    level._effect["sfa_barrier_concrete_impact_large"] = loadfx( "vfx/map/sanfran_a/sfa_barrier_concrete_impact_large" );
    level._effect["sfa_barrier_concrete_impact_med"] = loadfx( "vfx/map/sanfran_a/sfa_barrier_concrete_impact_med" );
    level._effect["sfa_oil_tanker_spark_burst_single"] = loadfx( "vfx/map/sanfran_a/sfa_oil_tanker_spark_burst_single" );
    level._effect["sfa_oil_tanker_spark_burst_single_decal"] = loadfx( "vfx/map/sanfran_a/sfa_oil_tanker_spark_burst_single_decal" );
    level._effect["sfa_oil_tanker_wheel_skid_runner"] = loadfx( "vfx/map/sanfran_a/sfa_oil_tanker_wheel_skid_runner" );
    level._effect["sfa_oil_tanker_impact_decal_runner"] = loadfx( "vfx/map/sanfran_a/sfa_oil_tanker_impact_decal_runner" );
    level._effect["sfa_oil_tanker_explosion"] = loadfx( "vfx/map/sanfran_a/sfa_oil_tanker_explosion" );
    level._effect["sfa_fire_stream_trail_single"] = loadfx( "vfx/map/sanfran_a/sfa_fire_stream_trail_single" );
    level._effect["sfa_oil_tanker_fire_stream_med"] = loadfx( "vfx/map/sanfran_a/sfa_oil_tanker_fire_stream_med" );
    level._effect["sfa_oil_tanker_single_fire_lp"] = loadfx( "vfx/map/sanfran_a/sfa_oil_tanker_fire_lp" );
    level._effect["sfa_tanker_bridge_explosion"] = loadfx( "vfx/map/sanfran_a/sfa_tanker_bridge_explosion" );
    level._effect["sfa_tanker_bridge_fire_ignite"] = loadfx( "vfx/map/sanfran_a/sfa_tanker_bridge_fire_ignite" );
    level._effect["sfa_oil_spill_fire_lp_low"] = loadfx( "vfx/map/sanfran_a/sfa_oil_spill_fire_lp_low" );
    level._effect["sfa_oil_spill_fire_low_single"] = loadfx( "vfx/map/sanfran_a/sfa_oil_spill_fire_low_single" );
    level._effect["sfa_oil_spill_fire_lp_mid"] = loadfx( "vfx/map/sanfran_a/sfa_oil_spill_fire_lp_mid" );
    level._effect["sfa_oil_spill_fire_lp_tall"] = loadfx( "vfx/map/sanfran_a/sfa_oil_spill_fire_lp_tall" );
    level._effect["sfa_oil_spill_fire_lp_tall_smk"] = loadfx( "vfx/map/sanfran_a/sfa_oil_spill_fire_lp_tall_smk" );
    level._effect["sfa_oil_spill_fire_tall_single"] = loadfx( "vfx/map/sanfran_a/sfa_oil_spill_fire_tall_single" );
    level._effect["sfa_oil_spill_fire_edge_lp"] = loadfx( "vfx/map/sanfran_a/sfa_oil_spill_fire_edge_lp" );
    level._effect["sfa_shockwave_single"] = loadfx( "vfx/map/sanfran_a/sfa_shockwave_single" );
    level._effect["sfa_shockwave_child"] = loadfx( "vfx/map/sanfran_a/sfa_shockwave_child" );
    level._effect["emt_road_flare_burn"] = loadfx( "vfx/props/flare_ambient" );
    level._effect["emt_road_flare_burn_no_light"] = loadfx( "vfx/props/flare_ambient_no_light" );
    level._effect["burke_point_rim"] = loadfx( "vfx/lights/sanfran_a/burke_point_rim" );
}

treadfx_override()
{
    waittillframeend;
    var_0[0] = "script_vehicle_littlebird_sentinel_bench";
    level.treadfx_maxheight = 2000;
    var_1 = "vfx/treadfx/heli_dust_default";
    var_2 = "vfx/unique/no_fx";

    foreach ( var_4 in var_0 )
    {
        maps\_vehicle::set_vehicle_effect( var_4, "brick", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "bark", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "carpet", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "cloth", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "concrete", var_1 );
        maps\_vehicle::set_vehicle_effect( var_4, "dirt", var_1 );
        maps\_vehicle::set_vehicle_effect( var_4, "flesh", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "foliage", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "glass", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "grass", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "gravel", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "ice", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "metal", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "mud", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "paper", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "plaster", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "rock", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "sand", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "snow", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "water", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "wood", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "asphalt", var_1 );
        maps\_vehicle::set_vehicle_effect( var_4, "ceramic", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "plastic", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "rubber", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "cushion", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "fruit", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "paintedmetal", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "riotshield", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "slush", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "default", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "none" );
    }
}

vfx_bridge_fog_on()
{
    common_scripts\utility::flag_wait( "msg_vfx_zone2_driving_chase" );
    common_scripts\_exploder::exploder( 200 );
    common_scripts\_exploder::exploder( 100 );
    common_scripts\_exploder::exploder( 50 );
    thread kill_intro_vfx();
}

kill_intro_vfx()
{
    foreach ( var_1 in level.createfxent )
    {
        if ( var_1.v["type"] == "oneshotfx" )
            var_1 common_scripts\utility::pauseeffect();
    }

    common_scripts\_exploder::exploder( 1000 );
    wait 0.01;
    common_scripts\_exploder::exploder( 1100 );
}

vfx_bridge_seagulls_on()
{
    wait 0.05;
    common_scripts\_exploder::exploder( 700 );
}

vfx_bridge_traffic_intro()
{
    var_0 = spawnfx( common_scripts\utility::getfx( "sfa_traffic_intro" ), ( -35610.8, 71879.8, 265 ), anglestoforward( ( 270, 90, 0 ) ), anglestoup( ( 270, 90, 0 ) ) );
    triggerfx( var_0, -25 );
    var_1 = spawnfx( common_scripts\utility::getfx( "sfa_traffic_intro" ), ( 15712.5, 72408.1, 235 ), anglestoforward( ( 270, -90, 0 ) ), anglestoup( ( 270, -90, 0 ) ) );
    triggerfx( var_1, -25 );
    common_scripts\utility::flag_wait( "msg_vfx_zone2_driving_chase" );
    var_0 delete();
    var_1 delete();
}

traffic_fx_init()
{
    thread traffic_damage_part_watcher();
}

traffic_collision_hit_func( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = length( var_4 );
    var_7 = [];
    var_7["none"] = common_scripts\utility::getfx( "car_contact_spark_sml" );
    var_7["asphalt"] = common_scripts\utility::getfx( "car_contact_asphalt_sml" );
    var_7["concrete"] = common_scripts\utility::getfx( "car_contact_concrete_sml" );
    var_7["dirt"] = common_scripts\utility::getfx( "car_contact_dirt_sml" );
    var_8 = [];
    var_8["none"] = common_scripts\utility::getfx( "car_contact_spark_med" );
    var_8["bark"] = common_scripts\utility::getfx( "car_contact_spark_med" );
    var_8["brick"] = common_scripts\utility::getfx( "car_contact_spark_med" );
    var_8["asphalt"] = common_scripts\utility::getfx( "car_contact_asphalt_med" );
    var_8["concrete"] = common_scripts\utility::getfx( "car_contact_concrete_med" );
    var_8["dirt"] = common_scripts\utility::getfx( "car_contact_dirt_med" );
    var_9 = [];
    var_9["none"] = common_scripts\utility::getfx( "car_contact_spark_lrg" );
    var_9["bark"] = common_scripts\utility::getfx( "car_contact_spark_lrg" );
    var_9["brick"] = common_scripts\utility::getfx( "car_contact_spark_lrg" );
    var_9["asphalt"] = common_scripts\utility::getfx( "car_contact_asphalt_lrg" );
    var_9["concrete"] = common_scripts\utility::getfx( "car_contact_concrete_lrg" );
    var_9["dirt"] = common_scripts\utility::getfx( "car_contact_dirt_lrg" );

    if ( var_6 > 1100 )
    {
        if ( isdefined( var_5 ) && isdefined( var_9[var_5] ) )
            playfx( var_9[var_5], var_2 );
        else
            playfx( common_scripts\utility::getfx( "car_contact_spark_lrg" ), var_2 );
    }

    if ( var_6 > 600 )
    {
        if ( isdefined( var_5 ) && isdefined( var_8[var_5] ) )
            playfx( var_8[var_5], var_2 );
        else
            playfx( common_scripts\utility::getfx( "car_contact_spark_med" ), var_2 );
    }
    else if ( var_6 > 300 )
    {
        if ( isdefined( var_5 ) && isdefined( var_7[var_5] ) )
            playfx( var_7[var_5], var_2 );
        else
            playfx( common_scripts\utility::getfx( "car_contact_spark_sml" ), var_2 );
    }
}

traffic_damage_part_watcher()
{
    level endon( "stop_traffic" );

    for (;;)
        level waittill( "vehicle_part_damage", var_0, var_1 );
}

vfx_gate_crash_open()
{
    common_scripts\_exploder::exploder( "fx_gate_crash_open" );
    var_0 = level.player_pitbull;
    playfxontag( common_scripts\utility::getfx( "pitbull_gate_sparks" ), var_0, "tag_origin" );
}

tanker_skid_impacts( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "sfa_oil_tanker_wheel_smk" ), var_0, "tag_wheel_front_right" );
    playfxontag( common_scripts\utility::getfx( "sfa_oil_tanker_wheel_smk" ), var_0, "tag_wheel_middle_right" );
    playfxontag( common_scripts\utility::getfx( "sfa_oil_tanker_wheel_smk" ), var_0, "tag_wheel_back_right" );
    maps\_utility::delaythread( 0.15, common_scripts\_exploder::exploder, 2002 );
    maps\_utility::delaythread( 0.35, common_scripts\_exploder::exploder, 2003 );
    wait 0.25;
    playfxontag( common_scripts\utility::getfx( "sfa_oil_tanker_skid_impact" ), var_0, "tag_wheel_back_right" );
    var_0 soundscripts\_snd::snd_message( "aud_tanker_fall_down" );
    wait 1.5;
    stopfxontag( level._effect["sfa_oil_tanker_skid_impact"], var_0, "tag_wheel_back_right" );
    wait 1.5;
    stopfxontag( common_scripts\utility::getfx( "sfa_oil_tanker_wheel_smk" ), var_0, "tag_wheel_front_right" );
    stopfxontag( common_scripts\utility::getfx( "sfa_oil_tanker_wheel_smk" ), var_0, "tag_wheel_middle_right" );
    stopfxontag( common_scripts\utility::getfx( "sfa_oil_tanker_wheel_smk" ), var_0, "tag_wheel_back_right" );
    maps\_utility::delaythread( 3, maps\_utility::pauseexploder, 2002 );
    maps\_utility::delaythread( 3, maps\_utility::pauseexploder, 2003 );
}

oil_tanker_crash_fx()
{
    playfxontag( level._effect["sfa_oil_tanker_fire_leak"], self, "tag_vfx_leak" );
    playfxontag( level._effect["sfa_oil_tanker_wheel_skid_runner"], self, "tag_vfx_wheel_back_left" );
    playfxontag( level._effect["sfa_oil_tanker_wheel_skid_runner"], self, "tag_vfx_wheel_back_right" );
    maps\_utility::delaythread( 2.5, common_scripts\_exploder::exploder, 2004 );
    maps\_utility::delaythread( 3, common_scripts\_exploder::exploder, 2005 );
    wait 2;
    stopfxontag( level._effect["sfa_oil_tanker_wheel_skid_runner"], self, "tag_vfx_wheel_back_left" );
    wait 3.0;
    thread oil_tanker_explosion_fx();
    stopfxontag( level._effect["sfa_oil_tanker_fire_leak"], self, "tag_vfx_leak" );
    stopfxontag( level._effect["sfa_oil_tanker_wheel_skid_runner"], self, "tag_vfx_wheel_back_right" );
    maps\_utility::delaythread( 5, maps\_utility::pauseexploder, 2004 );
    maps\_utility::delaythread( 5, maps\_utility::pauseexploder, 2005 );
}

oil_tanker_explosion_fx()
{
    common_scripts\_exploder::exploder( 2006 );
    maps\_utility::delaythread( 1.25, common_scripts\_exploder::exploder, 2007 );
    maps\_utility::delaythread( 1.35, common_scripts\_exploder::exploder, 2008 );
    maps\_utility::delaythread( 10, maps\_utility::pauseexploder, 2006 );
    maps\_utility::delaythread( 10, maps\_utility::pauseexploder, 2007 );
    maps\_utility::delaythread( 10, maps\_utility::pauseexploder, 2008 );
}

pitbull_impact_fx( var_0 )
{
    var_0 = level.player_pitbull.fake_vehicle_model;
    playfxontag( common_scripts\utility::getfx( "pitbull_suv_impact" ), var_0, "tag_origin" );
}

atlas_suv_impact_fx( var_0 )
{
    common_scripts\utility::noself_delaycall( 0.1, ::playfxontag, common_scripts\utility::getfx( "atlas_suv_wheel_smk" ), var_0, "tag_wheel_front_left" );
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 linkto( var_0, "tag_body", ( 144, -24, 10 ), ( 0, 0, 0 ) );
    common_scripts\utility::noself_delaycall( 0.95, ::playfxontag, common_scripts\utility::getfx( "pitbull_suv_impact_concrete" ), var_1, "tag_origin" );
    soundscripts\_snd::snd_message( "aud_median_impact" );
    common_scripts\utility::noself_delaycall( 1.0, ::earthquake, 0.8, 0.9, level.player.origin, 1000 );
    common_scripts\utility::noself_delaycall( 1.2, ::playfxontag, common_scripts\utility::getfx( "atlas_suv_mud_spray_bk_lt" ), var_0, "tag_wheel_back_left" );
    common_scripts\utility::noself_delaycall( 1.2, ::playfxontag, common_scripts\utility::getfx( "atlas_suv_mud_spray_bk_rt" ), var_0, "tag_wheel_back_right" );
    maps\_utility::delaythread( 1.5, common_scripts\_exploder::exploder, "fx_atlas_suv_mud_decals_left" );
    maps\_utility::delaythread( 1.8, common_scripts\_exploder::exploder, "fx_atlas_suv_mud_decals_right" );
    var_2 = 2.2;
    maps\_utility::delaythread( var_2, common_scripts\_exploder::exploder, "fx_atlas_suv_explosion" );
    soundscripts\_snd::snd_message( "aud_atlas_suv_explo", var_2 );
    wait 10.0;
    var_1 delete();
}

pitbull_crash_impact_fx( var_0 )
{
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 linkto( var_0, "tag_wheel_front_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    playfxontag( common_scripts\utility::getfx( "atlas_suv_wheel_smk2" ), var_1, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "pitbull_suv_impact2" ), var_1, "tag_origin" );
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2 linkto( var_0, "tag_wheel_front_right", ( 104, 0, 12 ), ( 0, -20, 0 ) );
    common_scripts\utility::noself_delaycall( 2.1, ::playfxontag, common_scripts\utility::getfx( "pitbull_suv_impact2" ), var_2, "tag_origin" );
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3 linkto( var_0, "tag_wheel_back_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    playfxontag( common_scripts\utility::getfx( "atlas_suv_wheel_smk2" ), var_3, "tag_origin" );
    wait 5.0;
    var_1 delete();
    var_2 delete();
    var_3 delete();
}

burke_spit_blood()
{
    wait 14.55;
    playfxontag( common_scripts\utility::getfx( "burke_blood_spit" ), level.burke, "j_head" );
    wait 0.2;
    playfxontag( common_scripts\utility::getfx( "blood_drip_sml_runner" ), level.burke, "j_head" );
    wait 0.25;
    stopfxontag( common_scripts\utility::getfx( "blood_drip_sml_runner" ), level.burke, "j_head" );
}

cop_car_lights_on()
{
    common_scripts\utility::flag_wait( "msg_vfx_zone3_bridge_on_foot" );
    var_0 = common_scripts\utility::getstructarray( "police_sedan_lights", "script_noteworthy" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2 common_scripts\utility::spawn_tag_origin();
        var_4 = randomfloatrange( 0, 4 );
        wait(var_4);
        playfxontag( common_scripts\utility::getfx( "light_sedan_police_scroll" ), var_3, "TAG_ORIGIN" );
        thread kill_bridge_copcar_light( var_3 );
    }
}

kill_bridge_copcar_light( var_0 )
{
    level waittill( "kill_bridge_copcar_lights" );
    stopfxontag( common_scripts\utility::getfx( "light_sedan_police_scroll" ), var_0, "TAG_ORIGIN" );
    var_0 delete();
}

cop_car_lights_on_barricade()
{
    wait(randomfloat( 1 ));
    playfxontag( common_scripts\utility::getfx( "light_sedan_police_scroll" ), self, "tag_origin" );
    level waittill( "kill_barricade_copcar_lights" );
    stopfxontag( level._effect["light_sedan_police_scroll"], self, "tag_origin" );
}

flares_during_standoff()
{
    common_scripts\utility::flag_wait( "msg_vfx_zone3_bridge_on_foot" );
    common_scripts\_exploder::exploder( 10900 );
    common_scripts\_exploder::exploder( 10040 );
    common_scripts\utility::flag_wait( "flag_van_explosion_start" );
    maps\_utility::pauseexploder( 10900 );
}

vfx_pitbull_atlas_impact( var_0 )
{
    maps\_utility::delaythread( 2, common_scripts\_exploder::exploder, 2010 );
    maps\_utility::delaythread( 5, maps\_utility::pauseexploder, 2010 );
}

vfx_pitbull_crash_jump_start( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "sfa_pitbull_incabin_flip_debris" ), var_0, "tag_fx_cabin" );
}

vfx_pitbull_roof_impact( var_0 )
{
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_1 linkto( var_0, "body_animate_jnt", ( 29, -19, 50 ), ( 180, 0, 90 ) );
    var_2 linkto( var_0, "body_animate_jnt", ( 29, 19, 50 ), ( 180, 0, 90 ) );
    playfxontag( common_scripts\utility::getfx( "car_window_shatter_01" ), var_1, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "car_window_shatter_01" ), var_2, "tag_origin" );
    wait 1.0;
    var_1 delete();
    var_2 delete();
}

vfx_pitbull_slide_sparks_start( var_0 )
{
    level.sparks1 = common_scripts\utility::spawn_tag_origin();
    level.sparks1 linkto( var_0, "tag_body", ( 26, 30, 60 ), ( 0, 0, 180 ) );
    playfxontag( common_scripts\utility::getfx( "pitbull_skid_sparks" ), level.sparks1, "tag_origin" );
    earthquake( 0.5, 2, level.player.origin, 1500 );
    common_scripts\utility::noself_delaycall( 1.0, ::earthquake, 0.35, 0.75, level.player.origin, 1000 );
    common_scripts\utility::noself_delaycall( 1.25, ::earthquake, 0.35, 0.75, level.player.origin, 1000 );
    common_scripts\utility::noself_delaycall( 1.5, ::earthquake, 0.35, 0.75, level.player.origin, 1000 );
    common_scripts\utility::noself_delaycall( 1.75, ::earthquake, 0.35, 0.75, level.player.origin, 1000 );
    common_scripts\utility::noself_delaycall( 2.0, ::earthquake, 0.35, 0.75, level.player.origin, 1000 );
    common_scripts\utility::noself_delaycall( 2.25, ::earthquake, 0.35, 0.75, level.player.origin, 1000 );
    common_scripts\utility::noself_delaycall( 2.5, ::earthquake, 0.35, 0.75, level.player.origin, 1000 );
    common_scripts\utility::noself_delaycall( 2.75, ::earthquake, 0.5, 1, level.player.origin, 1000 );
    wait 7;
    level.sparks1 delete();
}

vfx_pitbull_slide_sparks_stop( var_0 )
{
    stopfxontag( common_scripts\utility::getfx( "pitbull_skid_sparks" ), level.sparks1, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "sfa_pitbull_skid_stop_smoke" ), level.sparks1, "tag_origin" );
    common_scripts\_exploder::exploder( 3001 );
    playfxontag( common_scripts\utility::getfx( "electrical_sparks_runner" ), var_0, "tag_blood" );

    if ( level.nextgen )
        return;
}

oil_tanker_bridge_fire()
{
    common_scripts\_exploder::exploder( 2150 );
    maps\_utility::delaythread( 0.25, common_scripts\_exploder::exploder, 2110 );
    maps\_utility::delaythread( 0.25, common_scripts\_exploder::exploder, 2120 );
    maps\_utility::delaythread( 2.0, maps\_utility::pauseexploder, 2150 );
    common_scripts\utility::flag_wait( "kill_oil_puddle_flames" );
    maps\_utility::pauseexploder( 2110 );
    maps\_utility::delaythread( 0.7, maps\_utility::pauseexploder, 2120 );
    soundscripts\_snd::snd_message( "bridge_tanker_explode" );
}

ignite_tanker_spurt()
{
    common_scripts\_exploder::exploder( 2140 );
    common_scripts\utility::flag_wait( "flag_tanker_exploded" );
    maps\_utility::pauseexploder( 2140 );
}

oil_tanker_bridge_explosion()
{
    common_scripts\_exploder::exploder( 2203 );
    common_scripts\_exploder::exploder( 2204 );
    wait 5;
    maps\_utility::pauseexploder( 2204 );
    maps\_utility::delaythread( 15.0, maps\_utility::pauseexploder, 2203 );
}

vfx_van_passenger_door_open( var_0 )
{
    common_scripts\_exploder::exploder( 10001 );
    thread vfx_guy04_shot_blood();
    thread kill_fog_on_hill();
    wait 5;
    thread kill_bridge_fog();
}

vfx_guy04_shot_blood()
{
    wait 5.25;
    common_scripts\_exploder::exploder( 10002 );
}

kill_fog_on_hill()
{
    foreach ( var_1 in level.createfxent )
    {
        if ( var_1.v["fxid"] == "fog_over_hill_slow" )
            var_1 common_scripts\utility::pauseeffect();
    }
}

kill_bridge_fog()
{
    maps\_utility::pauseexploder( 100 );
    maps\_utility::pauseexploder( 200 );
}

vfx_cutter_spark( var_0 )
{
    level notify( "kill_barricade_copcar_lights" );
    playfxontag( common_scripts\utility::getfx( "cutter_spark" ), var_0, "TAG_FX" );
    wait 0.5;
    playfxontag( common_scripts\utility::getfx( "cutter_spark" ), var_0, "TAG_FX" );
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "cutter_spark" ), var_0, "TAG_FX" );
}

vfx_cutter_ignite( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "cutter_ignite" ), var_0, "TAG_FX" );
    wait 3;
    stopfxontag( common_scripts\utility::getfx( "cutter_ignite_light" ), var_0, "TAG_FX" );
}

vfx_van_back_door_open( var_0 )
{
    common_scripts\_exploder::exploder( 10003 );
    wait 2.0;

    foreach ( var_2 in level.explosion_scene_drones )
        var_2 thread attach_assault_drone_lights();

    level.explosion_scene_drone_large thread attach_assault_drone_lights();
}

attach_assault_drone_lights()
{
    var_0 = 0.25;
    playfxontag( common_scripts\utility::getfx( "drone_beacon_red" ), self, "TAG_FX_BEACON_0" );
    wait(var_0);
    playfxontag( common_scripts\utility::getfx( "drone_beacon_red" ), self, "TAG_FX_BEACON_1" );
    wait(var_0);
    playfxontag( common_scripts\utility::getfx( "drone_beacon_red" ), self, "TAG_FX_BEACON_2" );
}

vfx_drone_fan_start( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "drone_fan_distortion" ), var_0, "TAG_FX_FAN_L" );
    waitframe();
    playfxontag( common_scripts\utility::getfx( "drone_fan_distortion" ), var_0, "TAG_FX_FAN_R" );
}

vfx_drone_large_fan_start( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "drone_fan_distortion_large" ), var_0, "TAG_FX_FAN_L" );
    waitframe();
    playfxontag( common_scripts\utility::getfx( "drone_fan_distortion_large" ), var_0, "TAG_FX_FAN_R" );
    waitframe();
    playfxontag( common_scripts\utility::getfx( "drone_thruster_distortion" ), var_0, "TAG_FX_THRUSTER_L" );
    waitframe();
    playfxontag( common_scripts\utility::getfx( "drone_thruster_distortion" ), var_0, "TAG_FX_THRUSTER_R" );
    waitframe();
}

vfx_drone_explo( var_0 )
{
    var_0 soundscripts\_snd::snd_message( "gg_drone_cable_explosions" );
    earthquake( 0.1, 0.2, level.player.origin, 100 );
    playfxontag( common_scripts\utility::getfx( "drone_explosion" ), var_0, "tag_origin" );
    var_0 hide();
}

vfx_drone_explo_regularfx( var_0 )
{
    var_0 soundscripts\_snd::snd_message( "gg_drone_explosions" );
    earthquake( 0.1, 0.2, level.player.origin, 100 );
    playfxontag( common_scripts\utility::getfx( "vehicle_pdrone_explosion" ), var_0, "tag_origin" );
    var_0 hide();
}

vfx_cable_break( var_0 )
{
    wait 3.25;
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_heli_slide" ), var_0, "jnt_supportCableA13_top2" );
}

vfx_cable_spark_hero( var_0 )
{
    wait 0.5;
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_herocable_glowsmk" ), var_0, "rigSkel33" );
}

vfx_van_explosion_start( var_0 )
{
    common_scripts\_exploder::exploder( 10004 );
    maps\_utility::pauseexploder( 10040 );
    maps\_utility::delaythread( 0, ::vfx_falling_debris_start );
    maps\_utility::delaythread( 3, ::vfx_gushing_smk );
}

vfx_player_hit_windshield( var_0 )
{
    common_scripts\_exploder::exploder( 10500 );
    thread helicopter_slide_spark();
}

helicopter_slide_spark()
{
    wait 5.1;
    common_scripts\_exploder::exploder( 10501 );
}

vfx_bridge_shake_left( var_0 )
{
    common_scripts\_exploder::exploder( 10007 );
}

vfx_bridge_shake_right( var_0 )
{
    common_scripts\_exploder::exploder( 10006 );
}

vfx_bridge_snap( var_0 )
{
    soundscripts\_snd::snd_message( "gg_bridge_snap_explosion" );
    common_scripts\_exploder::exploder( 10008 );
    level notify( "bridge_snap_end" );
    wait 0.9;
    common_scripts\_exploder::exploder( 10009 );
    wait 0.5;
    common_scripts\_exploder::exploder( 10010 );
    wait 0.35;
    common_scripts\_exploder::exploder( 10011 );
}

vfx_falling_debris_start()
{
    maps\_utility::delaythread( 10, ::falling_dust_on_cable );
    maps\_utility::delaythread( 0, common_scripts\_exploder::exploder, 12001 );
    maps\_utility::delaythread( 2, common_scripts\_exploder::exploder, 12002 );
    maps\_utility::delaythread( 1, common_scripts\_exploder::exploder, 12003 );
    maps\_utility::delaythread( 0, common_scripts\_exploder::exploder, 12010 );
    maps\_utility::delaythread( 28, common_scripts\_exploder::exploder, 12015 );
    maps\_utility::delaythread( 23, common_scripts\_exploder::exploder, 12011 );
    maps\_utility::delaythread( 18, common_scripts\_exploder::exploder, 12012 );
    maps\_utility::delaythread( 35, common_scripts\_exploder::exploder, 12013 );
    maps\_utility::delaythread( 25, common_scripts\_exploder::exploder, 12011 );
    maps\_utility::delaythread( 32, common_scripts\_exploder::exploder, 12012 );
    maps\_utility::delaythread( 24, common_scripts\_exploder::exploder, 12013 );
}

vfx_gushing_smk()
{
    common_scripts\_exploder::exploder( 10005 );
    wait 2.1;
    maps\_utility::pauseexploder( 10005 );
    thread lingering_ground_smk();
}

lingering_ground_smk()
{
    common_scripts\_exploder::exploder( 10205 );
    wait 5.5;
    maps\_utility::pauseexploder( 10205 );
}

falling_dust_on_cable()
{
    common_scripts\_exploder::exploder( 10201 );
}

vfx_burst_right_close( var_0 )
{
    common_scripts\_exploder::exploder( 10210 );
}

vfx_burst_left_close( var_0 )
{
    common_scripts\_exploder::exploder( 10211 );
}

vfx_bridge_crack_start( var_0 )
{
    maps\_utility::delaythread( 2.5, ::lingering_grnd_smoke_attached, var_0 );
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_grnd_crack_burst" ), var_0, "jnt_segment_1_piece_97" );
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_grnd_crack_burst" ), var_0, "jnt_segment_1_piece_105" );
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_grnd_crack_burst" ), var_0, "jnt_segment_1_piece_87" );
    wait 0.2;
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_grnd_crack_burst" ), var_0, "jnt_segment_1_piece_102" );
    wait 0.2;
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_grnd_crack_burst" ), var_0, "jnt_segment_1_piece_83" );
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_grnd_crack_burst" ), var_0, "jnt_segment_1_piece_47" );
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_grnd_crack_burst" ), var_0, "jnt_segment_1_piece_70" );
    wait 0.05;
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_grnd_crack_burst" ), var_0, "jnt_segment_1_piece_49" );
    wait 0.05;
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_grnd_crack_burst" ), var_0, "jnt_segment_1_piece_33" );
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_grnd_crack_burst" ), var_0, "jnt_segment_1_piece_51" );
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_grnd_crack_burst" ), var_0, "jnt_segment_1_piece_32" );
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_grnd_crack_burst" ), var_0, "jnt_segment_1_piece_30" );
    wait 0.05;
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_grnd_crack_burst" ), var_0, "jnt_segment_1_piece_35" );
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_grnd_crack_burst" ), var_0, "jnt_segment_1_piece_64" );
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_grnd_crack_burst" ), var_0, "jnt_segment_1_piece_60" );
    wait 0.05;
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_grnd_crack_burst" ), var_0, "jnt_segment_1_piece_31" );
    wait 0.05;
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_grnd_crack_burst" ), var_0, "jnt_segment_1_piece_53" );
    thread stop_falling_debris_by_player();
    thread bridge_collapse_mob_explosion();
}

lingering_grnd_smoke_attached( var_0 )
{
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 linkto( var_0, "jnt_segment_1_piece_67", ( 0, 0, -50 ), ( -90, -90, 0 ) );
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_smk_grnd_linger" ), var_1, "tag_origin" );
    wait 7;
    stopfxontag( common_scripts\utility::getfx( "sfa_bigm_smk_grnd_linger" ), var_1, "tag_origin" );
    wait 0.1;
    var_1 linkto( var_0, "jnt_segment_1_piece_67", ( 400, 0, -10 ), ( -90, 90, 0 ) );
    playfxontag( common_scripts\utility::getfx( "dust_rolling_pebbles_runner_lrg" ), var_1, "tag_origin" );
    level waittill( "vfx_boost_jump_start" );
    stopfxontag( common_scripts\utility::getfx( "dust_rolling_pebbles_runner_lrg" ), var_1, "tag_origin" );
    var_1 delete();
}

bridge_collapse_mob_explosion()
{
    maps\_utility::delaythread( 0.8, common_scripts\_exploder::exploder, 10803 );
    maps\_utility::delaythread( 0.95, common_scripts\_exploder::exploder, 10800 );
    maps\_utility::delaythread( 3.75, common_scripts\_exploder::exploder, 10801 );
    maps\_utility::delaythread( 5.5, common_scripts\_exploder::exploder, 10802 );
    maps\_utility::delaythread( 4.25, ::post_collapse_vfx_on_crash_site );
    maps\_utility::delaythread( 2, common_scripts\_exploder::exploder, 4501 );
    maps\_utility::delaythread( 4.5, common_scripts\_exploder::exploder, 4502 );
    maps\_utility::delaythread( 5.5, common_scripts\_exploder::exploder, 4503 );
    maps\_utility::delaythread( 7, common_scripts\_exploder::exploder, 4504 );
    wait 8;
    level notify( "kill_barricade_copcar_lights" );
}

vfx_player_rolling_pebbles( var_0 )
{
    wait 5.25;
    playfxontag( common_scripts\utility::getfx( "dust_rolling_pebbles_runner_vm" ), var_0, "TAG_ORIGIN" );
    wait 10.0;
    stopfxontag( common_scripts\utility::getfx( "dust_rolling_pebbles_runner_vm" ), var_0, "TAG_ORIGIN" );
}

vfx_bridge_chunk_f_piece5_fall( var_0 )
{
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 linkto( var_0, "jnt_segment_5_piece_1", ( 0, 0, 0 ), ( -90, -90, 0 ) );
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_debrisfall_onchunk_lrg" ), var_1, "tag_origin" );
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2 linkto( var_0, "jnt_segment_5_piece_5", ( 0, 0, 0 ), ( -90, -90, 0 ) );
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_debrisfall_onchunk_sm" ), var_2, "tag_origin" );
    level waittill( "vfx_boost_jump_start" );
    stopfxontag( common_scripts\utility::getfx( "sfa_bigm_debrisfall_onchunk_lrg" ), var_1, "tag_origin" );
    stopfxontag( common_scripts\utility::getfx( "sfa_bigm_debrisfall_onchunk_sm" ), var_2, "tag_origin" );
    var_1 delete();
    var_2 delete();
}

stop_falling_debris_by_player()
{
    maps\_utility::pauseexploder( 12001 );
    maps\_utility::pauseexploder( 12002 );
}

vfx_copcar_left_hitspark1( var_0 )
{
    common_scripts\_exploder::exploder( 10502 );
    wait 1.4;
    common_scripts\_exploder::exploder( 10503 );
}

vfx_copcar01_hitspark1( var_0 )
{
    common_scripts\_exploder::exploder( 10504 );
    wait 3.8;
    thread vfx_copcar02_hitspark();
    common_scripts\_exploder::exploder( 10505 );
    wait 0.65;
    common_scripts\_exploder::exploder( 10506 );
    wait 4.5;
    common_scripts\_exploder::exploder( 10506 );
}

vfx_copcar02_hitspark()
{
    wait 0.7;
    common_scripts\_exploder::exploder( 10507 );
    wait 1.5;
    common_scripts\_exploder::exploder( 10508 );
}

vfx_bus_slide_spark( var_0 )
{
    soundscripts\_snd::snd_message( "gg_start_bus_sliding" );
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 linkto( var_0, "tag_origin", ( 160, -50, 120 ), ( -90, 0, -45 ) );
    playfxontag( common_scripts\utility::getfx( "sfa_bigm_bus_slide" ), var_1, "tag_origin" );
    wait 2.45;
    common_scripts\_exploder::exploder( 10511 );
    wait 0.5;
    common_scripts\_exploder::exploder( 10512 );
    wait 0.1;
    common_scripts\_exploder::exploder( 10513 );
    wait 0.15;

    if ( level.nextgen )
        wait 1.7;
    else
        wait 1.45;

    common_scripts\_exploder::exploder( 10515 );
    soundscripts\_snd::snd_message( "gg_bus_explode_death" );

    if ( level.nextgen )
        wait 0.35;
    else
        wait 0.1;

    common_scripts\_exploder::exploder( 10516 );
    var_1 delete();
}

post_collapse_vfx_on_crash_site()
{
    common_scripts\_exploder::exploder( 4550 );
    wait 4.5;
    common_scripts\_exploder::exploder( 4501 );
    wait 1;
    common_scripts\_exploder::exploder( 4500 );
    wait 6;
    common_scripts\_exploder::exploder( 4800 );
}

pause_bigmoment_vfx()
{
    level waittill( "vfx_boost_jump_start" );
    maps\_utility::pauseexploder( 12001 );
    maps\_utility::pauseexploder( 12002 );
}

attach_wakefx()
{
    var_0 = "tag_origin";
    playfxontag( common_scripts\utility::getfx( "boat_wake_" + self.model ), self, var_0 );

    if ( self.model == "vehicle_atlas_decoy_cargo_ship" )
    {
        self.fxtagside = common_scripts\utility::spawn_tag_origin();
        self.fxtagside.origin = self.origin;
        self.fxtagside.angles = self.angles;
        self.fxtagside linkto( self, "tag_origin", ( 0, 0, 0 ), ( 0, 90, 0 ) );
        playfxontag( common_scripts\utility::getfx( "boat_wake_" + self.model + "_side" ), self.fxtagside, "tag_origin" );
    }
}

stop_wakefx()
{
    var_0 = "tag_origin";
    stopfxontag( common_scripts\utility::getfx( "boat_wake_" + self.model ), self, var_0 );

    if ( self.model == "vehicle_atlas_decoy_cargo_ship" )
        stopfxontag( common_scripts\utility::getfx( "boat_wake_" + self.model + "_side" ), self.fxtagside, var_0 );
}

vfx_start_boost_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "boost_dust_npc" ), var_0, "J_SpineLower" );
    var_0 thread newhandlespawngroundimpact();
}

vfx_stop_boost_fx( var_0 )
{
    stopfxontag( common_scripts\utility::getfx( "boost_dust_npc" ), var_0, "J_SpineLower" );
}

newhandlespawngroundimpact()
{
    var_0 = self.origin + ( 0, 0, 64 );
    var_1 = self.origin - ( 0, 0, 150 );
    var_2 = bullettrace( var_0, var_1, 0, undefined );
    var_3 = common_scripts\utility::getfx( "boost_dust_impact_ground" );
    var_0 = var_2["position"];
    var_4 = vectortoangles( var_2["normal"] );
    var_4 += ( 90, 0, 0 );
    var_5 = anglestoforward( var_4 );
    var_6 = anglestoup( var_4 );
    playfx( var_3, var_0, var_6, var_5 );
}

vfx_car_radial_damage()
{
    level endon( "flag_dialog_bridge_crash" );
    thread vfx_reactivate_radius_damage();
    setplayerignoreradiusdamage( 1 );

    for (;;)
    {
        var_0 = self.origin + anglestoforward( self.angles ) * 150;
        radiusdamage( var_0, 60, 10, 10, level.player );
        wait 0.01;
    }
}

vfx_reactivate_radius_damage()
{
    common_scripts\utility::flag_wait( "flag_dialog_bridge_crash" );
    setplayerignoreradiusdamage( 0 );
}

vfx_pitbull_mud_spray()
{
    common_scripts\utility::flag_wait( "fx_pitbull_mud_spray" );
    var_0 = level.player_pitbull;
    playfxontag( common_scripts\utility::getfx( "pitbull_mud_spray" ), var_0, "tag_origin" );
}
