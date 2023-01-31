// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level._effect["bagh_water_fountain_short"] = loadfx( "vfx/map/baghdad/bagh_water_fountain_short" );
    level._effect["bagh_amb_smoke_dna_capture_strip"] = loadfx( "vfx/map/baghdad/bagh_amb_smoke_dna_capture_strip" );
    precache_fx();

    if ( !getdvarint( "r_reflectionProbeGenerate" ) )
        maps\createfx\df_baghdad_fx::main();

    if ( !isdefined( level.createfxent ) )
        level.createfxent = [];

    maps\_shg_fx::setup_shg_fx();
    thread maps\_shg_fx::vfx_sunflare( "bagh_sun_flare" );
    common_scripts\utility::flag_init( "msg_kill_canal_fx" );
    common_scripts\utility::flag_init( "msg_kill_ambient_war_fx" );
    level.fx_zone_messages = 0;
    thread maps\_shg_fx::fx_zone_watcher( 1000, "msg_fx_zone1000" );
    thread maps\_shg_fx::fx_zone_watcher( 2000, "msg_fx_zone2000" );
    thread maps\_shg_fx::fx_zone_watcher( 651, "msg_fx_zone2000" );
    thread fx_cam_view_test();
    thread intro_amb_canal_water_impacts();
    thread intro_amb_building_meteor_impacts();
    thread intro_amb_dirt_impacts();
}

precache_fx()
{
    level._effect["bagh_sun_flare"] = loadfx( "vfx/map/baghdad/bagh_sun_flare" );
    level._effect["hm_qn_smoke_column_med"] = loadfx( "vfx/test/hm_qn_smoke_column_med" );
    level._effect["smoke_crater_smolder_black"] = loadfx( "vfx/smoke/smoke_crater_smolder_black" );
    level._effect["trash_tornado_s_runner"] = loadfx( "vfx/wind/trash_tornado_s_runner" );
    level._effect["bagh_water_wall_splash"] = loadfx( "vfx/map/baghdad/bagh_water_wall_splash" );
    level._effect["bagh_water_fountain_tall"] = loadfx( "vfx/map/baghdad/bagh_water_fountain_tall" );
    level._effect["ground_sand_fine_flat_loop"] = loadfx( "vfx/sand/ground_sand_fine_flat_loop" );
    level._effect["wind_blowing_trash"] = loadfx( "vfx/wind/wind_blowing_trash" );
    level._effect["smoke_screen_loop_wind"] = loadfx( "vfx/smoke/smoke_screen_loop_wind" );
    level._effect["smoke_screen_emitter_wind"] = loadfx( "vfx/smoke/smoke_screen_emitter_wind" );
    level._effect["battlefield_smoke_windy_l"] = loadfx( "vfx/smoke/battlefield_smoke_windy_l" );
    level._effect["veh_suv_fire_1"] = loadfx( "vfx/destructible/veh_suv_fire_1" );
    level._effect["fire_lp_l_base_crawl_ground"] = loadfx( "vfx/fire/fire_lp_l_base_crawl_ground" );
    level._effect["fire_lp_s_base_windy"] = loadfx( "vfx/fire/fire_lp_s_base_windy" );
    level._effect["fire_lp_m_blacksmk_tall"] = loadfx( "vfx/fire/fire_lp_m_blacksmk_tall" );
    level._effect["dmg_fire_box"] = loadfx( "vfx/fire/dmg_fire_box" );
    level._effect["fire_crawl_interior_wall_med"] = loadfx( "vfx/fire/fire_crawl_interior_wall_med" );
    level._effect["fire_lrg_100x100_runner"] = loadfx( "vfx/fire/fire_lrg_100x100_runner" );
    level._effect["fire_pipe_leak_med"] = loadfx( "vfx/fire/fire_pipe_leak_med" );
    level._effect["fire_rocks_fallingdebris"] = loadfx( "vfx/fire/fire_rocks_fallingdebris" );
    level._effect["bagh_firealarm_blink"] = loadfx( "vfx/map/baghdad/bagh_firealarm_blink" );
    level._effect["ash_ember_cloud_freq_lrg_loop"] = loadfx( "vfx/map/baghdad/bagh_ash_ember_cloud_freq_lrg" );
    level._effect["fireball_lp_l_shortsmk"] = loadfx( "vfx/map/baghdad/fireball_lp_l_shortsmk" );
    level._effect["fireball_lp_l_dissipatesmkonly"] = loadfx( "vfx/map/baghdad/fireball_lp_l_dissipatesmkonly" );
    level._effect["fire_vista_lp_lrg_blacksmk_thick"] = loadfx( "vfx/fire/fire_vista_lp_lrg_blacksmk_thick" );
    level._effect["smoldering_smk_ground_vista_unlit_a"] = loadfx( "vfx/smoke/smoldering_smk_ground_vista_unlit_a" );
    level._effect["fire_vista_lp_sml_unlit"] = loadfx( "vfx/fire/fire_vista_lp_sml_unlit" );
    level._effect["bagh_fluorescent_smoke"] = loadfx( "vfx/lights/baghdad/bagh_fluorescent_smoke" );
    level._effect["bagh_atlas_holo"] = loadfx( "vfx/map/baghdad/bagh_atlas_holo" );
    level._effect["heli_dust_warbird"] = loadfx( "vfx/treadfx/heli_dust_warbird" );
    level._effect["bagh_intro_planter_chip"] = loadfx( "vfx/map/baghdad/bagh_intro_planter_chip" );
    level._effect["bagh_intro_planter_impact"] = loadfx( "vfx/map/baghdad/bagh_intro_planter_impact" );
    level._effect["bagh_intro_planter_chip"] = loadfx( "vfx/map/baghdad/bagh_intro_planter_chip" );
    level._effect["bagh_intro_planter_impact"] = loadfx( "vfx/map/baghdad/bagh_intro_planter_impact" );
    level._effect["bagh_intro_flak_runner"] = loadfx( "vfx/map/baghdad/bagh_intro_flak_runner" );
    level._effect["pod_exhaust_strong"] = loadfx( "vfx/vehicle/pod_exhaust_strong" );
    level._effect["bagh_pod_crash_dirt_trail"] = loadfx( "vfx/map/baghdad/bagh_pod_crash_dirt_trail" );
    level._effect["tread_dirt_thick"] = loadfx( "vfx/treadfx/tread_dirt_thick" );
    level._effect["pod_skid_stop"] = loadfx( "vfx/map/baghdad/pod_skid_stop" );
    level._effect["pod_tread_smk_regular_runner"] = loadfx( "vfx/treadfx/pod_tread_smk_regular_runner" );
    level._effect["bagh_pergola_snap"] = loadfx( "vfx/map/baghdad/bagh_pergola_snap" );
    level._effect["bagh_pod_flak_damage"] = loadfx( "vfx/map/baghdad/bagh_pod_flak_damage" );
    level._effect["bagh_dna_bomb_drone_loop"] = loadfx( "vfx/map/baghdad/bagh_dna_bomb_drone_loop" );
    level._effect["bagh_dna_bomb_drone_activate"] = loadfx( "vfx/map/baghdad/bagh_dna_bomb_drone_activate" );
    level._effect["bagh_dna_bomb_flyby_papers"] = loadfx( "vfx/map/baghdad/bagh_dna_bomb_flyby_papers" );
    level._effect["bagh_dna_bomb_explode"] = loadfx( "vfx/map/baghdad/bagh_dna_bomb_explode" );
    level._effect["bagh_dna_bomb_deploy_fluid"] = loadfx( "vfx/map/baghdad/bagh_dna_bomb_deploy_fluid" );
    level._effect["bagh_fire_crash_runner"] = loadfx( "vfx/map/baghdad/bagh_fire_crash_runner" );
    level._effect["bagh_fire_glow_crash"] = loadfx( "vfx/map/baghdad/bagh_fire_glow_crash" );
    level._effect["bagh_dna_bomb_fluid_crash"] = loadfx( "vfx/map/baghdad/bagh_dna_bomb_fluid_crash" );
    level._effect["veh_humvee_brakelight_r"] = loadfx( "vfx/vehicle/veh_humvee_brakelight_r" );
    level._effect["veh_humvee_brakelight_l"] = loadfx( "vfx/vehicle/veh_humvee_brakelight_l" );
    level._effect["bagh_mech_chest_light"] = loadfx( "vfx/map/baghdad/bagh_mech_chest_light" );
    level._effect["bagh_mech_fire_light"] = loadfx( "vfx/map/baghdad/bagh_mech_fire_light" );
    level._effect["bagh_amb_smoke_dna_aft_strip"] = loadfx( "vfx/map/baghdad/bagh_amb_smoke_dna_aft_strip" );
    level._effect["bagh_amb_smoke_dna_residue"] = loadfx( "vfx/map/baghdad/bagh_amb_smoke_dna_residue" );
    level._effect["bagh_amb_smoke_dna_aft"] = loadfx( "vfx/map/baghdad/bagh_amb_smoke_dna_aft" );
    level._effect["bagh_dna_embers"] = loadfx( "vfx/map/baghdad/bagh_dna_embers" );
    level._effect["ambient_explosion_gas_01"] = loadfx( "vfx/explosion/ambient_explosion_gas_01" );
    level._effect["bagh_ambient_waterspl_lg"] = loadfx( "vfx/map/baghdad/bagh_ambient_waterspl_lg" );
    level._effect["seo_ambexplo_air_nonlit_parent"] = loadfx( "vfx/map/seoul/seo_ambexplo_air_nonlit_parent" );
    level._effect["ambient_explosion_fireball"] = loadfx( "vfx/explosion/ambient_explosion_fireball" );
    level._effect["ambient_explosion_dirt_runner"] = loadfx( "vfx/explosion/ambient_explosion_dirt_runner" );
    level._effect["ambient_explosion_windowglass"] = loadfx( "vfx/explosion/ambient_explosion_windowglass" );
    level._effect["boat_wake_diveboat_splash_fast_trail"] = loadfx( "vfx/treadfx/boat_wake_diveboat_splash_fast_trail" );
    level._effect["boat_wake_diveboat_foam_trail"] = loadfx( "vfx/treadfx/boat_wake_diveboat_foam_trail" );
    level._effect["flesh_hit"] = loadfx( "vfx/weaponimpact/flesh_impact_body_fatal_exit" );
    level._effect["gib_death"] = loadfx( "vfx/blood/gib_full_body" );
    level._effect["vtol_explode"] = loadfx( "vfx/explosion/vehicle_warbird_explosion_midair" );
    level._effect["mech_drop_impact"] = loadfx( "vfx/code/exo_slam_boots_impact" );
}

fx_cam_view_test()
{
    thread maps\_shg_fx::exploder_to_array( 2 );
}

intro_infil_gideon_fx()
{
    common_scripts\utility::flag_wait( "start_intro_anims" );
    self waittillmatch( "single anim", "impact_ground" );
    self waittillmatch( "single anim", "stop_trail" );
}

intro_infil_knox_fx()
{
    common_scripts\utility::flag_wait( "start_intro_anims" );
    self waittillmatch( "single anim", "knox_leap" );
    self waittillmatch( "single anim", "knox_land" );
}

intro_infil_gideon_pod_fx()
{
    var_0 = common_scripts\utility::getfx( "bagh_pod_crash_dirt_trail" );
    var_1 = common_scripts\utility::getfx( "pod_skid_stop" );
    thread intro_infil_gideon_pod_dmg();
    common_scripts\utility::flag_wait( "start_intro_anims" );
    intro_pod_engine_fx( 1 );
    self waittillmatch( "single anim", "pod_skip" );
    playfxontag( var_0, self, "tag_origin" );
    wait 0.25;
    stopfxontag( var_0, self, "tag_origin" );
    self waittillmatch( "single anim", "pod_impact" );
    level notify( "gideon_pod_impact" );
    playfxontag( var_0, self, "tag_origin" );
    self waittillmatch( "single anim", "planter_hit" );
    common_scripts\_exploder::exploder( 800 );
    var_2 = common_scripts\utility::spawn_tag_origin();
    playfxontag( var_1, var_2, "tag_origin" );
    stopfxontag( var_0, self, "tag_origin" );
    intro_pod_engine_fx( 0 );
    self waittillmatch( "single anim", "pod_at_rest" );
}

intro_infil_gideon_pod_dmg()
{
    level waittill( "gideon_pod_dmg" );
    playfxontag( common_scripts\utility::getfx( "bagh_pod_flak_damage" ), self, "tag_body" );
    level waittill( "gideon_pod_impact" );
    stopfxontag( common_scripts\utility::getfx( "bagh_pod_flak_damage" ), self, "tag_body" );
}

intro_infil_knox_pod_fx()
{
    common_scripts\utility::flag_wait( "start_intro_anims" );
    intro_pod_engine_fx( 1 );
    self waittillmatch( "single anim", "end" );
    intro_pod_engine_fx( 0 );
}

intro_infil_player_pod_fx( var_0 )
{
    common_scripts\utility::flag_wait( "start_intro_anims" );
    intro_pod_engine_fx( 1 );
    self waittillmatch( "single anim", "flak1" );
    playfxontag( common_scripts\utility::getfx( "bagh_intro_flak_runner" ), self, "tag_origin" );
    self waittillmatch( "single anim", "flak2" );
    level notify( "gideon_pod_dmg" );
    self waittillmatch( "single anim", "start_pod_slide" );
    playfxontag( common_scripts\utility::getfx( "tread_dirt_thick" ), self, "tag_origin" );
    self waittillmatch( "single anim", "planter_slam" );
    common_scripts\_exploder::exploder( 801 );
    var_1 = common_scripts\utility::spawn_tag_origin();
    playfxontag( common_scripts\utility::getfx( "pod_skid_stop" ), var_1, "tag_origin" );
    stopfxontag( common_scripts\utility::getfx( "tread_dirt_thick" ), self, "tag_origin" );
    intro_pod_engine_fx( 0 );
    self waittillmatch( "single anim", "pod_at_rest" );
}

intro_infil_pergola_fx()
{
    common_scripts\utility::flag_wait( "start_intro_anims" );

    for ( var_0 = 1110; var_0 < 1115; var_0++ )
    {
        self waittillmatch( "single anim", "pergola_break" );
        common_scripts\_exploder::exploder( var_0 );
    }
}

intro_pod_engine_fx( var_0 )
{
    var_1 = common_scripts\utility::getfx( "pod_exhaust_strong" );

    if ( var_0 )
        playfxontag( var_1, self, "tag_exhaust" );
    else
        stopfxontag( var_1, self, "tag_exhaust" );
}

intro_warbird_wash_handler()
{
    common_scripts\utility::flag_wait( "flag_start_propwash1" );
    intro_warbird_wash_fx( 1 );
    common_scripts\utility::flag_wait( "flag_end_propwash1" );
    wait 7.5;
    intro_warbird_wash_fx( 0 );
}

intro_warbird_wash_fx( var_0 )
{
    if ( var_0 )
        thread intro_warbird_engine_wash_fx();
    else
        level notify( "intro_warbird_wash_stop" );
}

intro_warbird_engine_wash_fx()
{
    level endon( "intro_warbird_wash_stop" );

    for (;;)
    {
        intro_warbird_wash_trace( "tag_origin" );
        wait 0.1;
    }
}

intro_warbird_wash_trace( var_0 )
{
    var_1 = self gettagorigin( var_0 );
    var_2 = self gettagangles( var_0 );
    var_3 = common_scripts\utility::getfx( "heli_dust_warbird" );
    var_4 = bullettrace( var_1, var_1 + ( 0, 0, -5120 ), 0, undefined );
    var_5 = vectortoangles( var_4["normal"] );
    var_6 = anglestoforward( var_5 );
    playfx( var_3, var_4["position"], var_6 );
}

intro_ally_boost_fx()
{
    var_0 = common_scripts\utility::getfx( "boost_dust_npc" );
    playfxontag( var_0, self, "J_SpineLower" );
    wait 0.4;
    stopfxontag( var_0, self, "J_SpineLower" );
}

intro_zodiac_wake_fx()
{
    level endon( "player_at_meetup" );

    if ( !isdefined( self ) || _func_294( self ) )
        return;

    if ( isarray( self ) )
    {
        foreach ( var_1 in self )
        {
            if ( !isdefined( var_1 ) || _func_294( var_1 ) )
                continue;

            playfxontag( common_scripts\utility::getfx( "boat_wake_diveboat_foam_trail" ), var_1, "tag_origin" );
            waitframe();
        }
    }
}

vfx_dna_bomb_drone_swarm_setup()
{
    common_scripts\utility::flag_set( "msg_kill_ambient_war_fx" );

    foreach ( var_1 in level.floaters )
        var_1 thread vfx_dna_bomb_drone_setup();
}

vfx_dna_bomb_drone_setup()
{
    var_0 = common_scripts\utility::getfx( "bagh_dna_bomb_drone_loop" );
    var_1 = common_scripts\utility::getfx( "bagh_dna_bomb_drone_activate" );
    self waittill( "drone_activate" );
    playfxontag( var_0, self, "tag_origin" );
    self waittill( "drone_explode" );
    killfxontag( var_0, self, "tag_origin" );
}

vfx_dna_bomb_drone_activate()
{
    foreach ( var_1 in level.floaters )
    {
        var_1 notify( "drone_activate" );
        wait 0.05;
    }
}

vfx_dna_bomb_drone_explode()
{
    var_0 = common_scripts\utility::getfx( "bagh_dna_bomb_explode" );
    var_1 = 0;
    level.player _meth_83FE( 3, 0, 0, 4.75, 2.5, 2.25, 0, 50, 0, 0, 1 );
    level.player _meth_80AD( "dna_carpet_bomb" );

    foreach ( var_3 in level.floaters )
    {
        var_3 notify( "drone_explode" );
        var_3 hide();
        playfxontag( var_0, var_3, "tag_origin" );
        var_1++;
        wait 0.1;

        switch ( var_1 )
        {
            case 1:
                level notify( "dnabomb_explode01" );
                break;
            case 10:
                level notify( "dnabomb_explode02" );
                break;
            case 15:
                level notify( "dnabomb_explode03" );
                break;
        }
    }
}

vfx_dna_bomb_chain_explosion()
{
    self waittillmatch( "single anim", "dna_bombs_inview" );
    thread vfx_dna_bomb_drone_activate();
    self waittillmatch( "single anim", "activate_carpet_bombs" );
    self waittillmatch( "single anim", "start_carpet_bombs" );
    thread vfx_dna_bomb_drone_explode();
    self waittillmatch( "single anim", "last_carpet_bomb" );
    common_scripts\_exploder::kill_exploder( 651 );
    common_scripts\_exploder::kill_exploder( 2000 );
    common_scripts\_exploder::exploder( 650 );
}

vfx_dna_bomb_flyby_papers()
{
    self waittillmatch( "single anim", "kickup_papers" );
    common_scripts\_exploder::exploder( 600 );
    self waittillmatch( "single anim", "kickup_papers2" );
    level.player _meth_83FE( 0.25, 0, 0, 1.5, 0.2, 0.1, 0, 100, 0, 0, 2 );
    common_scripts\_exploder::exploder( 601 );
}

vfx_dna_bomb_mech_reveal()
{
    var_0 = common_scripts\utility::getfx( "bagh_mech_chest_light" );
    var_1 = common_scripts\utility::getfx( "bagh_mech_fire_light" );
    playfxontag( var_0, self, "tag_vfx_chest_light" );

    while ( isdefined( self ) )
        self waittillmatch( "single anim", "fire" );
}

vfx_dna_bomb_humvee_lights()
{
    level endon( "dnabomb_finished" );
    playfxontag( common_scripts\utility::getfx( "veh_humvee_brakelight_l" ), self, "tag_brakelight_left" );
    playfxontag( common_scripts\utility::getfx( "veh_humvee_brakelight_r" ), self, "tag_brakelight_right" );
    waitframe();
}

vfx_vtol_grapple()
{
    self waittillmatch( "single anim", "head_impact" );
    playfxontag( common_scripts\utility::getfx( "mech_blood_burst" ), self, "tag_weapon_chest" );
}

intro_amb_canal_water_impacts()
{
    wait 0.2;
    common_scripts\utility::flag_wait( "msg_fx_zone1000" );
    var_0 = [ ( -15311.8, 963.678, -622.377 ), ( -15519.9, -75.528, -622.555 ), ( -14923.7, 1779.02, -622.008 ), ( -14162.1, 3464.09, -643.932 ), ( -14291.6, -625.946, -619.876 ), ( -13501.1, 3753.49, -643.581 ), ( -13853.6, 2957.35, -643.418 ) ];
    var_1 = [ ( 270, 0, 0 ), ( 270, 0, 0 ), ( 270, 0, 0 ), ( 270, 0, 0 ), ( 270, 0, 0 ), ( 270, 0, 0 ), ( 270, 0, 0 ) ];
    thread maps\_shg_fx::start_fx_by_view( "bagh_ambient_waterspl_lg", var_0, 6, 4, "msg_kill_ambient_war_fx", 0, var_1, "water_exp_audio" );
}

intro_amb_building_meteor_impacts()
{
    wait 0.2;
    common_scripts\utility::flag_wait_either( "msg_fx_zone1000", "msg_fx_zone2000" );
    var_0 = [ ( -18361.8, -6941.33, 848.125 ), ( -7184.52, -12440.7, 2203.15 ), ( -7513.71, 7441.44, 683.13 ), ( -2974.46, -35.7348, 1190.53 ) ];
    var_1 = [ ( 308.277, 205.469, -101.159 ), ( 308.277, 205.469, -101.159 ), ( 308.277, 205.469, -101.159 ), ( 308.277, 205.469, -101.159 ) ];
    thread maps\_shg_fx::start_fx_by_view( "seo_ambexplo_air_nonlit_parent", var_0, 8, 4, "msg_kill_ambient_war_fx", 0, var_1, "midair_exp_audio" );
}

intro_amb_dirt_impacts()
{
    wait 0.2;
    common_scripts\utility::flag_wait_either( "msg_fx_zone1000", "msg_fx_zone2000" );
    var_0 = [ ( -11891.5, -2863.18, -497.597 ), ( -12455.7, -2386.9, -496.353 ), ( -11724.1, -3594.9, -368 ), ( -12967.6, -2899.01, -367.333 ), ( -13871.3, -1893.56, -496.984 ), ( -14585.4, -1742.33, -499.297 ), ( -11188.8, -2183.38, -495.875 ), ( -12771.6, -2726.33, -496 ), ( -10270.6, 420.963, -496 ), ( -10043.5, -486.684, -496 ), ( -8696.52, -978.122, -500.364 ), ( -9725.5, -0.56395, -501.509 ), ( -10913, -1019.32, -495.875 ), ( -10913, -1019.32, -495.875 ) ];
    var_1 = [ ( 270, 0, 0 ), ( 270, 0, 0 ), ( 270, 0, 0 ), ( 270, 0, 0 ), ( 270, 0, 0 ), ( 270, 0, 0 ), ( 270, 0, 0 ), ( 270, 0, 0 ), ( 270, 0, 0 ), ( 270, 0, 0 ), ( 270, 0, 0 ), ( 270, 0, 0 ), ( 270, 0, 0 ), ( 270, 0, 0 ) ];
    thread maps\_shg_fx::start_fx_by_view( "ambient_explosion_dirt_runner", var_0, 5, 4, "msg_kill_ambient_war_fx", 0, var_1, "seo_dirt_explosions", "incoming_complete" );
}
