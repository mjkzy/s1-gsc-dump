// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

transition_unload_then_load_safely( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_3 ) )
        level notify( var_3 );

    if ( istransientloaded( var_0 ) )
        unloadtransient( var_0 );

    for (;;)
    {
        if ( !istransientloaded( var_0 ) )
            break;

        wait 0.1;
    }

    loadtransient( var_1 );

    for (;;)
    {
        if ( istransientloaded( var_1 ) )
            break;

        wait 0.1;
    }

    level notify( var_2 );
}

setup_start_points_for_transients()
{
    var_0 = [ "seoul_intro_building_descend_tr", "seoul_east_view_tr" ];
    maps\_utility::set_start_transients( "seoul_intro", var_0 );
    maps\_utility::set_start_transients( "seoul_first_land_assist", var_0 );
    maps\_utility::set_start_transients( "seoul_enemy_encounter_01", var_0 );
    maps\_utility::set_start_transients( "seoul_missile_evade_sequence", var_0 );
    var_0 = [ "seoul_fob_tr", "seoul_intro_building_descend_tr" ];
    maps\_utility::set_start_transients( "seoul_forward_operating_base", var_0 );
    maps\_utility::set_start_transients( "seoul_drone_swarm_intro", var_0 );
    var_0 = [ "seoul_truck_push_trans_tr", "seoul_drone_swarm_one_tr" ];
    maps\_utility::set_start_transients( "seoul_truck_push", var_0 );
    maps\_utility::set_start_transients( "seoul_hotel_entrance", var_0 );
    var_0 = [ "seoul_mall_offices_tr", "seoul_truck_push_trans_tr" ];
    maps\_utility::set_start_transients( "seoul_building_jump_sequence", var_0 );
    var_0 = [ "seoul_sinkhole_subway_tr", "seoul_mall_offices_tr" ];
    maps\_utility::set_start_transients( "seoul_sinkhole_start", var_0 );
    var_0 = [ "seoul_sinkhole_subway_tr", "seoul_subway_trans_tr" ];
    maps\_utility::set_start_transients( "seoul_subway_start", var_0 );
    var_0 = [ "seoul_subway_trans_tr", "seoul_shopping_dist_tr" ];
    maps\_utility::set_start_transients( "seoul_shopping_district_start", var_0 );
    var_0 = [ "seoul_shopping_dist_tr", "seoul_canal_overlook_bar_tr" ];
    maps\_utility::set_start_transients( "seoul_shopping_district_flee_swarm", var_0 );
    var_0 = [ "seoul_canal_overlook_bar_tr", "seoul_riverwalk_tr" ];
    maps\_utility::set_start_transients( "seoul_canal_intro", var_0 );
    maps\_utility::set_start_transients( "seoul_canal_combat_start", var_0 );
    maps\_utility::set_start_transients( "seoul_canal_combat_pt2", var_0 );
    maps\_utility::set_start_transients( "seoul_finale_scene_start", var_0 );
    maps\_utility::set_start_transients( "seoul_e3_presentation", var_0 );
    maps\_utility::set_start_transients( "seoul_cover_art", var_0 );
}

setup_level_transient_zone_variable()
{
    level.transient_zone = "";

    if ( istransientloaded( "seoul_intro_building_descend_tr" ) )
        level.transient_zone = "intro";

    if ( istransientloaded( "seoul_fob_tr" ) )
        level.transient_zone += "_fob";

    if ( istransientloaded( "seoul_drone_swarm_one_tr" ) )
        level.transient_zone += "_droneswarm1";

    if ( istransientloaded( "seoul_truck_push_trans_tr" ) )
        level.transient_zone += "_truckpush";

    if ( istransientloaded( "seoul_mall_offices_tr" ) )
        level.transient_zone += "_offices";

    if ( istransientloaded( "seoul_sinkhole_subway_tr" ) )
        level.transient_zone += "_sinkhole";

    if ( istransientloaded( "seoul_subway_trans_tr" ) )
        level.transient_zone += "_subway";

    if ( istransientloaded( "seoul_shopping_dist_tr" ) )
        level.transient_zone += "_shopping";

    if ( istransientloaded( "seoul_canal_overlook_bar_tr" ) )
        level.transient_zone += "_overlookbar";

    if ( istransientloaded( "seoul_riverwalk_tr" ) )
        level.transient_zone += "_riverwalk";

    if ( level.transient_zone == "intro" )
        level notify( "transients_intro" );
}

cg_tff_set_up_transient_meshes()
{
    var_0 = getentarray( "trans_barrier_intro_2_drone_swarm", "targetname" );

    if ( issubstr( level.transient_zone, "intro" ) || issubstr( level.transient_zone, "_fob" ) )
    {
        for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        {
            var_0[var_1] hide();
            var_0[var_1] setcontents( 0 );
        }
    }

    var_2 = getentarray( "transients_rubble_blocker", "targetname" );
    var_3 = getentarray( "transients_rubble_blocker_clip", "targetname" );

    foreach ( var_5 in var_2 )
    {
        var_5 hide();
        var_5 setcontents( 0 );

        if ( var_5.classname == "script_brushmodel" )
        {
            var_5 notsolid();
            var_5 connectpaths();
        }
    }

    foreach ( var_8 in var_3 )
    {
        var_8 notsolid();
        var_8 connectpaths();
    }

    var_10 = getentarray( "hotel_zipline_panel", "targetname" );

    for ( var_1 = 0; var_1 < var_10.size; var_1++ )
        var_10[var_1] disconnectpaths();

    common_scripts\utility::flag_init( "enable_regression_conference_death" );
    var_11 = getent( "cg_subway_doors_clip", "targetname" );

    if ( level.transient_zone != "_subway" )
    {
        var_11 notsolid();
        var_11 connectpaths();
    }

    var_12 = getent( "trans_subway_door_mesh", "targetname" );

    if ( level.transient_zone != "_subway_shopping" && level.transient_zone != "_shopping_overlookbar" && level.transient_zone != "_overlookbar_riverwalk" )
        var_12 hide();

    var_13 = getent( "cg_turnstyle_clip", "targetname" );
    var_14 = getent( "subway_doors_opaque_shutter", "targetname" );
    var_14 hide();
    var_15 = getentarray( "trans_bar_door_mesh", "targetname" );
    var_16 = getent( "trans_bar_door_clip", "targetname" );

    if ( level.transient_zone != "_overlookbar_riverwalk" )
    {
        var_16 moveto( var_16.origin + ( 0, 0, -340 ), 0.25 );

        for ( var_1 = 0; var_1 < var_15.size; var_1++ )
        {
            var_15[var_1] hide();
            var_15[var_1] moveto( var_15[var_1].origin + ( 0, 0, -340 ), 0.25 );
        }

        for ( var_1 = 0; var_1 < var_15.size; var_1++ )
        {
            if ( var_15[var_1].classname != "script_model" )
                var_15[var_1] connectpaths();
        }

        var_16 connectpaths();
    }
}

cg_tff_transition_eastview_to_fob()
{
    thread cg_tff_transition_eastview_blocker();
    maps\_utility::trigger_wait_targetname( "tff_trans_east_view_to_fob" );
    transition_unload_then_load_safely( "seoul_east_view_tr", "seoul_fob_tr", "transients_intro_to_fob", "pre_transients_intro_to_fob" );
}

cg_tff_transition_eastview_blocker()
{
    tff_ally_check( "check_player_near_guys", [ "jackson", "will irons", "cormack" ] );
    var_0 = getent( "cg_trans_hotel_door", "targetname" );
    var_0.angles = ( 0, 0, 0 );
    var_1 = getent( "cg_trans_hotel_door_clip", "targetname" );
    var_1 moveto( var_1.origin + ( -105, 0, 0 ), 0.25 );
    var_1 disconnectpaths();
}

cg_tff_transition_fob_to_droneswarmone()
{
    var_0 = getent( "Trigger_swap_EastView_to_DroneSwarm1", "targetname" );

    for (;;)
    {
        if ( level.player istouching( var_0 ) )
            break;

        waitframe();
    }

    transition_unload_then_load_safely( "seoul_intro_building_descend_tr", "seoul_drone_swarm_one_tr", "transients_fob_to_drone_seq_one", "pre_transients_fob_to_drone_seq_one" );
    var_1 = getentarray( "trans_barrier_intro_2_drone_swarm", "targetname" );
    var_2 = getent( "trans_barrier_intro_2_drone_swarm_clip", "targetname" );

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
        var_1[var_3] show();

    var_2 moveto( var_2.origin + ( 0, 0, 340 ), 0.25 );
}

cg_tff_transition_droneswarmone_to_mall()
{
    thread cg_tff_transition_droneswarmone_blocker();
    maps\_utility::trigger_wait_targetname( "Trigger_swap_DroneSwarmOne_to_Mall" );
    transition_unload_then_load_safely( "seoul_drone_swarm_one_tr", "seoul_mall_offices_tr", "transients_truck_push_to_mall_office", "pre_transients_truck_push_to_mall_office" );
}

cg_tff_transition_droneswarmone_blocker()
{
    tff_ally_check( "Trigger_swap_DroneSwarmOne_to_Mall", [ "jackson", "will irons", "cormack" ] );
    var_0 = getentarray( "conf_door_clip_open", "targetname" );
    var_1 = getent( "conf_door_clip_closed", "targetname" );
    var_2 = [ "conf_door_01", "conf_door_02", "conf_door_03", "conf_door_04" ];
    var_3 = [ ( 0, 0, 0 ), ( 0, 0, 0 ), ( 0, 0, 0 ), ( 0, 0, 0 ) ];

    for ( var_4 = 0; var_4 < var_2.size; var_4++ )
    {
        var_5 = getent( var_2[var_4], "targetname" );
        var_5.angles = var_3[var_4];
    }

    var_0[0] moveto( var_0[0].origin + ( 0, 0, -250 ), 0.25 );
    var_0[1] moveto( var_0[1].origin + ( 0, 0, -250 ), 0.25 );
    var_1 moveto( var_1.origin + ( 0, 0, 250 ), 0.25 );
}

cg_tff_transition_fob_to_truckpush()
{
    level waittill( "end_cherry_picker" );
    var_0 = [ "marines_body_smg", "marines_body_shotgun", "vehicle_ft101_tank" ];
    var_1 = getaiarray();

    foreach ( var_3 in var_1 )
    {
        foreach ( var_5 in var_0 )
        {
            if ( var_3.model == var_5 )
            {
                var_3 delete();
                continue;
            }
        }
    }

    var_8 = getentarray( "transients_rubble_blocker", "targetname" );
    var_9 = getentarray( "transients_rubble_blocker_clip", "targetname" );

    foreach ( var_11 in var_8 )
    {
        var_11 show();

        if ( var_11.classname == "script_brushmodel" )
        {
            var_11 solid();
            var_11 disconnectpaths();
        }
    }

    foreach ( var_14 in var_9 )
    {
        var_14 solid();
        var_14 disconnectpaths();
    }

    transition_unload_then_load_safely( "seoul_fob_tr", "seoul_truck_push_trans_tr", "transients_drone_seq_one_to_truck_push", "pre_transients_drone_seq_one_to_trusk_push" );
}

cg_tff_transition_mall_to_shinkhole()
{
    maps\_utility::trigger_wait_targetname( "Trigger_swap_TruckPush_to_Sinkhole" );
    level notify( "cg_transients_cleanup_delete_truck" );
    transition_unload_then_load_safely( "seoul_truck_push_trans_tr", "seoul_sinkhole_subway_tr", "transients_mall_office_to_sinkhole_subway", "pre_transients_mall_office_to_sinkhole_subway" );
}

cg_tff_transition_shinkhole_to_subway()
{
    tff_ally_check( "Trigger_swap_Sinkhole_to_Subway", [ "jackson", "will irons", "cormack" ] );
    var_0 = getentarray( "cg_subway_doors_left", "targetname" );
    var_1 = getentarray( "cg_subway_doors_right", "targetname" );
    var_2 = getent( "cg_subway_doors_clip", "targetname" );

    foreach ( var_4 in var_0 )
        var_4.origin += ( 0, -37, 0 );

    foreach ( var_7 in var_1 )
        var_7.origin += ( 0, 43, 0 );

    var_2 solid();
    var_2 disconnectpaths();
    transition_unload_then_load_safely( "seoul_mall_offices_tr", "seoul_subway_trans_tr", "transients_sinkhole_subway_to_subway", "pre_transients_sinkhole_subway_to_subway" );
}

cg_tff_transition_subway_to_shoppingdistrict()
{
    var_0 = getent( "trans_subway_door_mesh", "targetname" );
    tff_ally_check( "Trigger_swap_Subway_to_ShoppingDistrict", [ "jackson", "will irons", "cormack" ] );
    var_0 show();
    thread cg_subway_turnstyle_open();
    transition_unload_then_load_safely( "seoul_sinkhole_subway_tr", "seoul_shopping_dist_tr", "transients_subway_to_shopping_dist", "pre_transients_subway_to_shopping_dist" );
}

cg_subway_turnstyle_open()
{
    var_0 = getent( "cg_turnstyle_clip", "targetname" );
    var_1 = getentarray( "cg_turnstyle_l", "targetname" );
    var_2 = getentarray( "cg_turnstyle_r", "targetname" );
    level waittill( "transients_subway_to_shopping_dist" );

    foreach ( var_4 in var_1 )
        var_4.angles = ( 0, 220, 0 );

    foreach ( var_4 in var_2 )
        var_4.angles = ( 0, 220, 0 );

    subway_open_all_cg_doors( var_1 );
    subway_open_all_cg_doors( var_2 );
    var_0 notsolid();
    var_0 connectpaths();
}

subway_open_all_cg_doors( var_0 )
{
    foreach ( var_2 in var_0 )
        var_2 soundscripts\_snd_playsound::snd_play_delayed_linked( "seo_sbwy_doors_open", 0.0 );
}

cg_tff_transition_shopping_to_canaloverlook()
{
    maps\_utility::trigger_wait_targetname( "Trigger_swap_SubwayTrans_to_CanalOverlook" );
    var_0 = getent( "subway_doors_closed_clip", "targetname" );
    var_1 = [ "subway_door_01", "subway_door_02", "subway_door_03", "subway_door_04" ];
    var_2 = [ ( 0, 90, 0 ), ( 0, 90, 0 ), ( 0, 90, 0 ), ( 0, 90, 0 ) ];
    var_0 moveto( var_0.origin + ( 0, 0, 250 ), 0.25 );
    var_3 = getent( "subway_doors_opaque_shutter", "targetname" );
    var_3 moveto( var_3.origin + ( 0, 0, 350 ), 0.01 );
    var_3 show();
    transition_unload_then_load_safely( "seoul_subway_trans_tr", "seoul_canal_overlook_bar_tr", "transients_shopping_dist_to_canal_overlook", "pre_transients_shopping_dist_to_canal_overlook" );
}

cg_tff_transition_canaloverlook_to_riverwalk()
{
    maps\_utility::trigger_wait_targetname( "Trigger_swap_Shopping_to_RiverWalk" );
    transition_unload_then_load_safely( "seoul_shopping_dist_tr", "seoul_riverwalk_tr", "transients_canal_overlook_to_riverwalk", "pre_transients_canal_overlook_to_riverwalk" );

    if ( level.transient_zone != "_overlookbar_riverwalk" )
    {
        var_0 = getentarray( "trans_bar_door_mesh", "targetname" );
        var_1 = getent( "trans_bar_door_clip", "targetname" );
        var_1 moveto( var_1.origin + ( 0, 0, 340 ), 0.25 );

        for ( var_2 = 0; var_2 < var_0.size; var_2++ )
        {
            var_0[var_2] show();
            var_0[var_2] moveto( var_0[var_2].origin + ( 0, 0, 340 ), 0.25 );
        }

        for ( var_2 = 0; var_2 < var_0.size; var_2++ )
        {
            if ( var_0[var_2].classname != "script_model" )
                var_0[var_2] disconnectpaths();
        }
    }
}

cg_kill_entity_on_transition( var_0, var_1 )
{
    level waittill( var_1 );

    if ( isdefined( var_0 ) )
        var_0 delete();
}

cg_swap_tank_treads_mat()
{
    if ( issubstr( level.transient_zone, "intro" ) )
        level waittill( "transients_intro_to_fob" );

    var_0 = getent( "tanks_no_tread_roll", "targetname" );
    var_0 overridematerial( "mtl_bigtank_tread", "mq/mtl_bigtank_tread_static" );
}

#using_animtree("generic_human");

subway_setup_dead_civilians_cg()
{
    var_0 = common_scripts\utility::getstructarray( "struct_subway_civilian", "targetname" );
    var_1 = [ "civ_seoul_male_head_aa", "civ_seoul_female_head_a", "civ_seoul_female_head_a", "civ_seoul_male_head_c", "civ_seoul_male_head_c", "head_city_civ_female_a", "civ_seoul_male_head_d", "head_city_civ_female_a", "civ_seoul_male_head_d" ];
    var_2 = [ "civ_seoul_male_body_f", "civ_seoul_female_body_a", "civ_seoul_female_body_c", "civ_seoul_male_body_ff", "civ_seoul_male_body_b", "body_london_female_ccc", "civ_urban_male_body_c", "body_london_female_aaa", "body_london_male_a" ];
    var_3 = 0;

    for ( var_4 = 0; var_4 < var_0.size; var_4++ )
    {
        if ( var_4 >= var_2.size )
            var_3 = 0;

        var_5 = spawn( "script_model", var_0[var_3].origin );
        var_5 setmodel( var_2[var_3] );
        var_5 attach( var_1[var_3] );
        var_5 setcontents( 0 );
        var_5.angles = var_0[var_3].angles;
        var_5 useanimtree( #animtree );
        var_5.animname = "generic";
        var_0[var_4] thread maps\_anim::anim_loop_solo( var_5, var_0[var_3].animation );
        var_5 castshadows();
        thread cg_kill_entity_on_transition( var_5, "pre_transients_subway_to_shopping_dist" );
        var_3 += 1;
    }
}

subway_setup_civilians_cg()
{
    if ( !issubstr( level.transient_zone, "sinkhole" ) )
        level waittill( "transients_sinkhole_subway_to_subway" );

    var_0 = [ "civ_seoul_male_body_f", "civ_seoul_female_body_a", "civ_seoul_female_body_c", "civ_seoul_male_body_ff", "civ_seoul_male_body_f", "civ_seoul_male_body_b", "civ_seoul_male_body_f", "body_london_female_ccc", "civ_urban_male_body_c", "civ_seoul_female_body_c", "body_london_female_aa", "civ_seoul_female_body_c", "civ_seoul_female_body_a", "civ_seoul_female_body_a", "body_london_female_aaa", "body_london_male_a", "civ_seoul_male_body_f", "civ_seoul_female_body_a", "civ_seoul_female_body_a", "civ_seoul_female_body_a", "body_london_female_aaa", "body_london_male_a", "civ_seoul_male_body_f", "civ_seoul_female_body_a" ];
    var_1 = [ "civ_seoul_male_head_aa", "civ_seoul_female_head_a", "civ_seoul_female_head_a", "civ_seoul_male_head_c", "civ_seoul_male_head_c", "civ_seoul_male_head_c", "civ_seoul_male_head_d", "head_city_civ_female_a", "civ_seoul_male_head_d", "civ_seoul_female_head_a", "head_city_civ_female_a", "civ_seoul_female_head_a", "head_city_civ_female_a", "civ_seoul_female_head_a", "head_city_civ_female_a", "civ_seoul_male_head_d", "civ_seoul_male_head_a", "civ_seoul_female_head_a", "head_city_civ_female_a", "civ_seoul_female_head_a", "head_city_civ_female_a", "civ_seoul_male_head_d", "civ_seoul_male_head_a", "civ_seoul_female_head_a" ];
    var_2 = [ "civilian_reader_1", "sf_a_civ_injured_seated_mourned", "london_civ_idle_scratchnose", "civilian_texting_sitting", "afgan_caves_sleeping_guard_idle", "civilian_sitting_talking_a_1", "civilian_sitting_talking_b_2", "sf_a_civ_injured_seated_face", "sf_a_civ_injured_seated_mourner", "ch_pragueb_15_6_wounded_civ_04", "london_civ_idle_foldarms2", "ch_pragueb_15_6_wounded_civ_02", "africa_civ_washingclothes", "london_civ_idle_lookbehind", "london_civ_idle_scratchnose", "parabolic_leaning_guy_smoking_idle", "civilian_smoking_b", "london_civ_idle_lookbehind", "sf_a_civ_injured_seated_helped", "civilian_reader_2", "civilian_texting_standing", "civilian_sitting_business_lunch_A_1" ];
    var_3 = [];

    for ( var_4 = 1; var_4 < 22; var_4++ )
        var_3[var_4 - 1] = common_scripts\utility::getstruct( "sub_civ_" + var_4 + "_cg", "targetname" );

    for ( var_4 = 0; var_4 < var_3.size; var_4++ )
    {
        var_5 = spawn( "script_model", var_3[var_4].origin );
        var_5 setmodel( var_0[var_4] );
        var_5 attach( var_1[var_4] );

        if ( var_2[var_4] == "civilian_texting_sitting" || var_2[var_4] == "civilian_texting_standing" )
        {
            var_6 = spawn( "script_model", var_3[var_4].origin );
            var_6 setmodel( "cellphone_kit_05" );

            if ( var_2[var_4] == "civilian_texting_sitting" )
            {
                var_6.origin = var_5 gettagorigin( "J_Wrist_RI" );
                var_6.angles = var_5 gettagangles( "J_Wrist_RI" );
                var_6 linkto( var_5, "J_Wrist_RI", ( -3.9, -1.8, -0.7 ), ( -30, 30, -10 ) );
            }

            if ( var_2[var_4] == "civilian_texting_standing" )
            {
                var_6.origin = var_5 gettagorigin( "J_Wrist_LE" );
                var_6.angles = var_5 gettagangles( "J_Wrist_LE" );
                var_6 linkto( var_5, "J_Wrist_LE", ( 3.5, 0.9, 0.6 ), ( -180, 200, 0 ) );
            }
        }

        if ( var_2[var_4] == "civilian_reader_1" || var_2[var_4] == "civilian_reader_2" )
        {
            var_7 = spawn( "script_model", var_3[var_4].origin );
            var_7 setmodel( "newspaper_folded" );

            if ( var_2[var_4] == "civilian_reader_1" )
            {
                var_7.origin = var_5 gettagorigin( "J_Wrist_LE" );
                var_7.angles = var_5 gettagangles( "J_Wrist_LE" );
                var_7 linkto( var_5, "J_Wrist_LE", ( 5.5, 2.66, -2 ), ( -13.3, 59.4, 41 ) );
            }

            if ( var_2[var_4] == "civilian_reader_2" )
            {
                var_7.origin = var_5 gettagorigin( "J_Wrist_RI" );
                var_7.angles = var_5 gettagangles( "J_Wrist_RI" );
                var_7 linkto( var_5, "J_Wrist_RI", ( -4.75, -3.5, 0.6 ), ( 0, 60, -90 ) );
            }
        }

        if ( var_2[var_4] == "parabolic_leaning_guy_smoking_idle" )
        {
            var_8 = spawn( "script_model", var_3[var_4].origin );
            var_8 setmodel( "prop_cigarette" );
            var_8.origin = var_5 gettagorigin( "J_Wrist_RI" );
            var_8.angles = var_5 gettagangles( "J_Wrist_RI" );
            var_8 linkto( var_5, "J_Wrist_RI", ( -5.5, -0.5, 1.55 ), ( 90, -30, 110 ) );
            playfxontag( common_scripts\utility::getfx( "cigarette_smk" ), var_5, "tag_inhand" );
        }

        var_5 setcontents( 0 );
        var_5.angles = var_3[var_4].angles;
        var_5 useanimtree( #animtree );
        var_5.animname = "generic";
        var_3[var_4] thread maps\_anim::anim_loop_solo( var_5, var_2[var_4] );
        var_5 castshadows();
        thread cg_kill_entity_on_transition( var_5, "pre_transients_subway_to_shopping_dist" );
    }
}

subway_civ_speaking_groups_setup_cg()
{
    if ( !issubstr( level.transient_zone, "sinkhole" ) )
        level waittill( "transients_sinkhole_subway_to_subway" );

    var_0 = [ "civ_seoul_female_body_a", "civ_seoul_male_body_ff", "civ_urban_male_body_e", "civ_seoul_male_body_d", "civ_seoul_female_body_c", "civ_seoul_male_body_b", "civ_seoul_male_body_f", "body_london_female_ccc" ];
    var_1 = [ "civ_seoul_female_head_a", "civ_seoul_male_head_a", "civ_seoul_male_head_b", "civ_seoul_male_head_c", "civ_seoul_female_head_a", "civ_seoul_male_head_ee", "civ_seoul_male_head_c", "civ_seoul_female_head_a" ];
    var_2 = [];
    var_3 = [];
    var_4 = [ "spn_sub_civ1_cg", "spn_sub_civ2_cg", "spn_sub_civ3_cg", "spn_sub_civ4_cg", "spn_sub_civ5_cg", "spn_sub_civ6_cg", "spn_sub_civ7_cg", "spn_sub_civ8_cg" ];

    for ( var_5 = 0; var_5 < var_4.size; var_5++ )
    {
        var_6 = common_scripts\utility::getstruct( var_4[var_5], "targetname" );
        var_2[var_5] = var_6.origin;
        var_3[var_5] = var_6.angles;
    }

    var_7 = [ "sf_a_civ_injured_seated_helper", "sf_a_civ_injured_seated_helped", "sf_a_civ_injured_seated_face", "civilian_sitting_talking_b_2", "london_civ_idle_lookbehind", "london_civ_idle_scratchnose", "ch_pragueb_15_6_wounded_civ_03", "civilian_smoking_b" ];
    var_8 = [];

    for ( var_5 = 0; var_5 < var_0.size; var_5++ )
    {
        var_8[var_5] = spawn( "script_model", var_2[var_5] );
        var_8[var_5] setmodel( var_0[var_5] );
        var_8[var_5] attach( var_1[var_5] );

        if ( var_7[var_5] == "civilian_smoking_b" )
        {
            var_9 = spawn( "script_model", var_2[var_5] );
            var_9 setmodel( "prop_cigarette" );
            var_9.origin = var_8[var_5] gettagorigin( "J_Wrist_RI" );
            var_9.angles = var_8[var_5] gettagangles( "J_Wrist_RI" );
            var_9 linkto( var_8[var_5], "J_Wrist_RI", ( -5.5, -0.5, 1 ), ( 70, -30, 90 ) );
            playfxontag( common_scripts\utility::getfx( "cigarette_smk" ), var_8[var_5], "tag_inhand" );
        }

        var_8[var_5] setcontents( 0 );
        var_8[var_5].angles = var_3[var_5];
        var_8[var_5] useanimtree( #animtree );
        var_8[var_5].animname = "generic";
        var_10 = common_scripts\utility::getstruct( var_4[var_5], "targetname" );
        var_10 thread maps\_anim::anim_loop_solo( var_8[var_5], var_7[var_5] );
        var_8[var_5] castshadows();
        thread cg_kill_entity_on_transition( var_8[var_5], "pre_transients_subway_to_shopping_dist" );
    }

    level.civ1 = var_8[0];
    level.civ2 = var_8[1];
    level.civ3 = var_8[2];
    level.civ4 = var_8[3];
    level.civ5 = var_8[4];
    level.civ6 = var_8[5];
    level.civ7 = var_8[6];
    level.civ8 = var_8[7];
}

subway_execution_scene_cg()
{
    thread maps\seoul_code_shopping_district::handle_ally_threat_during_execution_scene();
    var_0 = getent( "trigger_enter_subway_station_01", "targetname" );
    var_1 = getent( "trigger_enter_subway_station_02", "targetname" );
    var_0 waittill( "trigger" );
    var_1 waittill( "trigger" );
    var_2 = getent( "spawner_execution_scene", "targetname" );
    var_3 = getentarray( "spawner_subway_civilian", "targetname" );
    var_4 = common_scripts\utility::getstructarray( "struct_subway_execution_scene_civ1", "targetname" );
    var_5 = common_scripts\utility::getstructarray( "struct_subway_execution_scene_soldier1", "targetname" );
    var_6 = var_5[0] common_scripts\utility::spawn_tag_origin();
    var_7 = [ "civ_urban_female_body_e_asi", "civ_seoul_male_body_f", "civ_seoul_female_body_a" ];
    var_8 = [ "head_f_gen_asi_lee_base", "civ_seoul_male_head_d", "civ_seoul_female_head_a" ];
    var_9 = 0;
    var_10 = [];

    foreach ( var_12 in var_4 )
    {
        var_13 = spawn( "script_model", var_12.origin );
        var_13 setmodel( var_7[var_9] );
        var_13 attach( var_8[var_9] );
        var_13.animation = var_12.animation;
        var_10[var_10.size] = var_13;
        var_13 thread maps\seoul_code_shopping_district::kill_on_damage();
        var_9 += 1;
    }

    var_15 = [];

    foreach ( var_12 in var_5 )
    {
        var_13 = var_2 maps\_shg_design_tools::actual_spawn( 1 );
        var_13.animation = var_12.animation;
        var_15[var_15.size] = var_13;
    }

    foreach ( var_13 in var_10 )
        var_13 thread maps\seoul_code_shopping_district::monitor_execution_scene_civs( var_10 );

    var_10 = common_scripts\utility::array_combine( var_10, var_15 );

    foreach ( var_13 in var_15 )
    {
        var_13 thread maps\seoul_code_shopping_district::monitor_execution_scene_soldiers( var_10 );

        if ( issubstr( var_13.animation, "soldier_1" ) )
        {
            var_13 maps\_utility::gun_remove();
            var_13 attach( "npc_titan45_nocamo", "TAG_WEAPON_RIGHT", 0 );
            var_13.has_fake_pistol = 1;
        }
    }

    foreach ( var_13 in var_10 )
    {
        var_6 thread maps\_anim::anim_generic( var_13, var_13.animation );
        var_13.allowdeath = 1;
    }

    level waittill( "execution_scene_halted" );
    maps\_utility::activate_trigger_with_targetname( "trig_subway_round_corner" );
}

seo_meet_atlas_civ_scriptmodel_cg()
{
    var_0 = common_scripts\utility::getstruct( "civ_vip1_cg", "targetname" );
    var_1 = spawn( "script_model", var_0.origin );
    var_1 setmodel( "civ_urban_male_body_e" );
    var_1 attach( "civ_seoul_male_head_c" );
    var_1 setcontents( 0 );
    var_1.angles = var_0.angles;
    var_1 useanimtree( #animtree );
    var_1.animname = "vip";
    var_1 castshadows();
    return var_1;
}

seo_get_vip_away_cg( var_0 )
{
    level.vip1.origin = var_0.origin;
    level.vip1.angles = var_0.angles;
    level.vip1 useanimtree( #animtree );
    level.vip1.animname = "vip";
    var_0 thread maps\_anim::anim_single_solo( level.vip1, "seo_post_meet_atlas_walk" );
}

seoul_cg_precache_models()
{
    var_0 = [ "civ_urban_male_body_e", "civ_seoul_male_body_b", "civ_urban_male_body_c", "civ_seoul_male_body_d", "body_london_male_a", "civ_seoul_male_body_f", "civ_seoul_male_body_ff", "civ_seoul_female_head_a", "body_london_female_aa", "body_london_female_aaa", "civ_seoul_female_body_a", "civ_seoul_female_body_c", "body_london_female_ccc", "civ_seoul_male_head_a", "civ_seoul_male_head_aa", "civ_seoul_male_head_b", "civ_seoul_male_head_c", "civ_seoul_male_head_d", "civ_seoul_male_head_ee", "civ_seoul_female_head_a", "civ_seoul_female_body_a", "cellphone_kit_05", "head_city_civ_female_a", "prop_cigarette", "newspaper_folded", "civ_urban_female_body_e_asi", "head_f_gen_asi_lee_base" ];

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        precachemodel( var_0[var_1] );

    precacheshader( "mq/mtl_bigtank_tread_static" );
}

tff_ally_check( var_0, var_1 )
{
    var_2 = getent( var_0, "targetname" );
    level.tff_trans_ally_check_count = 0;

    for (;;)
    {
        var_2 waittill( "trigger", var_3 );

        if ( isdefined( var_3.tff_trans_ally_check_active ) && var_3.tff_trans_ally_check_active )
            continue;

        if ( isdefined( var_3.script_friendname ) )
            var_4 = tolower( var_3.script_friendname );
        else
            var_4 = "";

        if ( var_3 == level.player || common_scripts\utility::array_contains( var_1, var_4 ) )
        {
            level.tff_trans_ally_check_count++;

            if ( level.tff_trans_ally_check_count >= var_1.size + 1 )
                break;

            var_3.tff_trans_ally_check_active = 1;
            var_3 thread tff_trans_ally_check_touching( var_2 );
        }
    }
}

tff_trans_ally_check_touching( var_0 )
{
    while ( self istouching( var_0 ) )
        wait 0.05;

    level.tff_trans_ally_check_count--;
    self.tff_trans_ally_check_active = 0;
}
