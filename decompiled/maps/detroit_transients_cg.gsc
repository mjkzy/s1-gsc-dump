// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

cg_setup_civs_foodtruck()
{
    common_scripts\utility::flag_wait( "show_middle_civs_trigger" );
    var_0 = [];
    var_1 = getent( "org_foodtruck", "targetname" );
    var_2 = getent( "atlas_guard_foodtruck2_spawner", "targetname" ) _meth_803D();
    var_0[var_0.size] = var_2;
    var_2.animname = "drone_civs";
    var_2 maps\_anim::setanimtree();
    var_1 thread maps\_anim::anim_loop_solo( var_2, "foodtruck18" );
    var_3 = spawn( "script_model", var_1.origin );
    var_3 _meth_80B1( "det_cargo_box_single_01" );
    var_3.animname = "foodtruck_mre";
    var_3 maps\_anim::setanimtree();
    var_0[var_0.size] = var_3;
    thread maps\detroit_refugee_camp::mre_loop( var_3 );
    var_1 thread maps\_anim::anim_loop_solo( var_3, "foodtruck_mre2" );
    var_4 = [ "civ_urban_male_body_b_green_afr_dark", "civ_urban_male_body_c_blue_mde", "civ_urban_male_body_f_black_pants", "civ_urban_male_body_e_solid_red", "civ_urban_male_body_b_green_mde", "civ_urban_male_body_c_solid_yellow_afr_light", "civ_urban_male_body_f_black_pants", "civ_urban_male_body_c_solid_yellow", "civ_urban_male_body_e", "civ_urban_male_body_b_red_afr_light" ];
    var_5 = [ "head_m_gen_afr_davis", "head_m_gen_mde_urena", "head_m_act_cau_kanik_base", "head_m_gen_cau_anderson", "head_m_gen_mde_azzam", "head_m_act_afr_brickerson_base", "head_m_act_cau_manasi_base", "head_m_act_cau_ramsay_base", "head_m_gen_cau_anderson", "head_m_gen_afr_rice" ];
    var_6 = [ "civ_foodtruck1_spawner", "civ_foodtruck3_spawner", "civ_foodtruck5_spawner", "civ_foodtruck6_spawner", "civ_foodtruck8_spawner", "civ_foodtruck9_spawner", "civ_foodtruck10_spawner", "civ_foodtruck11_spawner", "civ_foodtruck13_spawner", "civ_foodtruck14_spawner" ];
    var_7 = [ "foodtruck11", "foodtruck1", "foodtruck3", "foodtruck13", "foodtruck9", "foodtruck5", "foodtruck8", "foodtruck10", "foodtruck6", "foodtruck14" ];
    var_8 = [];

    for ( var_9 = 0; var_9 < var_4.size; var_9++ )
    {
        if ( var_9 == 5 || var_9 == 3 )
            continue;

        var_10 = common_scripts\utility::getstruct( var_6[var_9], "targetname" );
        var_8[var_9] = spawn( "script_model", var_10.origin );
        var_8[var_9] _meth_80B1( var_4[var_9] );
        var_8[var_9] attach( var_5[var_9] );
        var_8[var_9] setcontents( 0 );
        var_8[var_9].angles = var_10.angles;
        var_8[var_9].animname = "drone_civs";
        var_8[var_9] maps\_anim::setanimtree();
        var_1 thread maps\_anim::anim_loop_solo( var_8[var_9], var_7[var_9] );

        if ( var_9 == 0 )
        {
            wait 0.05;
            var_8[var_9] _meth_8117( %det_camp_foodtruck_civ_11, 0.0331 );
        }

        var_0[var_0.size] = var_8[var_9];
    }

    var_11 = getent( "foodtruck", "targetname" );
    var_0[var_0.size] = var_11;
    var_11.animname = "foodtruck";
    var_11 maps\_anim::setanimtree();
    var_1 thread maps\_anim::anim_loop_solo( var_11, "foodtruck_door" );

    for ( var_9 = 0; var_9 < var_0.size; var_9++ )
    {
        if ( isdefined( var_0[var_9] ) )
            thread cg_kill_entity_on_transition( var_0[var_9], "tff_pre_intro_to_middle" );
    }

    common_scripts\utility::flag_wait( "flag_camp_visibility_04" );

    for ( var_9 = 0; var_9 < var_8.size; var_9++ )
        var_8[var_9] delete();

    var_2 delete();
    var_11 delete();
}

cg_setup_civs_infosign()
{
    common_scripts\utility::flag_wait( "flag_camp_visibility_01" );
    var_0 = [];
    var_1 = [ "civ_urban_male_body_e_solid_teal_afr_light", "body_india_female_b" ];
    var_2 = [ "head_m_act_afr_sykes_base", "head_india_female_b" ];
    var_3 = [ "civ_sign2_spawner", "civ_sign3_spawner" ];
    var_4 = [ "sign2_spawner", "sign3_spawner" ];
    var_5 = [];

    for ( var_6 = 0; var_6 < var_1.size; var_6++ )
    {
        var_7 = common_scripts\utility::getstruct( var_3[var_6], "targetname" );
        var_5[var_6] = spawn( "script_model", var_7.origin );
        var_5[var_6] _meth_80B1( var_1[var_6] );
        var_5[var_6] attach( var_2[var_6] );
        var_5[var_6] setcontents( 0 );
        var_5[var_6].angles = var_7.angles;
        var_5[var_6].animname = "drone_civs";
        var_5[var_6] maps\_anim::setanimtree();
        var_7 thread maps\_anim::anim_loop_solo( var_5[var_6], var_4[var_6] );
        var_0[var_0.size] = var_5[var_6];
    }

    for ( var_6 = 0; var_6 < var_0.size; var_6++ )
    {
        if ( isdefined( var_0[var_6] ) )
            thread cg_kill_entity_on_transition( var_0[var_6], "tff_pre_intro_to_middle" );
    }

    common_scripts\utility::flag_wait( "flag_camp_visibility_04" );
    var_5[0] delete();
    var_5[1] delete();
}

cg_setup_civs_fence()
{
    thread cg_setup_civ_fence_special();

    while ( !common_scripts\utility::flag( "flag_camp_visibility_04" ) )
    {
        var_0 = [];
        var_1 = [ "civ_urban_male_body_c_green_afr_dark", "civ_urban_male_body_b_green_asi", "civ_urban_male_body_c_solid_teal_afr_light", "civ_urban_male_body_b", "civ_urban_male_body_f_black_pants", "civ_urban_male_body_e_solid_brown_mde", "civ_urban_male_body_e_solid_yellow" ];
        var_2 = [ "head_m_gen_afr_bowman", "head_m_act_asi_chen_base", "head_m_gen_afr_rice", "head_m_act_cau_ramsay_base", "head_m_gen_cau_anderson", "head_m_gen_mde_urena", "head_m_gen_cau_anderson" ];
        var_3 = [ "civ_fence1_spawner", "civ_fence3_spawner", "civ_fence4_spawner", "civ_fence5_spawner", "civ_fence6_spawner", "civ_fence7_spawner", "civ_fence8_spawner" ];
        var_4 = [ "fence_spawner1", "fence_spawner3", "fence_spawner4", "fence_spawner5", "fence_spawner6", "fence_spawner7", "fence_spawner8" ];
        var_5 = [];

        for ( var_6 = 0; var_6 < var_1.size; var_6++ )
        {
            var_7 = common_scripts\utility::getstruct( var_3[var_6], "targetname" );
            var_5[var_6] = spawn( "script_model", var_7.origin );
            var_5[var_6] _meth_80B1( var_1[var_6] );
            var_5[var_6] attach( var_2[var_6] );
            var_5[var_6] setcontents( 0 );
            var_5[var_6].angles = var_7.angles;
            var_5[var_6].animname = "drone_civs";
            var_5[var_6] maps\_anim::setanimtree();
            var_7 thread maps\_anim::anim_loop_solo( var_5[var_6], var_4[var_6] );
            var_0[var_0.size] = var_5[var_6];
        }

        wait 1.0;

        for ( var_6 = 0; var_6 < var_0.size; var_6++ )
        {
            if ( isdefined( var_0[var_6] ) )
                thread cg_kill_entity_on_transition( var_0[var_6], "tff_pre_intro_to_middle" );
        }

        common_scripts\utility::flag_wait( "flag_camp_visibility_03b" );
        common_scripts\utility::flag_clear( "flag_camp_visibility_03a" );

        for ( var_6 = 0; var_6 < var_5.size; var_6++ )
            var_5[var_6] delete();

        common_scripts\utility::flag_wait( "flag_camp_visibility_03a" );
        common_scripts\utility::flag_clear( "flag_camp_visibility_03b" );
    }
}

cg_setup_civ_fence_special()
{
    var_0 = common_scripts\utility::getstruct( "civ_fence9_spawner", "targetname" );
    var_1 = spawn( "script_model", var_0.origin );
    var_1 _meth_80B1( "civ_urban_male_body_c_mde" );
    var_1 attach( "head_m_gen_mde_urena" );
    var_1 setcontents( 0 );
    var_1.angles = var_0.angles;
    var_1.animname = "drone_civs";
    var_1 maps\_anim::setanimtree();
    var_1 thread maps\_anim::anim_loop_solo( var_1, "fence_spawner9_idle_start" );
    common_scripts\utility::flag_wait( "flag_civ_fence_sit" );
    var_1 notify( "stop_loop" );
    var_1 maps\_anim::anim_single_solo( var_1, "fence_spawner9_transition" );
    var_1 thread maps\_anim::anim_loop_solo( var_1, "fence_spawner9_idle_end" );

    if ( isdefined( var_1 ) )
        thread cg_kill_entity_on_transition( var_1, "tff_pre_intro_to_middle" );

    while ( !common_scripts\utility::flag( "flag_camp_visibility_04" ) )
    {
        common_scripts\utility::flag_wait( "flag_camp_visibility_03b" );
        var_1 delete();
        common_scripts\utility::flag_clear( "flag_camp_visibility_03a" );
        common_scripts\utility::flag_wait( "flag_camp_visibility_03a" );
        var_1 = spawn( "script_model", var_0.origin );
        var_1 _meth_80B1( "civ_urban_male_body_c_mde" );
        var_1 attach( "head_m_gen_mde_urena" );
        var_1 setcontents( 0 );
        var_1.angles = var_0.angles;
        var_1.animname = "drone_civs";
        var_1 maps\_anim::setanimtree();
        var_1 thread maps\_anim::anim_loop_solo( var_1, "fence_spawner9_idle_end" );
        common_scripts\utility::flag_clear( "flag_camp_visibility_03b" );
    }
}

cg_setup_civs_baseball()
{
    common_scripts\utility::flag_wait( "flag_camp_visibility_01" );
    var_0 = getent( "org_baseball", "targetname" );
    var_1 = [];
    var_2 = [ "civ_urban_male_body_g", "civ_urban_male_body_e_solid_brown", "ehq_baseball_glove_01", "ehq_baseball_glove_01" ];
    var_3 = [ "head_m_act_cau_ramsay_base", "head_m_act_cau_manasi_base" ];
    var_4 = [ "civ_baseball1_spawner", "civ_baseball2_spawner", "baseball_glove1", "baseball_glove2" ];
    var_5 = [ "baseball2", "baseball1", "baseball_glove1", "baseball_glove2" ];
    var_6 = [];

    for ( var_7 = 0; var_7 < var_2.size; var_7++ )
    {
        var_8 = common_scripts\utility::getstruct( var_4[var_7], "targetname" );
        var_6[var_7] = spawn( "script_model", var_8.origin );
        var_6[var_7] _meth_80B1( var_2[var_7] );

        if ( var_7 < 2 )
        {
            var_6[var_7] attach( var_3[var_7] );
            var_6[var_7].animname = "drone_civs";
        }

        if ( var_7 >= 2 )
            var_6[var_7].animname = "baseball_glove";

        var_6[var_7] setcontents( 0 );
        var_6[var_7].angles = var_8.angles;
        var_6[var_7] maps\_anim::setanimtree();
        var_0 thread maps\_anim::anim_loop_solo( var_6[var_7], var_5[var_7] );
        var_1[var_1.size] = var_6[var_7];
    }

    var_6[1] attach( "ehq_baseball", "tag_weapon_chest" );

    for ( var_7 = 0; var_7 < var_1.size; var_7++ )
    {
        if ( isdefined( var_1[var_7] ) )
            thread cg_kill_entity_on_transition( var_1[var_7], "tff_pre_intro_to_middle" );
    }

    common_scripts\utility::flag_wait( "flag_camp_visibility_04" );

    for ( var_7 = 0; var_7 < var_6.size; var_7++ )
        var_6[var_7] delete();
}

cg_setup_social_groups()
{
    var_0 = [];
    var_1 = [ "civilian_smoking_a", "civilian_smoking_b", "civilian_atm", "civilian_stand_idle", "london_civ_idle_checkwatch", "london_civ_idle_foldarms2", "london_civ_idle_lookbehind", "london_civ_idle_foldarms_scratchass", "london_civ_idle_scratchnose" ];
    var_2 = [ "civilian_sitting_business_lunch_a_1", "civilian_sitting_business_lunch_b_1", "civilian_sitting_talking_a_1", "civilian_sitting_talking_a_2", "civilian_sitting_talking_b_1", "civilian_sitting_talking_b_2", "civilian_texting_sitting", "civilian_reader_1", "sitting_guard_loadak_idle", "guarda_sit_sleeper_idle", "parabolic_leaning_guy_idle", "civilian_stand_idle", "det_camp_box_seated_civ_guy01", "det_camp_box_seated_civ_guy02", "det_camp_box_seated_civ_guy02", "sitting_guard_loadak_idle", "civilian_reader_2" ];
    var_3 = [ "civ_urban_male_body_c_blue_afr_light", "civ_urban_male_body_c_solid_teal_mde", "civ_urban_male_body_e_solid_yellow_mde", "civ_urban_male_body_e_solid_red", "civ_urban_male_body_e_solid_brown_mde", "civ_urban_male_body_c_blue_shirt", "civ_urban_male_body_c_blue_mde", "civ_urban_male_body_c_gray_shirt", "civ_urban_male_body_e_solid_brown_mde", "civ_urban_male_body_d_afr_light", "civ_urban_male_body_e", "civ_urban_male_body_c_solid_red_mde", "civ_urban_male_body_c_green_afr_dark", "civ_urban_male_body_b_green_asi", "civ_urban_male_body_c_solid_teal_afr_light", "civ_urban_male_body_b", "civ_urban_male_body_a_mde", "civ_urban_male_body_e_solid_brown_mde", "civ_urban_male_body_e_solid_yellow", "civ_urban_male_body_e_solid_teal_afr_light" ];
    var_4 = [ "head_m_act_afr_brickerson_base", "head_m_gen_mde_smith", "head_m_gen_cau_clark", "head_m_gen_cau_barton", "head_m_gen_mde_hanks", "head_m_gen_cau_young", "head_m_gen_mde_smith", "head_m_gen_cau_anderson", "head_m_gen_mde_hanks", "head_m_gen_afr_rice", "head_m_act_cau_manasi_base", "head_m_gen_mde_urena", "head_m_gen_afr_bowman", "head_m_act_asi_chen_base", "head_m_gen_afr_rice", "head_m_act_cau_ramsay_base", "head_m_gen_mde_smith", "head_m_gen_mde_urena", "head_m_gen_cau_anderson", "head_m_act_afr_sykes_base" ];
    var_5 = getentarray( "civ_life_scene_01", "targetname" );
    var_6 = getentarray( "civ_life_scene_02", "targetname" );
    var_7 = common_scripts\utility::getstructarray( "civ_life_scene_01", "targetname" );
    var_8 = common_scripts\utility::getstructarray( "civ_life_scene_02", "targetname" );
    var_9 = common_scripts\utility::array_combine( var_7, var_8 );
    var_10 = getentarray( "spnr_civs_food_herd_01", "targetname" );
    var_11 = getentarray( "civ_life_scene_01_orgs", "targetname" );
    var_9 = common_scripts\utility::array_combine( var_9, var_11 );
    level.section_1_civilians = [];
    var_12 = 0;

    foreach ( var_14 in var_9 )
    {
        var_15 = spawn( "script_model", var_14.origin );

        if ( var_12 >= var_3.size )
            var_12 = 0;

        var_15 _meth_80B1( var_3[var_12] );
        var_15 attach( var_4[var_12] );
        var_15 setcontents( 0 );
        var_15.origin = var_14.origin;
        var_15.angles = var_14.angles;
        var_15.animname = "drone_civs";
        var_15 maps\_anim::setanimtree();
        var_15 thread maps\detroit_refugee_camp::delete_me_on_notify();
        level.section_1_civilians[level.section_1_civilians.size] = var_15;

        if ( isdefined( var_14.script_noteworthy ) && var_14.script_noteworthy == "civ_sitting" )
            var_14 thread maps\_anim::anim_loop_solo( var_15, common_scripts\utility::random( var_2 ) );
        else
            var_14 thread maps\_anim::anim_loop_solo( var_15, common_scripts\utility::random( var_1 ) );

        var_0[var_0.size] = var_15;
        var_12 += 1;
    }

    level.tent_scene_civilians_01 = [];
    level.tent_scene_civilians_02 = [];
    var_17 = common_scripts\utility::getstructarray( "civ_tent_scene_01", "targetname" );
    var_18 = common_scripts\utility::getstructarray( "civ_tent_scene_02", "targetname" );
    var_12 = 0;

    foreach ( var_14 in var_18 )
    {
        if ( var_12 >= var_3.size )
            var_12 = 0;

        if ( maps\_shg_design_tools::percentchance( 50 ) )
        {
            var_15 = spawn( "script_model", var_14.origin );
            var_15 _meth_80B1( var_3[var_12] );
            var_15 attach( var_4[var_12] );
            var_15 setcontents( 0 );
            var_15.origin = var_14.origin;
            var_15.angles = var_14.angles;
            var_15.animname = "drone_civs";
            var_15 maps\_anim::setanimtree();
            var_15 thread maps\detroit_refugee_camp::delete_me_on_notify();
            level.tent_scene_civilians_02[level.tent_scene_civilians_02.size] = var_15;

            if ( var_14.animation == "civilian_smoking_b" || var_14.animation == "civilian_smoking_a" )
                var_15 attach( "prop_cigarette", "tag_inhand", 1 );

            var_14 thread maps\_anim::anim_loop_solo( var_15, var_14.animation );
            var_12 += 1;
            var_0[var_0.size] = var_15;
        }
    }

    while ( !common_scripts\utility::flag( "flag_camp_visibility_04" ) )
    {
        var_12 = 0;

        foreach ( var_14 in var_17 )
        {
            if ( var_12 >= var_3.size )
                var_12 = 0;

            if ( maps\_shg_design_tools::percentchance( 50 ) )
            {
                var_15 = spawn( "script_model", var_14.origin );
                var_15 _meth_80B1( var_3[var_12] );
                var_15 attach( var_4[var_12] );
                var_15 setcontents( 0 );
                var_15.origin = var_14.origin;
                var_15.angles = var_14.angles;
                var_15.animname = "drone_civs";
                var_15 maps\_anim::setanimtree();
                var_15 thread maps\detroit_refugee_camp::delete_me_on_notify();
                level.tent_scene_civilians_01[level.tent_scene_civilians_01.size] = var_15;

                if ( var_14.animation == "civilian_smoking_b" || var_14.animation == "civilian_smoking_a" )
                    var_15 attach( "prop_cigarette", "tag_inhand", 1 );

                var_14 thread maps\_anim::anim_loop_solo( var_15, var_14.animation );
                var_12 += 1;
                var_0[var_0.size] = var_15;
            }
        }

        for ( var_12 = 0; var_12 < var_0.size; var_12++ )
        {
            if ( isdefined( var_0[var_12] ) )
                thread cg_kill_entity_on_transition( var_0[var_12], "tff_pre_intro_to_middle" );
        }

        common_scripts\utility::flag_wait( "flag_camp_visibility_03b" );
        common_scripts\utility::flag_clear( "flag_camp_visibility_03a" );
        common_scripts\utility::array_thread( level.tent_scene_civilians_01, maps\_shg_design_tools::delete_auto );
        common_scripts\utility::flag_wait( "flag_camp_visibility_03a" );
        common_scripts\utility::flag_clear( "flag_camp_visibility_03b" );
        wait 0.2;
    }

    for ( var_12 = 0; var_12 < var_0.size; var_12++ )
    {
        if ( isdefined( var_0[var_12] ) )
            thread cg_kill_entity_on_transition( var_0[var_12], "tff_pre_intro_to_middle" );
    }

    common_scripts\utility::array_thread( level.section_1_civilians, maps\_shg_design_tools::delete_auto );
    common_scripts\utility::array_thread( level.tent_scene_civilians_01, maps\_shg_design_tools::delete_auto );
    common_scripts\utility::array_thread( level.tent_scene_civilians_02, maps\_shg_design_tools::delete_auto );
}

cg_civ_conversation_gag1()
{
    var_0 = [];
    var_1 = [ "civ_urban_female_body_g_afr_light", "civ_african_male_body_d", "civ_urban_male_body_c_gray_afr_light", "civ_urban_female_body_e_asi" ];
    var_2 = [ "head_f_gen_afr_rice", "head_m_gen_cau_clark", "head_m_gen_afr_rice", "head_f_gen_asi_lee_base" ];
    var_3 = [ "sign1_spawner", "sign2_spawner", "sign3_spawner", "sign4_spawner" ];

    for ( var_4 = 1; var_4 < 5; var_4++ )
    {
        var_5 = getent( "civ_" + var_4 + "_spawner", "targetname" );
        var_6 = spawn( "script_model", var_5.origin );
        var_6 _meth_80B1( var_1[var_4 - 1] );
        var_6 attach( var_2[var_4 - 1] );
        var_6 setcontents( 0 );
        var_6.angles = var_5.angles;
        var_6.animname = "drone_civs";
        var_6 maps\_anim::setanimtree();
        var_5 thread maps\_anim::anim_loop_solo( var_6, var_3[var_4 - 1] );

        if ( var_4 == 1 )
            level.civ1 = var_6;

        if ( var_4 == 2 )
            level.civ2 = var_6;

        if ( var_4 == 3 )
            level.civ3 = var_6;

        if ( var_4 == 4 )
            level.civ4 = var_6;

        var_0[var_0.size] = var_6;
    }

    for ( var_4 = 0; var_4 < var_0.size; var_4++ )
    {
        if ( isdefined( var_0[var_4] ) )
            thread cg_kill_entity_on_transition( var_0[var_4], "tff_pre_intro_to_middle" );
    }

    maps\detroit_school::continue_when_player_near_entity( level.civ1, 250 );
    common_scripts\utility::flag_set( "vo_civ_convo_01" );
    common_scripts\utility::flag_wait( "flag_camp_visibility_04" );
    level.civ1 delete();
    level.civ2 delete();
    level.civ3 delete();
    level.civ4 delete();
}

cg_spraypaint_gag()
{
    if ( !_func_21E( "detroit_intro_tr" ) )
        return;

    var_0 = [];
    var_1 = getent( "cg_grafitti_gag_model_clip", "targetname" );
    var_2 = getent( "sparaypaint_animspot", "targetname" );
    var_3 = common_scripts\utility::getstruct( "spraypaint_artist_spawner", "targetname" );
    var_4 = spawn( "script_model", var_3.origin );
    var_4 _meth_80B1( "civ_urban_female_body_e_asi" );
    var_4 attach( "head_f_gen_asi_lee_base" );
    var_4 setcontents( 0 );
    var_4 attach( "com_spray_can01", "tag_weapon_right" );
    var_1.origin = var_4.origin + ( 0, 0, 40 );
    var_1 _meth_804D( var_4, "J_MainRoot" );
    var_4.animname = "generic";
    var_4 _meth_8115( #animtree );
    var_2 thread maps\_anim::anim_loop_solo( var_4, "spraypaint_idle" );
    var_0[var_0.size] = var_4;
    var_4.goalradius = 15;

    if ( isdefined( var_4 ) )
        thread cg_kill_entity_on_transition( var_4, "tff_pre_intro_to_middle" );

    common_scripts\utility::flag_wait( "flag_gesture_spray_paint" );
    var_5 = getent( "spraypaint_guard", "targetname" );
    var_6 = var_5 maps\_utility::spawn_ai( 1 );
    var_6.ignoreall = 1;
    var_6.ignoreme = 1;
    var_6.goalradius = 15;
    var_6.animname = "generic";
    var_2 thread maps\_anim::anim_first_frame_solo( var_6, "chase_away" );
    var_0[var_0.size] = var_5;

    for ( var_7 = 0; var_7 < var_0.size; var_7++ )
    {
        if ( isdefined( var_0[var_7] ) )
            thread cg_kill_entity_on_transition( var_0[var_7], "tff_pre_intro_to_middle" );
    }

    thread cg_spraypaint_runner( var_4, var_2 );
    thread maps\detroit_refugee_camp::spraypaint_chaser( var_6, var_2 );
    wait 7.31;
    var_6 maps\_utility::dialogue_queue( "detroit_atd_heyhey" );
    thread maps\detroit_refugee_camp::unload_intro_cinematic_assets();
}

cg_spraypaint_runner( var_0, var_1 )
{
    var_1 maps\_anim::anim_single_solo( var_0, "spraypaint" );
    var_0 delete();
}

cg_setup_refugee_stage_audience()
{
    var_0 = [];
    common_scripts\utility::flag_wait( "flag_camp_visibility_01" );
    var_1 = [];
    var_2 = getentarray( "civilian_orgs_sitting", "targetname" );
    var_3 = [ "body_india_female_a", "body_india_male_b", "body_india_female_b", "civ_urban_female_body_g_afr_light", "civ_urban_male_body_e_solid_red_asi", "civ_urban_male_body_e_solid_brown_mde", "civ_urban_female_body_e_asi", "civ_urban_male_body_c_solid_yellow", "civ_urban_male_body_b_green_asi" ];
    var_4 = [ "head_india_female_a", "head_india_male_b", "head_india_female_b", "head_f_gen_afr_rice", "head_m_gen_asi_lee", "head_m_gen_mde_hanks", "head_f_gen_asi_lee_base", "head_m_act_cau_ramsay_base", "head_m_act_asi_chen_base" ];
    var_5 = [ "civilian_sitting_talking_b_1", "civilian_sitting_business_lunch_b_1", "civilian_sitting_business_lunch_a_1", "civilian_sitting_talking_a_2", "civilian_stand_idle", "civilian_sitting_talking_b_2", "civilian_stand_idle", "civilian_sitting_talking_a_1", "civilian_sitting_talking_b_2" ];
    var_6 = 0;

    foreach ( var_10, var_8 in var_2 )
    {
        if ( var_6 > var_3.size )
            var_6 = 0;

        if ( maps\_shg_design_tools::percentchance( 15 ) )
        {
            var_9 = spawn( "script_model", var_8.origin );
            var_9 _meth_80B1( var_3[var_6] );
            var_9 attach( var_4[var_6] );
            var_9 setcontents( 0 );
            var_9.angles = var_8.angles;
            var_9.animname = "drone_civs";
            var_9 maps\_anim::setanimtree();
            var_8 thread maps\_anim::anim_loop_solo( var_9, var_8.animation );
            var_1[var_1.size] = var_9;
            level.refugee_camp_ai[level.refugee_camp_ai.size] = var_9;
            var_6 += 1;
            var_0[var_0.size] = var_9;
        }

        wait(randomfloat( 0.25 ));
    }

    for ( var_6 = 0; var_6 < var_0.size; var_6++ )
    {
        if ( isdefined( var_0[var_6] ) )
            thread cg_kill_entity_on_transition( var_0[var_6], "tff_pre_intro_to_middle" );
    }

    common_scripts\utility::flag_wait( "flag_camp_visibility_04" );
    common_scripts\utility::array_call( var_1, ::delete );
}

cg_setup_refugee_stage_speaker()
{
    common_scripts\utility::flag_wait( "flag_stage_dialogue_start_audio" );
    var_0 = getent( "refugee_stage_speaker", "targetname" );
    var_1 = spawn( "script_model", var_0.origin );
    var_1 _meth_80B1( "civ_urban_female_body_g_afr_light" );
    var_1 attach( "head_f_gen_afr_rice" );
    var_1 setcontents( 0 );
    var_1.angles = var_0.angles;
    var_1.animname = "Atlas_Commander";
    var_1 _meth_8115( #animtree );
    var_0 = getent( "org_stage_speaker", "targetname" );
    var_0 maps\_anim::anim_single_solo( var_1, "det_camp_stagespeech_guy01" );
    var_1 delete();
}

cg_setup_hospital_bodies()
{
    maps\_utility::trigger_wait_targetname( "hospital_start" );
    var_0 = getent( "dead_spot", "targetname" );
    var_1 = spawn( "script_model", ( -4738, 7089, 39.5 ) );
    var_1 _meth_80B1( "body_civ_sf_male_b" );
    var_1 attach( "head_civ_sf_male_b", "J_Spine4" );
    var_1.animname = "generic";
    var_1 _meth_8115( #animtree );
    var_0 maps\_anim::anim_first_frame_solo( var_1, "deadpose_1" );
}

cg_kill_entity_on_transition( var_0, var_1 )
{
    level waittill( var_1 );

    if ( isdefined( var_0 ) )
        var_0 delete();
}

cg_kill_entity_on_flag( var_0, var_1 )
{
    common_scripts\utility::flag_wait( var_1 );

    if ( isdefined( var_0 ) )
        var_0 delete();
}

detroit_cg_precache_models()
{
    var_0 = [ "civ_urban_male_body_b_green_afr_dark", "civ_urban_male_body_c_blue_mde", "civ_urban_male_body_f_black_pants", "civ_urban_male_body_e_solid_red", "civ_urban_male_body_b_green_mde", "civ_urban_male_body_c_solid_yellow_afr_light", "civ_urban_male_body_c_solid_yellow", "civ_urban_male_body_e", "civ_urban_male_body_b_red_afr_light", "civ_urban_male_body_e_solid_teal_afr_light", "civ_urban_male_body_e_solid_yellow_mde", "civ_urban_male_body_c_green_afr_dark", "civ_urban_male_body_b_green_asi", "civ_urban_male_body_c_solid_teal_afr_light", "civ_urban_male_body_b", "civ_urban_male_body_a_mde", "civ_urban_male_body_e_solid_brown_mde", "civ_urban_male_body_e_solid_yellow", "civ_urban_male_body_c_mde", "civ_urban_male_body_g", "civ_urban_male_body_e_solid_brown", "civ_urban_male_body_c_blue_afr_light", "civ_urban_male_body_c_solid_teal_mde", "civ_urban_male_body_c_blue_shirt", "civ_urban_male_body_d_afr_light", "civ_urban_male_body_c_solid_red_mde", "civ_urban_male_body_c_gray_shirt", "civ_urban_female_body_g_afr_light", "civ_african_male_body_d", "civ_urban_male_body_c_gray_afr_light", "body_india_female_a", "body_india_male_b", "body_india_female_b", "civ_urban_male_body_e_solid_red_asi", "civ_urban_female_body_e_asi", "head_m_act_cau_kanik_base", "head_m_gen_cau_anderson", "head_m_gen_mde_azzam", "head_m_gen_afr_davis", "head_m_gen_mde_urena", "head_m_act_afr_brickerson_base", "head_m_act_cau_manasi_base", "head_m_act_cau_ramsay_base", "head_m_gen_afr_rice", "head_m_act_afr_sykes_base", "head_m_gen_afr_bowman", "head_m_act_asi_chen_base", "head_m_gen_mde_smith", "head_m_gen_cau_clark", "head_m_gen_cau_barton", "head_m_gen_mde_hanks", "head_m_gen_cau_young", "head_india_female_a", "head_india_male_b", "head_india_female_b", "head_m_gen_asi_lee", "head_f_gen_afr_rice", "head_f_gen_asi_lee_base", "ehq_baseball", "ehq_baseball_glove_01", "prop_cigarette", "body_civ_sf_male_b", "head_civ_sf_male_b" ];

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        precachemodel( var_0[var_1] );
}
