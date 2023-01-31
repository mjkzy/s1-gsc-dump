// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    precachefx();
    maps\createfx\recovery_fx::main();

    if ( !isdefined( level.createfxent ) )
        level.createfxent = [];

    maps\_shg_fx::setup_shg_fx();
    thread maps\_shg_fx::fx_zone_watcher( 800, "msg_fx_zone_funeral" );
    thread maps\_shg_fx::fx_zone_watcher( 1000, "msg_fx_zone_golf_course", "msg_fx_zone_golf_course01" );
    thread maps\_shg_fx::fx_zone_watcher( 1001, "msg_fx_zone_golf_course02", "msg_fx_zone_golf_course03" );
    thread maps\_shg_fx::fx_zone_watcher( 1002, "msg_fx_zone_window_rain", "msg_fx_zone_window_rain01" );
    thread maps\_shg_fx::fx_zone_watcher( 1003, "msg_fx_zone_behind_house" );
    thread maps\_shg_fx::fx_zone_watcher( 1004, "msg_fx_zone1004_inside_house" );
    thread maps\_shg_fx::fx_zone_watcher( 2000, "msg_fx_zone_tour" );
    thread maps\_shg_fx::fx_zone_watcher( 3000, "msg_fx_zone_elevator", "msg_fx_zone_elevator", "msg_fx_zone_golf_course" );
    thread treadfx_override();
    thread golfcourse_treadfx_override();
}

precachefx()
{
    level._effect["flashlight"] = loadfx( "vfx/lights/flashlight_recovery" );
    level._effect["flesh_hit"] = loadfx( "vfx/weaponimpact/flesh_impact_body_fatal_exit" );
    level._effect["expround_asphalt_1"] = loadfx( "vfx/weaponimpact/expround_asphalt_1" );
    level._effect["frag_grenade_default"] = loadfx( "vfx/explosion/frag_grenade_default" );
    level._effect["recovery_scoring_add1"] = loadfx( "vfx/map/recovery/recovery_scoring_add1" );
    level._effect["recovery_scoring_add2"] = loadfx( "vfx/map/recovery/recovery_scoring_add2" );
    level._effect["recovery_scoring_add25"] = loadfx( "vfx/map/recovery/recovery_scoring_add25" );
    level._effect["recovery_scoring_add50"] = loadfx( "vfx/map/recovery/recovery_scoring_add50" );
    level._effect["recovery_scoring_add75"] = loadfx( "vfx/map/recovery/recovery_scoring_add75" );
    level._effect["recovery_scoring_add100"] = loadfx( "vfx/map/recovery/recovery_scoring_add100" );
    level._effect["recovery_scoring_minus1"] = loadfx( "vfx/map/recovery/recovery_scoring_minus1" );
    level._effect["recovery_scoring_minus2"] = loadfx( "vfx/map/recovery/recovery_scoring_minus2" );
    level._effect["recovery_scoring_minus25"] = loadfx( "vfx/map/recovery/recovery_scoring_minus25" );
    level._effect["recovery_scoring_minus50"] = loadfx( "vfx/map/recovery/recovery_scoring_minus50" );
    level._effect["recovery_scoring_minus75"] = loadfx( "vfx/map/recovery/recovery_scoring_minus75" );
    level._effect["recovery_scoring_minus100"] = loadfx( "vfx/map/recovery/recovery_scoring_minus100" );
    level._effect["recovery_scoring_target_shutter_enemy"] = loadfx( "vfx/map/recovery/recovery_scoring_target_shutter" );
    level._effect["recovery_scoring_target_shutter_friendly"] = loadfx( "vfx/map/recovery/recovery_scoring_hostage_shutter" );
    level._effect["firing_range_edge_glow"] = loadfx( "vfx/beam/firing_range_edge_glow" );
    level._effect["firing_range_edge_glow_off"] = loadfx( "vfx/beam/firing_range_edge_glow_off" );
    level._effect["firing_range_glow_flicker_rnr_lp"] = loadfx( "vfx/beam/firing_range_glow_flicker_rnr_lp" );
    level._effect["boost_dust_npc"] = loadfx( "vfx/smoke/jetpack_exhaust_npc" );
    level._effect["boost_dust_impact_ground"] = loadfx( "vfx/smoke/jetpack_ground_impact_runner" );
    level._effect["landass_exhaust_smk_rt_npc"] = loadfx( "vfx/smoke/landass_exhaust_smk_rt_npc" );
    level._effect["landass_exhaust_smk_lf_npc"] = loadfx( "vfx/smoke/landass_exhaust_smk_lf_npc" );
    level._effect["landass_impact_smk_rnr"] = loadfx( "vfx/smoke/landass_impact_smk_rnr" );
    level._effect["lightning"] = loadfx( "vfx/map/recovery/recovery_lightning_flash" );
    level._effect["recovery_sun_flare"] = loadfx( "vfx/map/recovery/recovery_sun_flare" );
    level._effect["recovery_sun_flare_funeral"] = loadfx( "vfx/map/recovery/recovery_sun_flare_funeral" );
    level._effect["recovery_skylight_grp_flare"] = loadfx( "vfx/map/recovery/recovery_skylight_grp_flare" );
    level._effect["recovery_surgical_flare"] = loadfx( "vfx/map/recovery/recovery_surgical_flare" );
    level._effect["recovery_rectangle_flare"] = loadfx( "vfx/map/recovery/recovery_rectangle_flare" );
    level._effect["recovery_range_flare"] = loadfx( "vfx/map/recovery/recovery_range_flare" );
    level._effect["recovery_tv_flare"] = loadfx( "vfx/map/recovery/recovery_tv_flare" );
    level._effect["recovery_tv_sm_flare"] = loadfx( "vfx/map/recovery/recovery_tv_sm_flare" );
    level._effect["recovery_ceiling_light_flare_02"] = loadfx( "vfx/map/recovery/recovery_ceiling_light_flare_02" );
    level._effect["recovery_hanging_light_flare"] = loadfx( "vfx/map/recovery/recovery_hanging_light_flare" );
    maps\_weather::addlightningexploder( 10 );
    maps\_weather::addlightningexploder( 11 );
    maps\_weather::addlightningexploder( 12 );
    level.nextlightning = gettime() + 1;
    level._effect["petals_fall_cherry_gentlewind_no_physics"] = loadfx( "vfx/wind/petals_fall_cherry_gentlewind_no_physics" );
    level._effect["leaves_fall_twirl_small_no_physics"] = loadfx( "vfx/wind/leaves_fall_twirl_small_no_physics" );
    level._effect["petals_fall_cherry_gentlewind_physics"] = loadfx( "vfx/wind/petals_fall_cherry_gentlewind_physics" );
    level._effect["cg_fx_light_1"] = loadfx( "vfx/map/recovery/recov_character_light_1_cg" );
    level._effect["cg_fx_light_2"] = loadfx( "vfx/map/recovery/recov_character_light_2_cg" );
    level._effect["cg_fx_light_3"] = loadfx( "vfx/map/recovery/recov_character_light_3_cg" );
    level._effect["cg_fx_light_4"] = loadfx( "vfx/map/recovery/recov_character_light_4_cg" );
    level._effect["cg_fx_light_4a"] = loadfx( "vfx/map/recovery/recov_character_light_4a_cg" );
    level._effect["cg_fx_light_5"] = loadfx( "vfx/map/recovery/recov_character_light_5_cg" );
    level._effect["cg_fx_light_5a"] = loadfx( "vfx/map/recovery/recov_character_light_5a_cg" );
    level._effect["cg_fx_light_jeep_runner"] = loadfx( "vfx/map/recovery/recov_character_light_jeep_runner_cg" );
    level._effect["raindrop_single"] = loadfx( "vfx/rain/raindrop_single" );
    level._effect["rain_hvy_dense_windy_01"] = loadfx( "vfx/rain/rain_hvy_dense_windy_01" );
    level._effect["rain_hvy_dense_windy_outside"] = loadfx( "vfx/rain/rain_hvy_dense_windy_outside" );
    level._effect["rain_hvy_dense_windy_small"] = loadfx( "vfx/rain/rain_hvy_dense_windy_small" );
    level._effect["rain_hvy_dense_windy_small_bright"] = loadfx( "vfx/rain/rain_hvy_dense_windy_small_bright" );
    level._effect["rain_hvy_dense_windy_small_outside"] = loadfx( "vfx/rain/rain_hvy_dense_windy_small_outside" );
    level._effect["rain_splat_on_lens_med_rnr_night"] = loadfx( "vfx/map/recovery/rain_splat_on_lens_med_rnr_night" );
    level._effect["rain_hvy_dense_windy_window"] = loadfx( "vfx/rain/rain_hvy_dense_windy_window" );
    level._effect["raindrop_rings_area_med"] = loadfx( "vfx/rain/raindrop_rings_area_med" );
    level._effect["raindrop_rings_area"] = loadfx( "vfx/rain/raindrop_rings_area" );
    level._effect["leaves_fall_gentlewind_no_physics"] = loadfx( "vfx/wind/leaves_fall_gentlewind_no_physics" );
    level._effect["recovery_amb_ground_mist"] = loadfx( "vfx/map/recovery/recovery_amb_ground_mist" );
    level._effect["recovery_rain_floor_sheet"] = loadfx( "vfx/map/recovery/recovery_rain_floor_sheet" );
    level._effect["recovery_wind_gust_mist_distant_lrg"] = loadfx( "vfx/map/recovery/recovery_wind_gust_mist_distant_lrg" );
    level._effect["recovery_lampost_flare"] = loadfx( "vfx/map/recovery/recovery_lampost_flare" );
    level._effect["drone_search_lt_recovery"] = loadfx( "vfx/lights/drone_search_lt_recovery" );
    level._effect["recovery_gideon_hit"] = loadfx( "vfx/map/recovery/recovery_gideon_hit" );
    level._effect["recovery_dust_falling_debris_single"] = loadfx( "vfx/map/recovery/recovery_dust_falling_debris_single" );
    level._effect["exo_door_hinge_piece"] = loadfx( "vfx/props/exo_door_hinge_piece" );
    level._effect["recovery_dust_burst_round"] = loadfx( "vfx/map/recovery/recovery_dust_burst_round" );
    level._effect["recovery_dust_burst_round_high"] = loadfx( "vfx/map/recovery/recovery_dust_burst_round_high" );
    level._effect["recovery_dust_burst_round_french"] = loadfx( "vfx/map/recovery/recovery_dust_burst_round_french" );
    level._effect["recovery_wood_door_break"] = loadfx( "vfx/map/recovery/recovery_wood_door_break" );
    level._effect["sparks_short_circuits_small"] = loadfx( "vfx/sparks/sparks_short_circuits_small" );
    level._effect["large_wood"] = loadfx( "vfx/weaponimpact/large_wood" );
    level._effect["lab_mute_device_plant_vm"] = loadfx( "vfx/map/lab/lab_mute_device_plant_vm" );
    level._effect["lab_mute_area_distort_player_view"] = loadfx( "vfx/map/lab/lab_mute_area_distort_player_view" );
    level._effect["lab_mute_device_lights"] = loadfx( "vfx/map/lab/lab_mute_device_lights" );
    level._effect["mute_breach_distort_vm_enter"] = loadfx( "vfx/props/mute_breach_distort_vm_enter" );
    level._effect["mute_breach_distort_vm_exit"] = loadfx( "vfx/props/mute_breach_distort_vm_exit" );
    level._effect["recovery_blood_impact_burst"] = loadfx( "vfx/map/recovery/recovery_blood_impact_burst" );
    level._effect["heli_dust_rain"] = loadfx( "vfx/treadfx/heli_dust_rain" );
    level._effect["heli_dust_rain_idle"] = loadfx( "vfx/treadfx/heli_dust_rain_idle" );
    level._effect["car_tread_water_splash"] = loadfx( "vfx/treadfx/car_tread_water_splash" );
    level._effect["leaves_windblown_slw"] = loadfx( "vfx/wind/leaves_windblown_slw" );
    level._effect["recovery_wind_gust_gate_open"] = loadfx( "vfx/map/recovery/recovery_wind_gust_gate_open" );
    level._effect["splinter_wood_blind_damage"] = loadfx( "vfx/map/recovery/splinter_wood_blind_damage" );
    level._effect["blind_pieces_fall"] = loadfx( "vfx/map/recovery/blind_pieces_fall" );
    level._effect["glass_shatter_large"] = loadfx( "vfx/glass/glass_shatter_large" );
    level._effect["glass_hit_large"] = loadfx( "vfx/glass/glass_hit_large" );
    level._effect["glass_falling_debris_02"] = loadfx( "vfx/glass/glass_falling_debris_02" );
    level._effect["walker_tank_footstep_dust"] = loadfx( "vfx/treadfx/walker_tank_footstep_dust" );
    level._effect["tread_dust_sedan_bright"] = loadfx( "vfx/treadfx/tread_dust_sedan_bright" );
    level._effect["tread_dust_van_bright"] = loadfx( "vfx/treadfx/tread_dust_van_bright" );
    level._effect["welding_sparks_oneshot_sml"] = loadfx( "vfx/sparks/welding_sparks_oneshot_sml" );
    level._effect["sparks_friction"] = loadfx( "vfx/sparks/sparks_friction" );
    level._effect["tread_dust_sedan_bright"] = loadfx( "vfx/treadfx/tread_dust_sedan_bright" );
    level._effect["titan_tread_impact"] = loadfx( "vfx/treadfx/titan_tread_impact" );
    level._effect["truck_tire_tread"] = loadfx( "vfx/treadfx/truck_tire_tread" );
    level._effect["tread_dust_ft101_tank"] = loadfx( "vfx/treadfx/tread_dust_ft101_tank" );
    level._effect["veh_default_front_signal_light_l"] = loadfx( "vfx/lights/veh_default_front_signal_light_l" );
    level._effect["veh_default_front_signal_light_r"] = loadfx( "vfx/lights/veh_default_front_signal_light_r" );
    level._effect["vehicle_civ_ai_explo_small_runner"] = loadfx( "vfx/explosion/vehicle_civ_ai_explo_small_runner" );
    level._effect["firelp_small"] = loadfx( "vfx/fire/firelp_small" );
    level._effect["recovery_spotlight_flare_01"] = loadfx( "vfx/map/recovery/recovery_spotlight_flare_01" );
    level._effect["recovery_ceiling_light_flare_01"] = loadfx( "vfx/map/recovery/recovery_ceiling_light_flare_01" );
    level._effect["cloud_bank"] = loadfx( "vfx/wind/cloud_bank" );
    level._effect["titan_tread_kickup_front"] = loadfx( "vfx/treadfx/titan_tread_kickup_front" );
    level._effect["titan_tread_kickup_back"] = loadfx( "vfx/treadfx/titan_tread_kickup_back" );
    level._effect["car_tread_mud"] = loadfx( "vfx/treadfx/car_tread_mud" );
    level._effect["car_tread_mud_dense"] = loadfx( "vfx/treadfx/car_tread_mud_dense" );
    level._effect["test_axis_2"] = loadfx( "vfx/test/test_axis_2" );
}

vfx_raindrop( var_0 )
{
    wait 0.3;
    common_scripts\_exploder::exploder( "vfx_raindrop" );
    wait 9;
    common_scripts\_exploder::kill_exploder( "vfx_raindrop" );
}

lightning_flash( var_0 )
{
    level notify( "emp_lighting_flash" );
    level endon( "emp_lighting_flash" );

    if ( level.createfx_enabled )
        return;

    var_1 = randomintrange( 1, 4 );

    if ( !isdefined( var_0 ) )
        var_0 = ( -20, 60, 0 );

    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        var_3 = randomint( 3 );

        switch ( var_3 )
        {
            case 0:
                wait 0.05;
                setsunlight( 1, 1, 1.2 );
                wait 0.05;
                setsunlight( 2, 2, 2.5 );
                break;
            case 1:
                wait 0.05;
                setsunlight( 1, 1, 1.2 );
                wait 0.05;
                setsunlight( 2, 2, 2.5 );
                wait 0.05;
                setsunlight( 3, 3, 3.7 );
                break;
            case 2:
                wait 0.05;
                setsunlight( 1, 1, 1.2 );
                wait 0.05;
                setsunlight( 2, 2, 2.5 );
                wait 0.05;
                setsunlight( 3, 3, 3.7 );
                wait 0.05;
                setsunlight( 2, 2, 2.5 );
                break;
        }

        wait(randomfloatrange( 0.05, 0.1 ));
        lightning_normal();
    }

    lightning_normal();
}

lightning_normal()
{
    resetsunlight();
    resetsundirection();
}

drone_search_light_fx()
{
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "drone_search_lt_recovery" ), self, "tag_origin" );
    soundscripts\_snd::snd_message( "rec_drone_scanner" );
    playfxontag( common_scripts\utility::getfx( "drone_beacon_blue_slow_nolight" ), self, "TAG_FX_BEACON_0" );
    playfxontag( common_scripts\utility::getfx( "drone_beacon_blue_slow_nolight" ), self, "TAG_FX_BEACON_1" );
    playfxontag( common_scripts\utility::getfx( "drone_beacon_blue_fast" ), self, "TAG_FX_BEACON_2" );
}

mute_fx_on( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "lab_mute_device_plant_vm" ), var_0, "tag_vfx_attach" );
    wait 0.15;
    playfxontag( common_scripts\utility::getfx( "lab_mute_device_lights" ), var_0, "spinner" );
    level waittill( "disable_mute_breach_fx" );
    stopfxontag( common_scripts\utility::getfx( "lab_mute_device_lights" ), var_0, "spinner" );
    stopfxontag( common_scripts\utility::getfx( "lab_mute_device_plant_vm" ), var_0, "tag_vfx_attach" );
}

breach_office_door( var_0 )
{
    wait 0.5;
    common_scripts\_exploder::exploder( "officedoor_breach" );
    wait 10;
    common_scripts\_exploder::kill_exploder( "officedoor_breach" );
}

kva_hit_glass_impact( var_0 )
{
    wait 0.01;
    common_scripts\_exploder::exploder( "glass_hit" );
    wait 0.4;
    common_scripts\_exploder::exploder( "sparks_short_circuits" );
    wait 6;
    common_scripts\_exploder::kill_exploder( "glass_hit" );
    common_scripts\_exploder::kill_exploder( "sparks_short_circuits" );
}

training_escape_gideon_punch( var_0 )
{
    wait 0.005;
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 _meth_804D( var_0, "j_mid_le_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    playfxontag( common_scripts\utility::getfx( "recovery_gideon_hit" ), var_1, "tag_origin" );
    wait 3;
    var_1 delete();
}

training_s1_president_blood( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "recovery_blood_impact_burst" ), level.president, "j_head" );
}

training_escape_vehicle_1_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "car_tread_water_splash" ), var_0, "tag_wheel_back_right" );
    playfxontag( common_scripts\utility::getfx( "car_tread_water_splash" ), var_0, "tag_wheel_back_left" );
    playfxontag( common_scripts\utility::getfx( "car_tread_water_splash" ), var_0, "tag_wheel_front_right" );
    playfxontag( common_scripts\utility::getfx( "car_tread_water_splash" ), var_0, "tag_wheel_front_left" );
}

tour_jeep_tread( var_0 )
{
    wait 1;
    playfxontag( common_scripts\utility::getfx( "car_tread_mud_dense" ), var_0, "tag_wheel_back_right" );
    playfxontag( common_scripts\utility::getfx( "car_tread_mud_dense" ), var_0, "tag_wheel_back_left" );
    playfxontag( common_scripts\utility::getfx( "car_tread_mud_dense" ), var_0, "tag_wheel_front_right" );
    playfxontag( common_scripts\utility::getfx( "car_tread_mud_dense" ), var_0, "tag_wheel_front_left" );
    wait 8.5;
    stopfxontag( common_scripts\utility::getfx( "car_tread_mud_dense" ), var_0, "tag_wheel_back_right" );
    stopfxontag( common_scripts\utility::getfx( "car_tread_mud_dense" ), var_0, "tag_wheel_back_left" );
    stopfxontag( common_scripts\utility::getfx( "car_tread_mud_dense" ), var_0, "tag_wheel_front_right" );
    stopfxontag( common_scripts\utility::getfx( "car_tread_mud_dense" ), var_0, "tag_wheel_front_left" );
}

wind_gate_open( var_0 )
{
    wait 13;
    common_scripts\_exploder::exploder( "wind_gate_open" );
    common_scripts\_exploder::exploder( "gate_fx_light" );
    wait 5;
    common_scripts\_exploder::exploder( "leaves_gate_open" );
    wait 3;
    common_scripts\_exploder::exploder( "leaves_gate_open_delay" );
    wait 15;
    common_scripts\_exploder::kill_exploder( "wind_gate_open" );
    common_scripts\_exploder::kill_exploder( "leaves_gate_open" );
    common_scripts\_exploder::kill_exploder( "leaves_gate_open_delay" );
}

titan_gate_tread_fx( var_0 )
{
    wait 2;
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 _meth_804D( var_0, "ankle_fr", ( -50, 0, 10 ), ( 0, 0, 0 ) );
    playfxontag( common_scripts\utility::getfx( "titan_tread_kickup_front" ), var_1, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "titan_tread_kickup_front" ), var_0, "ankle_fl" );
    playfxontag( common_scripts\utility::getfx( "titan_tread_kickup_back" ), var_0, "ankle_KR" );
    playfxontag( common_scripts\utility::getfx( "titan_tread_kickup_back" ), var_0, "ankle_Kl" );
    wait 10;
    var_1 delete();
    common_scripts\_exploder::kill_exploder( "gate_fx_light" );
}

titan_impact_fx_fl( var_0 )
{
    wait 0.3;
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 _meth_804D( var_0, "frontWheelTread07_FL", ( 0, 0, 0 ), ( -16, 180, -10 ) );
    playfxontag( common_scripts\utility::getfx( "walker_tank_footstep_dust" ), var_1, "tag_origin" );
    earthquake( 0.15, 1.8, var_0.origin, 2000 );
    level notify( "titan_rumble" );
    wait 90;
    var_1 delete();
}

titan_impact_fx_fr( var_0 )
{
    wait 0.3;
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 _meth_804D( var_0, "frontWheelTread07_FR", ( 0, 0, 0 ), ( 45, 0, 0 ) );
    playfxontag( common_scripts\utility::getfx( "walker_tank_footstep_dust" ), var_1, "tag_origin" );
    earthquake( 0.15, 1.8, var_0.origin, 2000 );
    level notify( "titan_rumble" );
    wait 90;
    var_1 delete();
}

titan_impact_fx_rr( var_0 )
{
    wait 0.3;
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 _meth_804D( var_0, "frontWheelTread06_kR", ( 0, 0, 0 ), ( 0, 180, 0 ) );
    playfxontag( common_scripts\utility::getfx( "walker_tank_footstep_dust" ), var_1, "tag_origin" );
    earthquake( 0.15, 1.8, var_0.origin, 2000 );
    wait 90;
    var_1 delete();
}

titan_impact_fx_rl( var_0 )
{
    wait 0.3;
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 _meth_804D( var_0, "frontWheelTread06_KL", ( 100, 0, 100 ), ( 0, 180, 0 ) );
    playfxontag( common_scripts\utility::getfx( "walker_tank_footstep_dust" ), var_1, "tag_origin" );
    earthquake( 0.15, 1.8, var_0.origin, 2000 );
    wait 90;
    var_1 delete();
}

exo_push_sparks01_quake( var_0 )
{
    wait 0.01;
    earthquake( 0.2, 1, var_0.origin, 500 );
}

exo_push_sparks01( var_0 )
{
    level endon( "flag_obj_firing_range_pre" );
    wait 0.8;
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 _meth_804D( var_0, "hook_t", ( -46, 111, -125 ), ( 0, -90, 0 ) );
    playfxontag( common_scripts\utility::getfx( "sparks_friction" ), var_1, "tag_origin" );
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2 _meth_804D( var_0, "hook_t", ( -46, -18, -125 ), ( 0, -90, 0 ) );
    playfxontag( common_scripts\utility::getfx( "sparks_friction" ), var_2, "tag_origin" );
    wait 3.5;
    var_1 delete();
    var_2 delete();
}

exo_push_sparks02_quake( var_0 )
{
    wait 0.03;
    earthquake( 0.2, 1, var_0.origin, 500 );
}

exo_push_sparks02( var_0 )
{
    level endon( "flag_obj_firing_range_pre" );
    wait 0.6;
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 _meth_804D( var_0, "hook_t", ( -46, 111, -125 ), ( 0, -90, 0 ) );
    playfxontag( common_scripts\utility::getfx( "sparks_friction" ), var_1, "tag_origin" );
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2 _meth_804D( var_0, "hook_t", ( -46, -15, -125 ), ( 0, -90, 0 ) );
    playfxontag( common_scripts\utility::getfx( "sparks_friction" ), var_2, "tag_origin" );
    wait 7;
    var_1 delete();
    var_2 delete();
}

helicopter_landing( var_0 )
{
    common_scripts\_exploder::exploder( "helicopter_landing_small" );
    wait 2;
    maps\_utility::stop_exploder( "helicopter_landing_small" );
    common_scripts\_exploder::exploder( "helicopter_landing" );
    wait 20;
    maps\_utility::stop_exploder( "helicopter_landing" );
    common_scripts\_exploder::exploder( "helicopter_landing_small" );
    wait 4;
    maps\_utility::stop_exploder( "helicopter_landing_small" );
}

treadfx_override()
{
    wait 1;
    var_0[0] = "script_vehicle_vrap";
    var_1 = "vfx/treadfx/truck_tire_tread";

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
    }
}

golfcourse_treadfx_override()
{
    wait 1;
    var_0[0] = "script_vehicle_mil_gaz_ai_turret";
    var_1[0] = "script_vehicle_mil_gaz_ai";
    var_2 = "vfx/treadfx/car_tread_mud";

    foreach ( var_4 in var_1 )
    {
        maps\_vehicle::set_vehicle_effect( var_4, "brick", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "bark", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "carpet", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "cloth", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "concrete", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "dirt", var_2 );
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
        maps\_vehicle::set_vehicle_effect( var_4, "asphalt", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "ceramic", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "plastic", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "rubber", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "cushion", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "fruit", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "paintedmetal", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "riotshield", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "slush", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "default", var_2 );
    }

    foreach ( var_4 in var_0 )
    {
        maps\_vehicle::set_vehicle_effect( var_4, "brick", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "bark", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "carpet", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "cloth", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "concrete", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "dirt", var_2 );
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
        maps\_vehicle::set_vehicle_effect( var_4, "asphalt", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "ceramic", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "plastic", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "rubber", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "cushion", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "fruit", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "paintedmetal", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "riotshield", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "slush", var_2 );
        maps\_vehicle::set_vehicle_effect( var_4, "default", var_2 );
    }
}

firing_range_round_1_glow()
{
    wait 0.8;
    common_scripts\_exploder::exploder( 2100 );
}

firing_range_round_2_glow()
{
    wait 0.8;
    common_scripts\_exploder::exploder( 2200 );
}

firing_range_round_3_glow()
{
    wait 0.8;
    common_scripts\_exploder::exploder( 2300 );
}

firing_range_kill_glow()
{
    common_scripts\_exploder::kill_exploder( 2100 );
    common_scripts\_exploder::kill_exploder( 2200 );
    common_scripts\_exploder::kill_exploder( 2300 );
    common_scripts\_exploder::exploder( 2101 );
    common_scripts\_exploder::exploder( 2201 );
    common_scripts\_exploder::exploder( 2301 );
    wait 0.5;
    common_scripts\_exploder::kill_exploder( 2101 );
    common_scripts\_exploder::kill_exploder( 2201 );
    common_scripts\_exploder::kill_exploder( 2301 );
    common_scripts\_exploder::exploder( 2102 );
    common_scripts\_exploder::exploder( 2202 );
    common_scripts\_exploder::exploder( 2302 );
}

training_escape_vehicle_2_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "car_tread_water_splash" ), var_0, "tag_wheel_back_right" );
    playfxontag( common_scripts\utility::getfx( "car_tread_water_splash" ), var_0, "tag_wheel_back_left" );
    playfxontag( common_scripts\utility::getfx( "car_tread_water_splash" ), var_0, "tag_wheel_front_right" );
    playfxontag( common_scripts\utility::getfx( "car_tread_water_splash" ), var_0, "tag_wheel_front_left" );
}
