// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

precachecivilian()
{
    precachepropmodels();
    precacheciviliananims();
}

precachepropmodels()
{
    precachemodel( "electronics_pda" );
    precachemodel( "com_cellphone_on" );
    precachemodel( "prop_cigarette" );
    precachemodel( "greece_cafe_gps_pad" );
}

#using_animtree("generic_human");

precacheciviliananims()
{
    level.scr_animtree["generic"] = #animtree;
    level.scr_anim["generic"]["civilian_texting_standing"][0] = %civilian_texting_standing;
    level.scr_anim["generic"]["civilian_stand_idle"][0] = %civilian_stand_idle;
    level.scr_anim["generic"]["civilian_smoking_A"][0] = %civilian_smoking_a;
    level.scr_anim["generic"]["london_station_civ1_idle"][0] = %london_station_civ1_idle;
    level.scr_anim["generic"]["london_station_civ2_idle"][0] = %london_station_civ2_idle;
    level.scr_anim["generic"]["london_station_civ4_idle"][0] = %london_station_civ4_idle;
    level.scr_anim["generic"]["london_station_civ5_idle"][0] = %london_station_civ5_idle;
    level.scr_anim["generic"]["london_station_civ7_idle"][0] = %london_station_civ7_idle;
    level.scr_anim["generic"]["london_station_civ11_idle"][0] = %london_station_civ11_idle;
    level.scr_anim["generic"]["parabolic_leaning_guy_smoking_idle"][0] = %parabolic_leaning_guy_smoking_idle;
    level.scr_anim["generic"]["parabolic_leaning_guy_idle"][0] = %parabolic_leaning_guy_idle;
    level.scr_anim["generic"]["oilrig_balcony_smoke_idle"][0] = %oilrig_balcony_smoke_idle;
    level.scr_anim["generic"]["civilian_directions_1_A"][0] = %civilian_directions_1_a;
    level.scr_anim["generic"]["civilian_directions_1_B"][0] = %civilian_directions_1_b;
    level.scr_anim["generic"]["hms_greece_market_shopper_idle_01"][0] = %hms_greece_market_shopper_idle_01;
    level.scr_anim["generic"]["hms_greece_market_shopper_idle_02"][0] = %hms_greece_market_shopper_idle_02;
    level.scr_anim["generic"]["hms_greece_market_shopper_idle_03"][0] = %hms_greece_market_shopper_idle_03;
    level.scr_anim["generic"]["hms_greece_market_shopper_idle_04"][0] = %hms_greece_market_shopper_idle_04;
    level.scr_anim["generic"]["hms_greece_market_shopper_idle_05"][0] = %hms_greece_market_shopper_idle_05;
    level.scr_anim["generic"]["hms_greece_market_shopper_idle_06"][0] = %hms_greece_market_shopper_idle_06;
    level.scr_anim["generic"]["hms_greece_market_shopper_idle_07"][0] = %hms_greece_market_shopper_idle_07;
    level.scr_anim["generic"]["hms_greece_market_shopper_idle_08"][0] = %hms_greece_market_shopper_idle_08;
    level.scr_anim["generic"]["hms_greece_market_shopper_idle_09"][0] = %hms_greece_market_shopper_idle_09;
    level.scr_anim["generic"]["civilian_texting_sitting"][0] = %civilian_texting_sitting;
    level.scr_anim["generic"]["guardB_sit_drinker_idle"][0] = %guardb_sit_drinker_idle;
    level.scr_anim["generic"]["london_civ_idle_lookover"] = %london_civ_idle_lookover;
    level.scr_anim["generic"]["london_civ_idle_checkwatch"] = %london_civ_idle_checkwatch;
    level.scr_anim["generic"]["london_civ_idle_lookbehind"] = %london_civ_idle_lookbehind;
    level.scr_anim["generic"]["london_civ_idle_scratchnose"] = %london_civ_idle_scratchnose;
    level.scr_anim["generic"]["london_civ_idle_foldarms_scratchass"] = %london_civ_idle_foldarms_scratchass;
    level.scr_anim["generic"]["london_civ_idle_foldarms2"] = %london_civ_idle_foldarms2;
    level.scr_anim["generic"]["hms_greece_market_civ_idle_01"] = %hms_greece_market_civ_idle_01;
    level.scr_anim["generic"]["hms_greece_market_civ_idle_02"] = %hms_greece_market_civ_idle_02;
    level.scr_anim["generic"]["hms_greece_market_civ_idle_03"] = %hms_greece_market_civ_idle_03;
    level.scr_anim["generic"]["hms_greece_market_civ_idle_04"] = %hms_greece_market_civ_idle_04;
    level.randomidleanims = [];
    level.randomidleanims[0] = "london_civ_idle_lookover";
    level.randomidleanims[1] = "london_civ_idle_checkwatch";
    level.randomidleanims[2] = "london_civ_idle_lookbehind";
    level.randomidleanims[3] = "london_civ_idle_foldarms_scratchass";
    level.randomidleanims[4] = "london_civ_idle_foldarms2";
    level.randomidleanims[5] = "london_civ_idle_scratchnose";
    level.randomidleanims[6] = "hms_greece_market_civ_idle_01";
    level.randomidleanims[7] = "hms_greece_market_civ_idle_02";
    level.randomidleanims[8] = "hms_greece_market_civ_idle_03";
    level.randomidleanims[9] = "hms_greece_market_civ_idle_04";
    var_0 = [];
    var_0[0] = 2;
    var_0[1] = 1;
    var_0[2] = 1;
    var_0[3] = 1;
    level.scr_anim["civilian_crazy_walk"]["run_noncombat"][0] = %civilian_crazywalker_loop;
    level.scr_anim["civilian_crazy_walk"]["run_noncombat"][1] = %civilian_crazywalker_twitcha;
    level.scr_anim["civilian_crazy_walk"]["run_noncombat"][2] = %civilian_crazywalker_twitchb;
    level.scr_anim["civilian_crazy_walk"]["run_noncombat"][3] = %civilian_crazywalker_twitchc;
    level.scr_anim["civilian_crazy_walk"]["run_weights"] = var_0;
    var_1 = [];
    var_1[0] = 7;
    var_1[1] = 3;
    var_2 = common_scripts\utility::get_cumulative_weights( var_1 );
    level.scr_anim["civilian_cellphone_walk"]["run_noncombat"][0] = %civilian_cellphonewalk;
    level.scr_anim["civilian_cellphone_walk"]["dodge_left"] = %civilian_cellphonewalk_dodge_l;
    level.scr_anim["civilian_cellphone_walk"]["dodge_right"] = %civilian_cellphonewalk_dodge_r;
    level.scr_anim["civilian_cellphone_walk"]["turn_left_90"] = %civilian_cellphonewalk_turn_l;
    level.scr_anim["civilian_cellphone_walk"]["turn_right_90"] = %civilian_cellphonewalk_turn_r;
    level.scr_anim["civilian_soda_walk"]["run_noncombat"][0] = %civilian_sodawalk;
    level.scr_anim["civilian_soda_walk"]["run_noncombat"][1] = %civilian_sodawalk_twitch;
    level.scr_anim["civilian_soda_walk"]["run_weights"] = var_2;
    level.scr_anim["civilian_hurried_walk"]["run_noncombat"][0] = %civilian_walk_hurried_1;
    level.scr_anim["civilian_hurried_walk"]["run_noncombat"][1] = %civilian_walk_hurried_2;
    level.scr_anim["civilian_nervous_walk"]["run_noncombat"][0] = %civilian_walk_nervous;
    level.scr_anim["civilian_cool_walk"]["run_noncombat"][0] = %civilian_walk_cool;
    level.scr_anim["civilian_paper_walk"]["run_noncombat"][0] = %civilian_walk_paper;
    level.scr_anim["civilian_coffee_walk"]["run_noncombat"][0] = %civilian_walk_coffee;
    level.scr_anim["civilian_backpack_walk"]["run_noncombat"][0] = %civilian_walk_backpack;
    level.scr_anim["civilian_backpack_walk"]["run_noncombat"][1] = %civilian_walk_backpack_twitch;
    level.scr_anim["civilian_backpack_walk"]["run_weights"] = var_2;
    level.scr_anim["civilian_pda_walk"]["run_noncombat"][0] = %civilian_walk_pda;
    level.scr_anim["civilian_briefcase_walk"]["run_noncombat"][0] = %civilian_briefcase_walk;
    level.scr_anim["civilian_briefcase_walk"]["dodge_left"] = %civilian_briefcase_walk_dodge_l;
    level.scr_anim["civilian_briefcase_walk"]["dodge_right"] = %civilian_briefcase_walk_dodge_r;
    level.scr_anim["civilian_briefcase_walk"]["turn_left_90"] = %civilian_briefcase_walk_turn_l;
    level.scr_anim["civilian_briefcase_walk"]["turn_right_90"] = %civilian_briefcase_walk_turn_r;
    level.scr_anim["civilian_walk_male"]["run_noncombat"][0] = %hms_greece_market_civ_walk_male_01;
    level.scr_anim["civilian_walk_male"]["run_noncombat"][1] = %hms_greece_market_civ_walk_look_male_01;
    level.scr_anim["civilian_walk_male"]["run_weights"] = var_2;
    level.scr_anim["civilian_walk_male"]["dodge_left"] = %hms_greece_market_civ_walk_briefcase_dodge_l_alt;
    level.scr_anim["civilian_walk_male"]["dodge_right"] = %hms_greece_market_civ_walk_briefcase_dodge_r_alt;
    level.scr_anim["civilian_slow_walk_male"]["run_noncombat"][0] = %hms_greece_market_civ_walk_slow_male_01;
    level.scr_anim["civilian_slow_walk_male"]["run_noncombat"][1] = %hms_greece_market_civ_walk_slow_look_male_01;
    level.scr_anim["civilian_slow_walk_male"]["run_weights"] = var_2;
    level.scr_anim["civilian_slow_walk_male"]["dodge_left"] = %hms_greece_market_civ_walk_briefcase_dodge_l_alt;
    level.scr_anim["civilian_slow_walk_male"]["dodge_right"] = %hms_greece_market_civ_walk_briefcase_dodge_r_alt;
    level.scr_anim["civilian_slow_walk_female"]["run_noncombat"][0] = %hms_greece_market_civ_walk_slow_female_01;
    level.scr_anim["civilian_slow_walk_female"]["run_noncombat"][1] = %hms_greece_market_civ_walk_slow_look_female_01;
    level.scr_anim["civilian_slow_walk_female"]["run_weights"] = var_2;
    level.scr_anim["civilian_slow_walk_female"]["dodge_left"] = %hms_greece_market_civ_walk_briefcase_dodge_l_alt;
    level.scr_anim["civilian_slow_walk_female"]["dodge_right"] = %hms_greece_market_civ_walk_briefcase_dodge_r_alt;
}

populatedronecivilians( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 1;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    var_4 = [];

    foreach ( var_6 in var_1 )
    {
        var_7 = var_0 maps\_utility::dronespawn();
        var_4 = common_scripts\utility::array_add( var_4, var_7 );
        var_0.count = 1;
        var_7.origin = var_6.origin;
        var_7.angles = var_6.angles;

        if ( isdefined( var_6.script_noteworthy ) )
            var_7.script_noteworthy = var_6.script_noteworthy;

        wait 0.05;

        if ( var_6.animation == "random" )
        {
            var_7 thread randomidleanimation( var_6 );
            continue;
        }

        if ( var_2 == 1 )
        {
            var_7 thread loopingidleanimation( var_6 );
            continue;
        }

        var_7 thread singleanimation( var_6, var_3 );
    }

    return var_4;
}

randomidleanimation( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        var_1 = common_scripts\utility::random( level.randomidleanims );
        var_0 maps\_anim::anim_generic( self, var_1 );
        wait 0.05;
    }
}

loopingidleanimation( var_0 )
{
    self.animname = "generic";
    var_1 = var_0.animation;
    var_0 thread maps\_anim::anim_generic_loop( self, var_1 );
    var_2 = attachprops( var_1 );
    self waittill( "death" );

    if ( isdefined( var_2 ) )
        var_2 delete();
}

singleanimation( var_0, var_1 )
{
    self.animname = "generic";
    var_2 = var_0.animation;
    var_3 = attachprops( var_2 );

    if ( var_1 == 1 )
    {
        var_0 maps\_anim::anim_generic( self, var_2 );

        if ( isdefined( var_3 ) )
            var_3 delete();

        self delete();
    }
    else
    {
        var_0 thread maps\_anim::anim_generic( self, var_2 );
        self waittill( "death" );

        if ( isdefined( var_3 ) )
            var_3 delete();
    }
}

attachprops( var_0 )
{
    if ( isdefined( self.hasattachedprops ) )
        return;

    initcivilianprops();
    var_1 = anim.civilianprops[var_0];

    if ( isdefined( var_1 ) )
    {
        var_2 = self attach( var_1, "tag_inhand", 1 );
        self.hasattachedprops = 1;
        return var_2;
    }
}

initcivilianprops()
{
    if ( isdefined( anim.civilianprops ) )
        anim.civilianprops = [];

    anim.civilianprops["civilian_texting_standing"] = "electronics_pda";
    anim.civilianprops["civilian_texting_sitting"] = "electronics_pda";
    anim.civilianprops["civilian_directions_2_A_idle"] = "electronics_pda";
    anim.civilianprops["civilian_sitting_business_lunch_A_1"] = "com_cellphone_on";
    anim.civilianprops["civilian_sitting_business_lunch_B_1"] = "com_cellphone_on";
    anim.civilianprops["civilian_smoking_A"] = "prop_cigarette";
    anim.civilianprops["civilian_smoking_B"] = "prop_cigarette";
    anim.civilianprops["parabolic_leaning_guy_smoking_idle"] = "prop_cigarette";
    anim.civilianprops["oilrig_balcony_smoke_idle"] = "prop_cigarette";
    anim.civilianprops["hms_greece_cc_takedown_idle_target"] = "prop_cigarette";
    anim.civilianprops["civilian_sitting_business_lunch_A_1"] = "com_cellphone_on";
    anim.civilianprops["civilian_sitting_business_lunch_B_1"] = "com_cellphone_on";
    anim.civilianprops["civilian_reader_1"] = "greece_cafe_gps_pad";
    anim.civilianprops["civilian_reader_2"] = "greece_cafe_gps_pad";
    anim.civilianprops["civilian_cellphone_walk"] = "com_cellphone_on";
    anim.civilianprops["civilian_soda_walk"] = "ma_cup_single_closed";
}
