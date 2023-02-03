// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    precachefx();
    maps\createfx\lab_fx::main();
    set_lighting_values();
    maps\_shg_fx::setup_shg_fx();
    common_scripts\utility::flag_init( "flag_player_exfil_enter" );
    thread maps\_shg_fx::fx_zone_watcher( 1000, "msg_vfx_zone_1000_crash" );
    thread maps\_shg_fx::fx_zone_watcher( 1100, "msg_vfx_zone_1100_crash" );
    thread maps\_shg_fx::fx_zone_watcher( 2000, "msg_vfx_zone_2000_post_river" );
    thread maps\_shg_fx::fx_zone_watcher( 3000, "msg_vfx_zone_3000_rappel" );
    thread maps\_shg_fx::fx_zone_watcher( 4000, "msg_vfx_zone_4000_facility_1" );
    thread maps\_shg_fx::fx_zone_watcher( 5000, "msg_vfx_zone_5000_facility_2" );
    thread maps\_shg_fx::fx_zone_watcher( 6000, "msg_vfx_zone_6000_courtyard" );
    thread maps\_shg_fx::fx_zone_watcher( 6100, "msg_vfx_zone_6100_rappel_courtyard" );
    thread maps\_shg_fx::fx_zone_watcher( 7000, "msg_vfx_zone_7000_tank_hangar" );
    thread maps\_shg_fx::fx_zone_watcher( 8000, "msg_vfx_zone_8000_tank_field_1" );
    thread maps\_shg_fx::fx_zone_watcher( 9000, "msg_vfx_zone_9000_tank_field_2" );
    thread treadfx_override();
    thread river_entry_splash_fx();
    thread treadfx_of_logging_road();
    thread birds_scatter_cliff_rappel();
    thread vfx_foam_room();
}

precachefx()
{
    level._effect["heli_dust_forest"] = loadfx( "vfx/treadfx/heli_dust_forest" );
    level._effect["heli_river_treadfx"] = loadfx( "vfx/treadfx/heli_river" );
    level._effect["heli_dust_warbird"] = loadfx( "vfx/treadfx/heli_dust_warbird" );
    level._effect["heli_dust_warbird_whisp_child"] = loadfx( "vfx/treadfx/heli_dust_warbird_whisp_child" );
    level._effect["heli_dust_warbird_whisp_child_b"] = loadfx( "vfx/treadfx/heli_dust_warbird_whisp_child_b" );
    level._effect["tread_dust_hummer"] = loadfx( "vfx/treadfx/tread_dust_hummer" );
    level._effect["vehicle_civ_ai_explo_lrg_runner"] = loadfx( "vfx/explosion/vehicle_civ_ai_explo_lrg_runner" );
    level._effect["tread_dust_tanks"] = loadfx( "vfx/treadfx/tread_dust_tanks" );
    level._effect["heli_railgun_muzzleflash"] = loadfx( "vfx/muzzleflash/s1_lab_heli_railgun_wv" );
    level._effect["heli_railgun_wood_impact_2"] = loadfx( "vfx/map/lab/lab_heli_railgun_wood_impact_2" );
    level._effect["vehicle_destroyed_fire_m"] = loadfx( "vfx/fire/vehicle_destroyed_fire_m" );
    level._effect["fire_lp_s_base"] = loadfx( "vfx/fire/fire_lp_s_base" );
    level._effect["fire_smoke_s"] = loadfx( "vfx/fire/fire_lp_smk_s" );
    level._effect["fire_lp_xs_strip"] = loadfx( "vfx/fire/fire_lp_xs_strip" );
    level._effect["fire_lp_sm_strip"] = loadfx( "vfx/fire/fire_lp_sm_strip" );
    level._effect["fire_lp_med_strip"] = loadfx( "vfx/fire/fire_lp_med_strip" );
    level._effect["fire_lp_m_no_light"] = loadfx( "vfx/fire/fire_lp_m_no_light" );
    level._effect["fire_intro_light"] = loadfx( "vfx/lights/lab/fire_intro_light" );
    level._effect["lab_intro_smoke"] = loadfx( "vfx/map/lab/lab_intro_smoke" );
    level._effect["light_cone"] = loadfx( "vfx/lights/lab/light_cone_single_smoke_lab" );
    level._effect["light_cone_dark"] = loadfx( "vfx/lights/lab/light_cone_single_smoke_lab_dark" );
    level._effect["light_point_dim"] = loadfx( "vfx/lights/lab/light_white_radiosity_sim_dim" );
    level._effect["light_bounce_outdoors"] = loadfx( "vfx/lights/lab/light_white_bounce_outdoors" );
    level._effect["lab_studiolight_flare"] = loadfx( "vfx/lights/lab/lab_studiolight_flare" );
    level._effect["docks_heli_spotlight"] = loadfx( "vfx/lights/lab/spotlight_heli_hdr" );
    level._effect["docks_heli_spotlight_cheap"] = loadfx( "vfx/lights/lab/spotlight_cheap_heli_hdr" );
    level._effect["fx_flare_aperture"] = loadfx( "vfx/lensflare/fx_flare_aperture" );
    level._effect["fx_flare_med_yellow_dim_simple"] = loadfx( "vfx/lensflare/fx_flare_med_yellow_dim_simple" );
    level._effect["godray_beam_wide"] = loadfx( "vfx/lights/lab/lights_godray_beam_simple_window_wide" );
    level._effect["godray_beam_hangar"] = loadfx( "vfx/lights/lab/lights_godray_beam_hangar" );
    level._effect["godray_beam_wide_bright"] = loadfx( "vfx/lights/lab/lights_godray_beam_simple_wide_bright" );
    level._effect["godray_beam_cracks"] = loadfx( "vfx/lights/lab/lights_godray_beam_simple_window_cracks" );
    level._effect["headlight_no_light"] = loadfx( "vfx/lights/lab/headlight_no_light_lab" );
    level._effect["light_server_room_monitor"] = loadfx( "vfx/lights/lab/light_server_room_monitor" );
    level._effect["light_orange_sign"] = loadfx( "vfx/lights/lab/light_orange_sign" );
    level._effect["light_blue_fill"] = loadfx( "vfx/lights/lab/light_blue_fill" );
    level._effect["lamp_volume_lab_courtyard"] = loadfx( "vfx/lights/lab/lamp_volume_lab_courtyard" );
    level._effect["godray_golden_dim"] = loadfx( "vfx/lights/lab/godray_golden_dim" );
    level._effect["point_blue_fill"] = loadfx( "vfx/lights/lab/point_blue_fill" );
    level._effect["point_blue_fill_tank_gun"] = loadfx( "vfx/lights/lab/point_blue_fill_tank_gun" );
    level._effect["point_yellow_fill"] = loadfx( "vfx/lights/lab/point_yellow_fill" );
    level._effect["point_yellow_fill_sm"] = loadfx( "vfx/lights/lab/point_yellow_fill_sm" );
    level._effect["light_smoke_dim"] = loadfx( "vfx/lights/lab/light_smoke_dim" );
    level._effect["lab_amb_fog_blue_dark"] = loadfx( "vfx/map/lab/lab_amb_fog_blue_dark" );
    level._effect["light_yellow_rotate"] = loadfx( "vfx/lights/light_yellow_rotate_sm" );
    level._effect["spotlight_drone_deer"] = loadfx( "vfx/lights/lab/spotlight_drone_deer" );
    level._effect["light_point_red_solid_nolens"] = loadfx( "vfx/lights/light_wingtip_red_med_point_nolens" );
    level._effect["spot_orange"] = loadfx( "vfx/lights/spot_orange" );
    level._effect["godray_med_grp"] = loadfx( "vfx/lights/lab/lab_godray_med_grp" );
    level._effect["light_red_strobe"] = loadfx( "vfx/lights/lab/light_red_strobe" );
    level._effect["light_fire_alarm_strobe"] = loadfx( "vfx/lights/light_fire_alarm_strobe" );
    level._effect["light_fire_alarm_strobe_wall_fix"] = loadfx( "vfx/lights/light_fire_alarm_strobe_wall_fix" );
    level._effect["light_explosion_flash_dim"] = loadfx( "vfx/lights/light_explosion_flash_dim" );
    level._effect["yellow_fire"] = loadfx( "vfx/lights/lab/fire_yellow" );
    level._effect["godray_golden_dim"] = loadfx( "vfx/lights/lab/lab_godray_golden_dim" );
    level._effect["point_blue_heli"] = loadfx( "vfx/lights/lab/lab_heli_point_blue" );
    level._effect["point_blue_heli_dim"] = loadfx( "vfx/lights/lab/lab_heli_point_blue_dim" );
    level._effect["point_blue_heli_fill"] = loadfx( "vfx/lights/lab/lab_heli_point_blue_fill" );
    level._effect["spot_orange_tank_int"] = loadfx( "vfx/lights/lab/spot_orange_tank_int" );
    level._effect["spot_orange_tank_int2"] = loadfx( "vfx/lights/lab/spot_orange_tank_int2" );
    level._effect["point_red_heli_out"] = loadfx( "vfx/lights/lab/lab_point_red_heli_out" );
    level._effect["point_red_heli_in"] = loadfx( "vfx/lights/lab/lab_point_red_heli_in" );
    level._effect["spot_red_heli_in"] = loadfx( "vfx/lights/lab/lab_spot_red_heli_in" );
    level._effect["spot_red_heli_in_lrg"] = loadfx( "vfx/lights/lab/lab_spot_red_heli_in_lrg" );
    level._effect["lab_heli_spot_flare"] = loadfx( "vfx/lensflare/lab/lab_heli_spot_flare" );
    level._effect["light_glow_red_steady"] = loadfx( "vfx/lights/tower_light_glow_red_steady" );
    level._effect["headlight_gaz_spotlight"] = loadfx( "vfx/lights/headlight_gaz_spotlight" );
    level._effect["lab_courtyard_floodlight_flare"] = loadfx( "vfx/lights/lab/lab_courtyard_floodlight_flare" );
    level._effect["leaves_runner_2"] = loadfx( "vfx/wind/leaves_runner_2" );
    level._effect["leaves_fall_gentlewind_no_physics"] = loadfx( "vfx/wind/leaves_fall_gentlewind_no_physics" );
    level._effect["fog_windy_bright"] = loadfx( "vfx/fog/fog_windy_bright" );
    level._effect["embers_runner_sml"] = loadfx( "vfx/fire/embers_runner_sml_lp" );
    level._effect["lights_moonbeam_1"] = loadfx( "vfx/lights/lights_moonbeam_1" );
    level._effect["embers_wind_vortex"] = loadfx( "vfx/fire/embers_wind_vortex" );
    level._effect["amb_ground_dust_lrg"] = loadfx( "vfx/dust/amb_ground_dust_lrg" );
    level._effect["battlefield_smoke_m"] = loadfx( "vfx/smoke/battlefield_smoke_m" );
    level._effect["insects_moths"] = loadfx( "vfx/animal/insects_moths" );
    level._effect["insects_mosquitos"] = loadfx( "vfx/animal/insects_mosquitos_flying" );
    level._effect["leaves_fall_twirl_no_physics"] = loadfx( "vfx/wind/leaves_fall_twirl_no_physics" );
    level._effect["smoke_white_ground_wind_sm"] = loadfx( "vfx/smoke/smoke_white_ground_wind_sm" );
    level._effect["insects_firefly_runner"] = loadfx( "vfx/animal/insects_firefly_runner" );
    level._effect["river_flowing_leaves"] = loadfx( "vfx/water/river_flowing_leaves" );
    level._effect["birds_tree_flyout"] = loadfx( "vfx/animal/birds_tree_flyout" );
    level._effect["leaves_ground_kickup"] = loadfx( "vfx/wind/leaves_ground_kickup" );
    level._effect["leaves_ground_kickup_dust"] = loadfx( "vfx/wind/leaves_ground_kickup_dust" );
    level._effect["fog_in_valley"] = loadfx( "vfx/fog/fog_in_valley" );
    level._effect["dry_ice_floor"] = loadfx( "vfx/fog/dry_ice_floor" );
    level._effect["dry_ice_low"] = loadfx( "vfx/fog/dry_ice_low" );
    level._effect["dry_ice_med"] = loadfx( "vfx/fog/dry_ice_med" );
    level._effect["dry_ice_center"] = loadfx( "vfx/fog/dry_ice_center" );
    level._effect["lab_godray_pre_foamroom"] = loadfx( "vfx/map/lab/lab_godray_pre_foamroom" );
    level._effect["lab_godray_foamroom"] = loadfx( "vfx/map/lab/lab_godray_foamroom" );
    level._effect["lab_godray_foamroom_wide"] = loadfx( "vfx/map/lab/lab_godray_foamroom_wide" );
    level._effect["steam_vent_burst_runner"] = loadfx( "vfx/steam/steam_vent_burst_runner" );
    level._effect["steam_vent_burst_runner_seq_01"] = loadfx( "vfx/steam/steam_vent_burst_runner_seq_01" );
    level._effect["steam_vent_burst_runner_seq_02"] = loadfx( "vfx/steam/steam_vent_burst_runner_seq_02" );
    level._effect["fog_low_lying"] = loadfx( "vfx/fog/fog_low_lying" );
    level._effect["splash_foam_runner"] = loadfx( "vfx/water/splash_foam_runner" );
    level._effect["river_splash_runner"] = loadfx( "vfx/water/river_splash_runner" );
    level._effect["rain_splash_hvy_04"] = loadfx( "vfx/rain/rain_splash_hvy_04" );
    level._effect["boxcar_explosion"] = loadfx( "vfx/explosion/vehicle_civ_ai_explo_lrg_runner" );
    level._effect["breach_damaged_sparks"] = loadfx( "vfx/map/lab/lab_breach_damaged_sparks_l" );
    level._effect["facility_rm_fog_cool"] = loadfx( "vfx/map/lab/lab_facility_rm_fog_cool" );
    level._effect["fire_lp_m_light"] = loadfx( "vfx/fire/fire_lp_m_light" );
    level._effect["mobile_turret_ground_smoke"] = loadfx( "vfx/map/fusion/fusion_mobile_turret_base_smoke" );
    level._effect["dust_foot_hillslide"] = loadfx( "vfx/dust/dust_foot_hillslide" );
    level._effect["river_rock_splash_1"] = loadfx( "vfx/water/river_rock_splash_1" );
    level._effect["lab_burke_river_entry_splashes"] = loadfx( "vfx/map/lab/lab_burke_river_entry_splashes" );
    level._effect["lab_burke_river_looping_splashes"] = loadfx( "vfx/map/lab/lab_burke_river_looping_splashes" );
    level._effect["lab_player_river_looping_splashes"] = loadfx( "vfx/map/lab/lab_player_river_looping_splashes" );
    level._effect["lab_wall_climb_dust"] = loadfx( "vfx/map/lab/lab_wall_climb_dust" );
    level._effect["lab_gaz_mud_tracks"] = loadfx( "vfx/map/lab/lab_gaz_mud_tracks" );
    level._effect["lab_gaz_mud_tracks_2"] = loadfx( "vfx/map/lab/lab_gaz_mud_tracks_2" );
    level._effect["door_breach_explosion"] = loadfx( "vfx/map/lab/lab_door_breach_explosion" );
    level._effect["lab_mute_device_plant_vm"] = loadfx( "vfx/map/lab/lab_mute_device_plant_vm" );
    level._effect["lab_mute_area_distort_player_view"] = loadfx( "vfx/map/lab/lab_mute_area_distort_player_view" );
    level._effect["lab_mute_device_lights"] = loadfx( "vfx/map/lab/lab_mute_device_lights" );
    level._effect["mute_breach_distort_vm_enter"] = loadfx( "vfx/props/mute_breach_distort_vm_enter" );
    level._effect["mute_breach_distort_vm_exit"] = loadfx( "vfx/props/mute_breach_distort_vm_exit" );
    level._effect["facility_breach_rm_smoke"] = loadfx( "vfx/map/lab/lab_facility_breach_rm_smk" );
    level._effect["flashlight_ai"] = loadfx( "vfx/lights/lab/flashlight_lab" );
    level._effect["flashlight_spotlight"] = loadfx( "vfx/lights/lab/flashlight_spotlight_player_lab" );
    level._effect["point_amber"] = loadfx( "vfx/lights/light_point_amber" );
    level._effect["drone_search_lt"] = loadfx( "vfx/lights/drone_search_lt" );
    level._effect["takedown_head_impact_dust"] = loadfx( "vfx/map/lab/lab_takedown_head_impact_dust" );
    level._effect["veh_turret_scanner_search"] = loadfx( "vfx/map/lab/lab_veh_turret_scanner_search" );
    level._effect["veh_turret_scanner_search_red"] = loadfx( "vfx/map/lab/lab_veh_turret_scanner_search_red" );
    level._effect["camera_fixed_scanner"] = loadfx( "vfx/destructible/security_cam_scanner_locked" );
    level._effect["camera_fixed_scanner_search"] = loadfx( "vfx/destructible/security_cam_scanner" );
    level._effect["flesh_hit"] = loadfx( "vfx/weaponimpact/flesh_impact_body_fatal_exit" );
    level._effect["lab_pnematic_anchor"] = loadfx( "vfx/map/lab/lab_pnematic_anchor" );
    level._effect["lab_foam_burst_smk"] = loadfx( "vfx/map/lab/lab_foam_burst_smk" );
    level._effect["lab_foam_rm_smk_facade"] = loadfx( "vfx/map/lab/lab_foam_rm_smk_facade" );
    level._effect["thermite_grenade_ignite"] = loadfx( "vfx/props/thermite_grenade_ignite" );
    level._effect["thermite_fire_crawl_wall_lrg"] = loadfx( "vfx/map/lab/lab_thermite_fire_crawl_wall_lrg" );
    level._effect["thermite_grenade_burn_lp"] = loadfx( "vfx/map/lab/lab_thermite_grenade_burn_lp" );
    level._effect["lab_thermite_smoke_area"] = loadfx( "vfx/map/lab/lab_thermite_smoke_area" );
    level._effect["electrical_sparks"] = loadfx( "vfx/explosion/electrical_sparks" );
    level._effect["mech_impact_dust"] = loadfx( "vfx/dust/exo_armor_stomp_impact_dust" );
    level._effect["rpg_muzzle_flash"] = loadfx( "vfx/muzzleflash/rpg_flash_wv" );
    level._effect["tank_immobilized"] = loadfx( "vfx/explosion/vehicle_civ_ai_explo_lrg_runner" );
    level._effect["hovertank_exhaust_regular"] = loadfx( "vfx/vehicle/hovertank_exhaust_regular" );
    level._effect["hovertank_exhaust_strong"] = loadfx( "vfx/vehicle/hovertank_exhaust_strong" );
    level._effect["hovertank_exhaust_light_flicker_dual"] = loadfx( "vfx/vehicle/hovertank_exhaust_light_flicker_dual" );
    level._effect["hovertank_exhaust_light_flicker_dualSM"] = loadfx( "vfx/vehicle/hovertank_exhaust_light_flicker_dualSM" );
    level._effect["hovertank_tread_smk_strong_runner"] = loadfx( "vfx/treadfx/hovertank_tread_smk_strong_runner" );
    level._effect["hovertank_tread_smk_regular_runner"] = loadfx( "vfx/treadfx/hovertank_tread_smk_regular_runner" );
    level._effect["electrical_blue_burst_directional_01"] = loadfx( "vfx/lightning/electrical_blue_burst_directional_01" );
    level._effect["smk_ring_rad25_lp_01"] = loadfx( "vfx/smoke/smk_ring_rad25_lp_01" );
    level._effect["smk_ring_rad30_lp_01"] = loadfx( "vfx/smoke/smk_ring_rad30_lp_01" );
    level._effect["lab_htank_disengage_grnd_smk"] = loadfx( "vfx/map/lab/lab_htank_disengage_grnd_smk" );
    level._effect["hovertank_death_explosion"] = loadfx( "vfx/explosion/hovertank_death_explosion" );
    level._effect["hovertank_death_explosion_initial"] = loadfx( "vfx/explosion/hovertank_death_explosion_initial" );
    level._effect["lab_exfil_razorback_idle_smk_grnd"] = loadfx( "vfx/map/lab/lab_exfil_razorback_idle_smk_grnd" );
    level._effect["smoke_grey_column_2_spot_directional_lg"] = loadfx( "vfx/smoke/smoke_grey_column_2_spot_directional_lg" );
    level._effect["fireball_lp_smk_m"] = loadfx( "vfx/fire/fireball_lp_smk_m" );
    level._effect["ash_cloud_freq_lrg_loop"] = loadfx( "vfx/ash/ash_cloud_freq_lrg_loop" );
    level._effect["cg_fx_light_character_1"] = loadfx( "vfx/map/lab/lab_character_light_1_cg" );
}

set_lighting_values()
{
    if ( isusinghdr() )
        setsaveddvar( "r_tonemap", 2 );
}

treadfx_override()
{
    waittillframeend;
    var_0[0] = "script_vehicle_littlebird_armed";
    var_1[0] = "script_vehicle_xh9_warbird_low_heavy_turret";
    var_2[0] = "script_vehicle_vrap";
    var_2[0] = "script_vehicle_vrap_physics";
    var_3[0] = "script_vehicle_ft101_tank_physics";
    level.treadfx_maxheight = 5000;
    var_4 = "vfx/treadfx/heli_dust_forest";
    var_5 = "vfx/treadfx/heli_dust_warbird";
    var_6 = "vfx/treadfx/tread_dust_hummer";
    var_7 = "vfx/treadfx/tread_dust_tanks";
    var_8 = "vfx/treadfx/heli_river";
    var_9 = "vfx/unique/no_fx";

    foreach ( var_11 in var_0 )
    {
        maps\_vehicle::set_vehicle_effect( var_11, "brick", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "bark", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "carpet", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "cloth", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "concrete", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "dirt", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "flesh", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "foliage", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "glass", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "grass", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "gravel", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "ice", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "metal", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "mud", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "paper", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "plaster", var_9 );
        maps\_vehicle::set_vehicle_effect( var_11, "rock", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "sand", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "snow", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "water", var_8 );
        maps\_vehicle::set_vehicle_effect( var_11, "wood", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "asphalt", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "ceramic", var_9 );
        maps\_vehicle::set_vehicle_effect( var_11, "plastic", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "rubber", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "cushion", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "fruit", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "paintedmetal", var_9 );
        maps\_vehicle::set_vehicle_effect( var_11, "riotshield", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "slush", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "default", var_4 );
        maps\_vehicle::set_vehicle_effect( var_11, "none" );
    }

    foreach ( var_11 in var_1 )
    {
        maps\_vehicle::set_vehicle_effect( var_11, "brick", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "bark", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "carpet", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "cloth", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "concrete", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "dirt", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "flesh", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "foliage", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "glass", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "grass", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "gravel", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "ice", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "metal", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "mud", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "paper", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "plaster", var_9 );
        maps\_vehicle::set_vehicle_effect( var_11, "rock", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "sand", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "snow", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "water", var_8 );
        maps\_vehicle::set_vehicle_effect( var_11, "wood", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "asphalt", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "ceramic", var_9 );
        maps\_vehicle::set_vehicle_effect( var_11, "plastic", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "rubber", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "cushion", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "fruit", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "paintedmetal", var_9 );
        maps\_vehicle::set_vehicle_effect( var_11, "riotshield", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "slush", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "default", var_5 );
        maps\_vehicle::set_vehicle_effect( var_11, "none" );
    }

    foreach ( var_11 in var_2 )
    {
        maps\_vehicle::set_vehicle_effect( var_11, "brick", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "bark", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "carpet", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "cloth", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "concrete", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "dirt", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "flesh", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "foliage", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "glass", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "grass", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "gravel", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "ice", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "metal", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "mud", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "paper", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "plaster", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "rock", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "sand", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "snow", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "water", var_9 );
        maps\_vehicle::set_vehicle_effect( var_11, "wood", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "asphalt", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "ceramic", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "plastic", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "rubber", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "cushion", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "fruit", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "paintedmetal", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "riotshield", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "slush", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "default", var_6 );
        maps\_vehicle::set_vehicle_effect( var_11, "none", var_6 );
    }

    foreach ( var_11 in var_3 )
    {
        maps\_vehicle::set_vehicle_effect( var_11, "brick", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "bark", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "carpet", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "cloth", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "concrete", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "dirt", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "flesh", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "foliage", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "glass", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "grass", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "gravel", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "ice", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "metal", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "mud", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "paper", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "plaster", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "rock", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "sand", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "snow", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "water", var_9 );
        maps\_vehicle::set_vehicle_effect( var_11, "wood", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "asphalt", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "ceramic", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "plastic", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "rubber", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "cushion", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "fruit", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "paintedmetal", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "riotshield", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "slush", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "default", var_7 );
        maps\_vehicle::set_vehicle_effect( var_11, "none", var_7 );
    }
}

treadfx_of_logging_road()
{
    level waittill( "vfx_treadfx_littlebird_off" );
    var_0[0] = "script_vehicle_littlebird_armed";
    level.treadfx_maxheight = 1000;
    var_1 = "vfx/unique/no_fx";

    foreach ( var_3 in var_0 )
    {
        maps\_vehicle::set_vehicle_effect( var_3, "brick", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "bark", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "carpet", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "cloth", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "concrete", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "dirt", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "flesh", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "foliage", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "glass", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "grass", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "gravel", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "ice", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "metal", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "mud", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "paper", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "plaster", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "rock", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "sand", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "snow", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "water", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "wood", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "asphalt", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "ceramic", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "plastic", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "rubber", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "cushion", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "fruit", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "paintedmetal", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "riotshield", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "slush", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "default", var_1 );
        maps\_vehicle::set_vehicle_effect( var_3, "none" );
    }
}

shack_roof_damage_fx()
{
    soundscripts\_snd::snd_message( "aud_shack_explode", "lab_shack_roof_damage" );
    common_scripts\_exploder::exploder( "lab_shack_roof_damage" );
}

river_entry_splash_fx()
{
    common_scripts\utility::flag_init( "river_entry_splash_fx_flag" );
    wait 0.1;

    for (;;)
    {
        common_scripts\utility::flag_wait( "river_entry_splash_fx_flag" );
        var_0 = ( level.player.origin[0], level.player.origin[1], -536 );
        var_1 = distance( level.player getvelocity(), ( 0, 0, 0 ) );

        if ( var_1 > 0 )
            wait(max( 1 - var_1 / 120, 0.1 ));
        else
            wait 0.3;

        if ( var_1 > 5 )
            playfx( common_scripts\utility::getfx( "lab_player_river_looping_splashes" ), var_0, anglestoforward( ( 0, level.player.angles[1], 0 ) + ( 270, 180, 0 ) ) );

        wait 0.1;
    }

    common_scripts\utility::flag_waitopen( "river_entry_splash_fx_flag" );
}

burke_river_entry_splash_fx( var_0 )
{
    wait 0.9;
    common_scripts\_exploder::exploder( "river_entry_splashes" );
}

burke_river_looping_splash_fx( var_0 )
{
    wait 1.0;

    for ( var_1 = 0; var_1 < 20; var_1++ )
    {
        var_2 = ( level.burke.origin[0], level.burke.origin[1], -536 );
        playfx( common_scripts\utility::getfx( "lab_burke_river_looping_splashes" ), var_2, anglestoforward( ( 0, level.burke.angles[1], 0 ) + ( 270, 180, 0 ) ) );
        wait 0.5;
    }

    wait 1.6;
    common_scripts\_exploder::exploder( "2200" );
}

wall_climb_dust_fx()
{
    wait 1;
    common_scripts\_exploder::exploder( "lab_wall_climb" );
}

deer_leaves_fx()
{
    common_scripts\_exploder::exploder( "2100" );
}

drone_search_light_fx()
{
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "drone_search_lt" ), self, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "drone_beacon_red_slow_nolight" ), self, "TAG_FX_BEACON_0" );
    playfxontag( common_scripts\utility::getfx( "drone_beacon_red_slow_nolight" ), self, "TAG_FX_BEACON_1" );
    playfxontag( common_scripts\utility::getfx( "drone_beacon_red_fast" ), self, "TAG_FX_BEACON_2" );
}

drone_deer_spot_light( var_0 )
{
    wait 0.1;
    stopfxontag( common_scripts\utility::getfx( "drone_search_lt" ), var_0, "tag_origin" );
    wait 0.05;
    playfxontag( common_scripts\utility::getfx( "spotlight_drone_deer" ), var_0, "tag_origin" );
    wait 8;
    killfxontag( common_scripts\utility::getfx( "spotlight_drone_deer" ), var_0, "tag_origin" );
    wait 0.05;
    playfxontag( common_scripts\utility::getfx( "drone_search_lt" ), var_0, "tag_origin" );
}

forest_takedown_fx()
{
    wait 1.4;
    common_scripts\_exploder::exploder( "2400" );
    level notify( "vfx_treadfx_littlebird_off" );
}

burke_tree_slide_fx()
{
    wait 0.1;
    common_scripts\_exploder::exploder( "2300" );
}

mute_device_plant_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "lab_mute_device_plant_vm" ), var_0, "tag_vfx_attach" );
    wait 0.15;
    playfxontag( common_scripts\utility::getfx( "lab_mute_device_lights" ), var_0, "spinner" );
    wait 10;
    stopfxontag( common_scripts\utility::getfx( "lab_mute_device_lights" ), var_0, "spinner" );
    stopfxontag( common_scripts\utility::getfx( "lab_mute_device_plant_vm" ), var_0, "tag_vfx_attach" );
}

mute_breach_explosion()
{
    common_scripts\_exploder::exploder( "fx_door_breach_explosion" );
    wait 15;
    common_scripts\_exploder::kill_exploder( "fx_door_breach_explosion" );
}

thermite_grenade_1_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "thermite_grenade_ignite" ), var_0, "tag_fx" );
    wait 6;
    common_scripts\_exploder::exploder( "thermite_fire_wall_1" );
}

thermite_grenade_2_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "thermite_grenade_ignite" ), var_0, "tag_fx" );
    wait 6;
    common_scripts\_exploder::exploder( "thermite_fire_wall_2" );
}

thermite_grenade_3_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "thermite_grenade_ignite" ), var_0, "tag_fx" );
    wait 6;
    common_scripts\_exploder::exploder( "thermite_fire_wall_3" );
}

thermite_servers_explosion()
{
    common_scripts\utility::flag_wait( "vfx_server_room_exit" );
    maps\_utility::delaythread( 1, common_scripts\_exploder::exploder, "thermite_smoke" );
}

hillslide_dust_fx( var_0 )
{
    wait 0.25;
    playfxontag( common_scripts\utility::getfx( "dust_foot_hillslide" ), var_0, "J_Ball_LE" );
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "dust_foot_hillslide" ), var_0, "J_Ball_RI" );
    wait 5.0;
}

tree_head_impact()
{

}

fx_pnematic_anchor( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "lab_pnematic_anchor" ), var_0, "tag_origin" );
}

birds_scatter_cliff_rappel()
{
    var_0 = getent( "trigger_birds", "targetname" );
    var_0 waittill( "trigger" );
    common_scripts\_exploder::exploder( 3100 );
}

logging_road_mud_tracks()
{
    self endon( "vehicle_stopping" );
    playfxontag( common_scripts\utility::getfx( "lab_gaz_mud_tracks" ), self, "tag_wheel_back_left_fx" );
    playfxontag( common_scripts\utility::getfx( "lab_gaz_mud_tracks" ), self, "tag_wheel_back_right_fx" );
    maps\_utility::ent_flag_init( "fx_tire_mud_1_on" );
    maps\_utility::ent_flag_wait( "fx_tire_mud_1_on" );
    playfxontag( common_scripts\utility::getfx( "lab_gaz_mud_tracks_2" ), self, "tag_wheel_back_left_fx" );
    playfxontag( common_scripts\utility::getfx( "lab_gaz_mud_tracks_2" ), self, "tag_wheel_back_right_fx" );
    maps\_utility::ent_flag_init( "fx_tire_mud_1_off" );
    maps\_utility::ent_flag_wait( "fx_tire_mud_1_off" );
    stopfxontag( common_scripts\utility::getfx( "lab_gaz_mud_tracks_2" ), self, "tag_wheel_back_left_fx" );
    stopfxontag( common_scripts\utility::getfx( "lab_gaz_mud_tracks_2" ), self, "tag_wheel_back_right_fx" );
}

logging_road_mud_tracks_2()
{
    self endon( "vehicle_stopping" );
    playfxontag( common_scripts\utility::getfx( "lab_gaz_mud_tracks" ), self, "tag_wheel_back_left_fx" );
    playfxontag( common_scripts\utility::getfx( "lab_gaz_mud_tracks" ), self, "tag_wheel_back_right_fx" );
    maps\_utility::ent_flag_init( "fx_tire_mud_2_on" );
    maps\_utility::ent_flag_wait( "fx_tire_mud_2_on" );
    playfxontag( common_scripts\utility::getfx( "lab_gaz_mud_tracks_2" ), self, "tag_wheel_back_left_fx" );
    playfxontag( common_scripts\utility::getfx( "lab_gaz_mud_tracks_2" ), self, "tag_wheel_back_right_fx" );
    maps\_utility::ent_flag_init( "fx_tire_mud_2_off" );
    maps\_utility::ent_flag_wait( "fx_tire_mud_2_off" );
    stopfxontag( common_scripts\utility::getfx( "lab_gaz_mud_tracks_2" ), self, "tag_wheel_back_left_fx" );
    stopfxontag( common_scripts\utility::getfx( "lab_gaz_mud_tracks_2" ), self, "tag_wheel_back_right_fx" );
}

vfx_foam_room()
{
    level waittill( "vfx_foam_room_explode_start" );
    common_scripts\_exploder::exploder( 5500 );
    maps\_utility::stop_exploder( 5010 );
    wait 1;
    common_scripts\_exploder::exploder( 5507 );
    wait 10;
    maps\_utility::pauseexploder( 5500 );
    wait 70;
    maps\_utility::stop_exploder( 5507 );
}

mech_intro_land_dust( var_0 )
{
    wait 0.15;
    playfxontag( common_scripts\utility::getfx( "mech_impact_dust" ), var_0, "TAG_ORIGIN" );
}

vfx_htank_reveal( var_0 )
{
    maps\_utility::delaythread( 0, ::vfx_htank_exhaust_smk_burst );
    maps\_utility::delaythread( 0.1, ::vfx_htank_exhaust_electricity_powerup );
    common_scripts\utility::flag_set( "thruster_big" );
    maps\_utility::delaythread( 0.4, ::vfx_htank_thruster_light_flicker, var_0 );
    maps\_utility::delaythread( 0.45, ::vfx_htank_thruster_start, var_0 );
    maps\_utility::delaythread( 0.7, ::vfx_htank_fake_treadfx_strong );
    maps\_utility::delaythread( 12, ::vfx_htank_thruster_regular, var_0 );
    maps\_utility::delaythread( 12.9, ::vfx_htank_disengage_grnd_smk );
    maps\_utility::delaythread( 14.5, ::vfx_htank_fake_treadfx_regular );
}

vfx_htank_exhaust_smk_burst()
{
    common_scripts\_exploder::exploder( 7702 );
    wait 0.7;
    maps\_utility::pauseexploder( 7702 );
}

vfx_htank_exhaust_electricity_powerup()
{
    common_scripts\_exploder::kill_exploder( 7021 );
    common_scripts\_exploder::kill_exploder( 7023 );
    common_scripts\_exploder::kill_exploder( 7022 );
    thread maps\lab_lighting::turn_off_top_tank_lights();
    common_scripts\_exploder::exploder( 7622 );
    common_scripts\_exploder::exploder( 7701 );
}

vfx_htank_thruster_start( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "hovertank_exhaust_strong" ), var_0, "thruster_FL_FX" );
    playfxontag( common_scripts\utility::getfx( "hovertank_exhaust_strong" ), var_0, "thruster_FR_FX" );
    playfxontag( common_scripts\utility::getfx( "hovertank_exhaust_strong" ), var_0, "thruster_KL_FX" );
    playfxontag( common_scripts\utility::getfx( "hovertank_exhaust_strong" ), var_0, "thruster_KR_FX" );
    level waittill( "msg_vfx_htank_thrust_regular" );
    waitframe();
    stopfxontag( common_scripts\utility::getfx( "hovertank_exhaust_strong" ), var_0, "thruster_FL_FX" );
    stopfxontag( common_scripts\utility::getfx( "hovertank_exhaust_strong" ), var_0, "thruster_FR_FX" );
    stopfxontag( common_scripts\utility::getfx( "hovertank_exhaust_strong" ), var_0, "thruster_KL_FX" );
    stopfxontag( common_scripts\utility::getfx( "hovertank_exhaust_strong" ), var_0, "thruster_KR_FX" );
}

vfx_htank_thruster_light_flicker( var_0 )
{
    var_1 = getent( "tank_top_light_01", "targetname" );
    thread vfx_htank_thruster_light_flicker_off( var_0, var_1 );
    common_scripts\utility::flag_wait( "thruster_big" );
    stopfxontag( common_scripts\utility::getfx( "hovertank_exhaust_light_flicker_dualSM" ), var_0, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "hovertank_exhaust_light_flicker_dual" ), var_0, "tag_origin" );
    wait 25;
    common_scripts\utility::flag_waitopen( "thruster_big" );
    var_1 setlightshadowstate( "force_on" );
    stopfxontag( common_scripts\utility::getfx( "hovertank_exhaust_light_flicker_dual" ), var_0, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "hovertank_exhaust_light_flicker_dualSM" ), var_0, "tag_origin" );
}

vfx_htank_thruster_light_flicker_off( var_0, var_1 )
{
    level waittill( "msg_vfx_player_in_tank" );
    var_1 setlightshadowstate( "normal" );
    stopfxontag( common_scripts\utility::getfx( "hovertank_exhaust_light_flicker_dualSM" ), var_0, "tag_origin" );
}

vfx_htank_fake_treadfx_strong()
{
    common_scripts\_exploder::exploder( 7711 );
    level waittill( "msg_vfx_htank_thrust_regular" );
    wait 0.25;
    maps\_utility::pauseexploder( 7711 );
}

vfx_htank_thruster_regular( var_0 )
{
    level notify( "msg_vfx_htank_thrust_regular" );
    playfxontag( common_scripts\utility::getfx( "hovertank_exhaust_regular" ), var_0, "thruster_FL_FX" );
    playfxontag( common_scripts\utility::getfx( "hovertank_exhaust_regular" ), var_0, "thruster_FR_FX" );
    playfxontag( common_scripts\utility::getfx( "hovertank_exhaust_regular" ), var_0, "thruster_KL_FX" );
    playfxontag( common_scripts\utility::getfx( "hovertank_exhaust_regular" ), var_0, "thruster_KR_FX" );
    level waittill( "msg_vfx_player_in_tank" );
    stopfxontag( common_scripts\utility::getfx( "hovertank_exhaust_regular" ), var_0, "thruster_FL_FX" );
    stopfxontag( common_scripts\utility::getfx( "hovertank_exhaust_regular" ), var_0, "thruster_FR_FX" );
    stopfxontag( common_scripts\utility::getfx( "hovertank_exhaust_regular" ), var_0, "thruster_KL_FX" );
    stopfxontag( common_scripts\utility::getfx( "hovertank_exhaust_regular" ), var_0, "thruster_KR_FX" );
}

vfx_htank_disengage_grnd_smk()
{
    common_scripts\_exploder::exploder( 7703 );
    wait 0.35;
    common_scripts\_exploder::exploder( 7704 );
    wait 2;
    maps\_utility::pauseexploder( 7703 );
}

vfx_htank_fake_treadfx_regular()
{
    common_scripts\_exploder::exploder( 7712 );
    level waittill( "msg_vfx_player_in_tank" );
    maps\_utility::pauseexploder( 7712 );
}

se_exfil_fx()
{
    maps\_utility::delaythread( 0.4, vehicle_scripts\_razorback_fx::play_back_thruster_light_rz );
    maps\_utility::delaythread( 0.45, vehicle_scripts\_razorback_fx::play_front_thruster_light_rz );
    maps\_utility::delaythread( 3.8, vehicle_scripts\_razorback_fx::stop_back_thruster_light_rz );
    maps\_utility::delaythread( 6.5, vehicle_scripts\_razorback_fx::stop_front_thruster_light_rz );
    common_scripts\utility::flag_wait( "flag_player_exfil_enter" );
    wait 15;
}

vfx_htank_explosion( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "hovertank_death_explosion_initial" ), level.hovertank_exterior_model, "TAG_DEATH_FX" );
    soundscripts\_snd::snd_message( "tank_exfil_charges" );
    wait 0.5;
    playfxontag( common_scripts\utility::getfx( "hovertank_death_explosion" ), level.hovertank_exterior_model, "TAG_DEATH_FX" );

    if ( isdefined( level.hovertank_exterior_model ) )
        level.hovertank_exterior_model common_scripts\utility::delaycall( 0.5, ::setmodel, "vehicle_mil_hovertank_dstrypv" );

    soundscripts\_snd::snd_message( "tank_exfil_detonate" );
    maps\_utility::delaythread( 2.7, common_scripts\_exploder::exploder, 10001 );
    maps\_utility::delaythread( 2.8, common_scripts\_exploder::exploder, 10002 );
}
