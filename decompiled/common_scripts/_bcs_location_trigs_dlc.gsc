// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

bcs_location_trigs_dlc_init()
{
    if ( isdefined( level._id_25F9 ) && isdefined( anim.bcs_locations ) )
        return;

    level._id_1347 = [];
    bcs_dlc_location_trigger_mapping();
    bcs_dlc_trigs_assign_aliases();
    level._id_1347 = undefined;
    anim.locationlastcallouttimes = [];
}

bcs_dlc_trigs_assign_aliases()
{
    var_0 = getentarray();
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3.classname ) && issubstr( var_3.classname, "trigger_multiple_bcs" ) )
            var_1[var_1.size] = var_3;
    }

    foreach ( var_3 in var_1 )
    {
        if ( !isdefined( level._id_1347[var_3.classname] ) )
            continue;

        var_6 = _id_6695( level._id_1347[var_3.classname] );

        if ( var_6.size > 1 )
            var_6 = common_scripts\utility::array_randomize( var_6 );

        var_3.locationaliases = var_6;
        anim.bcs_locations[anim.bcs_locations.size] = var_3;
    }

    anim.bcs_locations = var_1;
}

_id_6695( var_0 )
{
    var_1 = strtok( var_0, " " );
    return var_1;
}

_id_0737( var_0, var_1 )
{
    if ( isdefined( level._id_1347[var_0] ) )
    {
        var_2 = level._id_1347[var_0];
        var_3 = _id_6695( var_2 );
        var_4 = _id_6695( var_1 );

        foreach ( var_6 in var_4 )
        {
            foreach ( var_8 in var_3 )
            {
                if ( var_6 == var_8 )
                    return;
            }
        }

        var_2 += ( " " + var_1 );
        level._id_1347[var_0] = var_2;
        return;
    }

    level._id_1347[var_0] = var_1;
}

bcs_dlc_location_trigger_mapping()
{
    if ( !common_scripts\utility::issp() )
    {
        clowntown_mp();
        torqued_mp();
        lost_mp();
        mp_urban();
        mp_climate_3();
        mp_perplex_1();
        mp_blackbox();
        mp_spark();
        mp_highrise2();
        mp_kremlin();
        mp_bigben2();
        mp_sector17();
        mp_seoul2();
        mp_liberty();
        mp_fracture();
        mp_lair();
    }
}

mp_lair()
{
    _id_0737( "trigger_multiple_bcs_mp_lair_plasma", "lair_plasma" );
    _id_0737( "trigger_multiple_bcs_mp_lair_offices", "lair_offices" );
    _id_0737( "trigger_multiple_bcs_mp_lair_bar", "lair_bar" );
    _id_0737( "trigger_multiple_bcs_mp_lair_patio", "lair_patio" );
    _id_0737( "trigger_multiple_bcs_mp_lair_dance", "lair_dance" );
    _id_0737( "trigger_multiple_bcs_mp_lair_hpad", "lair_hpad" );
    _id_0737( "trigger_multiple_bcs_mp_lair_wtower", "lair_wtower" );
    _id_0737( "trigger_multiple_bcs_mp_lair_court", "lair_court" );
    _id_0737( "trigger_multiple_bcs_mp_lair_fountain", "lair_fountain" );
    _id_0737( "trigger_multiple_bcs_mp_lair_spa", "lair_spa" );
    _id_0737( "trigger_multiple_bcs_mp_lair_etower", "lair_etower" );
    _id_0737( "trigger_multiple_bcs_mp_lair_deck", "lair_deck" );
}

mp_fracture()
{
    _id_0737( "trigger_multiple_bcs_mp_frac_fuel", "frac_fuel" );
    _id_0737( "trigger_multiple_bcs_mp_frac_base", "frac_base" );
    _id_0737( "trigger_multiple_bcs_mp_frac_exc_sites", "frac_exc_sites" );
    _id_0737( "trigger_multiple_bcs_mp_frac_shore", "frac_shore" );
    _id_0737( "trigger_multiple_bcs_mp_frac_obs_deck", "frac_obs_deck" );
    _id_0737( "trigger_multiple_bcs_mp_frac_crane", "frac_crane" );
}

mp_liberty()
{
    _id_0737( "trigger_multiple_bcs_mp_lib_parking", "lib_parking" );
    _id_0737( "trigger_multiple_bcs_mp_lib_trees", "lib_trees" );
    _id_0737( "trigger_multiple_bcs_mp_lib_medical", "lib_medical" );
    _id_0737( "trigger_multiple_bcs_mp_lib_sec", "lib_sec" );
    _id_0737( "trigger_multiple_bcs_mp_lib_sec_roof", "lib_sec_roof" );
    _id_0737( "trigger_multiple_bcs_mp_lib_monkeys", "lib_monkeys" );
    _id_0737( "trigger_multiple_bcs_mp_lib_catwalk", "lib_catwalk" );
    _id_0737( "trigger_multiple_bcs_mp_lib_camp", "lib_camp" );
    _id_0737( "trigger_multiple_bcs_mp_lib_res", "lib_res" );
    _id_0737( "trigger_multiple_bcs_mp_lib_ambu", "lib_ambu" );
    _id_0737( "trigger_multiple_bcs_mp_lib_hay", "lib_hay" );
    _id_0737( "trigger_multiple_bcs_mp_lib_loading", "lib_loading" );
}

mp_seoul2()
{
    _id_0737( "trigger_multiple_bcs_mp_se2_awn", "se2_awn" );
    _id_0737( "trigger_multiple_bcs_mp_se2_awn_blw", "se2_awn_blw" );
    _id_0737( "trigger_multiple_bcs_mp_se2_nom", "se2_nom" );
    _id_0737( "trigger_multiple_bcs_mp_se2_roof", "se2_roof" );
    _id_0737( "trigger_multiple_bcs_mp_se2_humvees", "se2_humvees" );
    _id_0737( "trigger_multiple_bcs_mp_se2_bus_area", "se2_bus_area" );
    _id_0737( "trigger_multiple_bcs_mp_se2_sak_fl2", "se2_sak_fl2" );
    _id_0737( "trigger_multiple_bcs_mp_se2_sak_fl1", "se2_sak_fl1" );
    _id_0737( "trigger_multiple_bcs_mp_se2_bar_fl2", "se2_bar_fl2" );
    _id_0737( "trigger_multiple_bcs_mp_se2_alley", "se2_alley" );
    _id_0737( "trigger_multiple_bcs_mp_se2_fork", "se2_fork" );
    _id_0737( "trigger_multiple_bcs_mp_se2_ddc", "se2_ddc" );
    _id_0737( "trigger_multiple_bcs_mp_se2_trailer", "se2_trailer" );
    _id_0737( "trigger_multiple_bcs_mp_se2_van", "se2_van" );
    _id_0737( "trigger_multiple_bcs_mp_se2_fish", "se2_fish" );
    _id_0737( "trigger_multiple_bcs_mp_se2_koi_fl2", "se2_koi_fl2" );
    _id_0737( "trigger_multiple_bcs_mp_se2_cargo", "se2_cargo" );
}

mp_sector17()
{
    _id_0737( "trigger_multiple_bcs_mp_sector17_entgate", "sector17_entgate" );
    _id_0737( "trigger_multiple_bcs_mp_sector17_bridge", "sector17_bridge" );
    _id_0737( "trigger_multiple_bcs_mp_sector17_alphabuild", "sector17_alphabuild" );
    _id_0737( "trigger_multiple_bcs_mp_sector17_alphapath", "sector17_alphapath" );
    _id_0737( "trigger_multiple_bcs_mp_sector17_centcont", "sector17_centcont" );
    _id_0737( "trigger_multiple_bcs_mp_sector17_hazmat", "sector17_hazmat" );
    _id_0737( "trigger_multiple_bcs_mp_sector17_airgate", "sector17_airgate" );
    _id_0737( "trigger_multiple_bcs_mp_sector17_forttop", "sector17_forttop" );
    _id_0737( "trigger_multiple_bcs_mp_sector17_fortbunk", "sector17_fortbunk" );
    _id_0737( "trigger_multiple_bcs_mp_sector17_forttunnel", "sector17_forttunnel" );
    _id_0737( "trigger_multiple_bcs_mp_sector17_bravobuild", "sector17_bravobuild" );
    _id_0737( "trigger_multiple_bcs_mp_sector17_bravolot", "sector17_bravolot" );
    _id_0737( "trigger_multiple_bcs_mp_sector17_charbuild", "sector17_charbuild" );
    _id_0737( "trigger_multiple_bcs_mp_sector17_rustbelt", "sector17_rustbelt" );
}

mp_bigben2()
{
    _id_0737( "trigger_multiple_bcs_mp_bigben_balcony", "bigben_balcony" );
    _id_0737( "trigger_multiple_bcs_mp_bigben_deck", "bigben_deck" );
    _id_0737( "trigger_multiple_bcs_mp_bigben_lodeck", "bigben_lodeck" );
    _id_0737( "trigger_multiple_bcs_mp_bigben_hallway", "bigben_hallway" );
    _id_0737( "trigger_multiple_bcs_mp_bigben_juncroom", "bigben_juncroom" );
    _id_0737( "trigger_multiple_bcs_mp_bigben_minideck", "bigben_minideck" );
    _id_0737( "trigger_multiple_bcs_mp_bigben_guns", "bigben_guns" );
    _id_0737( "trigger_multiple_bcs_mp_bigben_gunplat", "bigben_gunplat" );
    _id_0737( "trigger_multiple_bcs_mp_bigben_crates", "bigben_crates" );
    _id_0737( "trigger_multiple_bcs_mp_bigben_bridge", "bigben_bridge" );
    _id_0737( "trigger_multiple_bcs_mp_bigben_ramp", "bigben_ramp" );
    _id_0737( "trigger_multiple_bcs_mp_bigben_shore", "bigben_shore" );
    _id_0737( "trigger_multiple_bcs_mp_bigben_roof", "bigben_roof" );
    _id_0737( "trigger_multiple_bcs_mp_bigben_ticket", "bigben_ticket" );
    _id_0737( "trigger_multiple_bcs_mp_bigben_scrub", "bigben_scrub" );
}

mp_kremlin()
{
    _id_0737( "trigger_multiple_bcs_mp_kremlin_park", "kremlin_park" );
    _id_0737( "trigger_multiple_bcs_mp_kremlin_chkpoint", "kremlin_chkpoint" );
    _id_0737( "trigger_multiple_bcs_mp_kremlin_adminoffice", "kremlin_adminoffice" );
    _id_0737( "trigger_multiple_bcs_mp_kremlin_breach", "kremlin_breach" );
    _id_0737( "trigger_multiple_bcs_mp_kremlin_monument", "kremlin_monument" );
    _id_0737( "trigger_multiple_bcs_mp_kremlin_ecourtyard", "kremlin_ecourtyard" );
    _id_0737( "trigger_multiple_bcs_mp_kremlin_segallery", "kremlin_segallery" );
    _id_0737( "trigger_multiple_bcs_mp_kremlin_street", "kremlin_street" );
    _id_0737( "trigger_multiple_bcs_mp_kremlin_swgallery", "kremlin_swgallery" );
    _id_0737( "trigger_multiple_bcs_mp_kremlin_wcourt", "kremlin_wcourt" );
    _id_0737( "trigger_multiple_bcs_mp_kremlin_ngallery", "kremlin_ngallery" );
    _id_0737( "trigger_multiple_bcs_mp_kremlin_mainroom", "kremlin_mainroom" );
    _id_0737( "trigger_multiple_bcs_mp_kremlin_tower", "kremlin_tower" );
    _id_0737( "trigger_multiple_bcs_mp_kremlin_bridge", "kremlin_bridge" );
    _id_0737( "trigger_multiple_bcs_mp_kremlin_statue", "kremlin_statue" );
    _id_0737( "trigger_multiple_bcs_mp_kremlin_noverlook", "kremlin_noverlook" );
    _id_0737( "trigger_multiple_bcs_mp_kremlin_soverlook", "kremlin_soverlook" );
    _id_0737( "trigger_multiple_bcs_mp_kremlin_secourtyard", "kremlin_secourtyard" );
    _id_0737( "trigger_multiple_bcs_mp_kremlin_giftshop", "kremlin_giftshop" );
}

mp_highrise2()
{
    _id_0737( "trigger_multiple_bcs_mp_hrise_undrground", "hrise_undrground" );
    _id_0737( "trigger_multiple_bcs_mp_hrise_renbldg", "hrise_renbldg" );
    _id_0737( "trigger_multiple_bcs_mp_hrise_conbldg", "hrise_conbldg" );
    _id_0737( "trigger_multiple_bcs_mp_hrise_sidecrane", "hrise_sidecrane" );
    _id_0737( "trigger_multiple_bcs_mp_hrise_ovrcrane", "hrise_ovrcrane" );
    _id_0737( "trigger_multiple_bcs_mp_hrise_proproof", "hrise_proproof" );
    _id_0737( "trigger_multiple_bcs_mp_hrise_propground", "hrise_propground" );
    _id_0737( "trigger_multiple_bcs_mp_hrise_helopad", "hrise_helopad" );
    _id_0737( "trigger_multiple_bcs_mp_hrise_copter", "hrise_copter" );
}

mp_climate_3()
{
    _id_0737( "trigger_multiple_bcs_mp_cli_by_entr", "cli_by_entr" );
    _id_0737( "trigger_multiple_bcs_mp_cli_bywaterfall", "cli_bywaterfall" );
    _id_0737( "trigger_multiple_bcs_mp_cli_on_bridge", "cli_on_bridge" );
    _id_0737( "trigger_multiple_bcs_mp_cli_nr_br", "cli_nr_br" );
    _id_0737( "trigger_multiple_bcs_mp_cli_under_bridge", "cli_under_bridge" );
    _id_0737( "trigger_multiple_bcs_mp_cli_in_control", "cli_in_control" );
    _id_0737( "trigger_multiple_bcs_mp_cli_in_green", "cli_in_green" );
    _id_0737( "trigger_multiple_bcs_mp_cli_bygreen", "cli_bygreen" );
    _id_0737( "trigger_multiple_bcs_mp_cli_by_helo", "cli_by_helo" );
    _id_0737( "trigger_multiple_bcs_mp_cli_in_nurse", "cli_in_nurse" );
    _id_0737( "trigger_multiple_bcs_mp_cli_on_nur", "cli_on_nur" );
    _id_0737( "trigger_multiple_bcs_mp_cli_in_main", "cli_in_main" );
    _id_0737( "trigger_multiple_bcs_mp_cli_on_main", "cli_on_main" );
    _id_0737( "trigger_multiple_bcs_mp_cli_in_ravine", "cli_in_ravine" );
    _id_0737( "trigger_multiple_bcs_mp_cli_in_sewer", "cli_in_sewer" );
    _id_0737( "trigger_multiple_bcs_mp_cli_roof", "cli_roof" );
    _id_0737( "trigger_multiple_bcs_mp_cli_water", "cli_water" );
    _id_0737( "trigger_multiple_bcs_mp_cli_trees", "cli_trees" );
}

mp_perplex_1()
{
    _id_0737( "trigger_multiple_bcs_mp_per_atrium", "per_atrium" );
    _id_0737( "trigger_multiple_bcs_mp_per_roof", "per_roof" );
    _id_0737( "trigger_multiple_bcs_mp_per_on_gazebo", "per_on_gazebo" );
    _id_0737( "trigger_multiple_bcs_mp_per_in_gazebo", "per_in_gazebo" );
    _id_0737( "trigger_multiple_bcs_mp_per_ngaz", "per_ngaz" );
    _id_0737( "trigger_multiple_bcs_mp_per_on_bwalk", "per_on_bwalk" );
    _id_0737( "trigger_multiple_bcs_mp_per_in_rec", "per_in_rec" );
    _id_0737( "trigger_multiple_bcs_mp_per_by_center", "per_by_center" );
    _id_0737( "trigger_multiple_bcs_mp_per_on_rec", "per_on_rec" );
    _id_0737( "trigger_multiple_bcs_mp_per_in_office", "per_in_office" );
    _id_0737( "trigger_multiple_bcs_mp_per_on_office", "per_on_office" );
    _id_0737( "trigger_multiple_bcs_mp_per_by_office", "per_by_office" );
    _id_0737( "trigger_multiple_bcs_mp_per_in_gym", "per_in_gym" );
    _id_0737( "trigger_multiple_bcs_mp_per_on_gym", "per_on_gym" );
    _id_0737( "trigger_multiple_bcs_mp_per_nr_gym", "per_nr_gym" );
    _id_0737( "trigger_multiple_bcs_mp_per_whale", "per_whale" );
    _id_0737( "trigger_multiple_bcs_mp_per_on_apt", "per_on_apt" );
    _id_0737( "trigger_multiple_bcs_mp_per_in_apt", "per_in_apt" );
    _id_0737( "trigger_multiple_bcs_mp_per_by_apt", "per_by_apt" );
}

mp_blackbox()
{
    _id_0737( "trigger_multiple_bcs_mp_bla_cockpit", "bla_cockpit" );
    _id_0737( "trigger_multiple_bcs_mp_bla_by_cave", "bla_by_cave" );
    _id_0737( "trigger_multiple_bcs_mp_bla_in_cave", "bla_in_cave" );
    _id_0737( "trigger_multiple_bcs_mp_bla_midship", "bla_midship" );
    _id_0737( "trigger_multiple_bcs_mp_bla_cntr_plat", "bla_cntr_plat" );
    _id_0737( "trigger_multiple_bcs_mp_bla_engine", "bla_engine" );
    _id_0737( "trigger_multiple_bcs_mp_bla_cliffs", "bla_cliffs" );
    _id_0737( "trigger_multiple_bcs_mp_bla_wing", "bla_wing" );
    _id_0737( "trigger_multiple_bcs_mp_bla_catwalks", "bla_catwalks" );
    _id_0737( "trigger_multiple_bcs_mp_bla_tail", "bla_tail" );
    _id_0737( "trigger_multiple_bcs_mp_bla_spores", "bla_spores" );
}

mp_spark()
{
    _id_0737( "trigger_multiple_bcs_mp_sprk_train", "sprk_train" );
    _id_0737( "trigger_multiple_bcs_mp_sprk_fluid", "sprk_fluid" );
    _id_0737( "trigger_multiple_bcs_mp_sprk_drop", "sprk_drop" );
    _id_0737( "trigger_multiple_bcs_mp_sprk_rcs", "sprk_rcs" );
    _id_0737( "trigger_multiple_bcs_mp_sprk_scourt", "sprk_scourt" );
    _id_0737( "trigger_multiple_bcs_mp_sprk_aqua", "sprk_aqua" );
    _id_0737( "trigger_multiple_bcs_mp_sprk_ccs", "sprk_ccs" );
    _id_0737( "trigger_multiple_bcs_mp_sprk_ncourt", "sprk_ncourt" );
    _id_0737( "trigger_multiple_bcs_mp_sprk_ecs", "sprk_ecs" );
    _id_0737( "trigger_multiple_bcs_mp_sprk_office", "sprk_office" );
    _id_0737( "trigger_multiple_bcs_mp_sprk_topdep", "sprk_topdep" );
    _id_0737( "trigger_multiple_bcs_mp_sprk_gener", "sprk_gener" );
    _id_0737( "trigger_multiple_bcs_mp_sprk_ship", "sprk_ship" );
    _id_0737( "trigger_multiple_bcs_mp_sprk_security", "sprk_security" );
}

clowntown_mp()
{
    _id_0737( "trigger_multiple_bcs_mp_cltn_officeroof", "cltn_officeroof" );
    _id_0737( "trigger_multiple_bcs_mp_cltn_clownsign", "cltn_clownsign" );
    _id_0737( "trigger_multiple_bcs_mp_cltn_officeint", "cltn_officeint" );
    _id_0737( "trigger_multiple_bcs_mp_cltn_carwash", "cltn_carwash" );
    _id_0737( "trigger_multiple_bcs_mp_cltn_bridge", "cltn_bridge" );
    _id_0737( "trigger_multiple_bcs_mp_cltn_insidehotel", "cltn_insidehotel" );
    _id_0737( "trigger_multiple_bcs_mp_cltn_hotelroof", "cltn_hotelroof" );
    _id_0737( "trigger_multiple_bcs_mp_cltn_cemetery", "cltn_cemetery" );
    _id_0737( "trigger_multiple_bcs_mp_cltn_pool", "cltn_pool" );
    _id_0737( "trigger_multiple_bcs_mp_cltn_bathrooms", "cltn_bathrooms" );
    _id_0737( "trigger_multiple_bcs_mp_cltn_sewer", "cltn_sewer" );
    _id_0737( "trigger_multiple_bcs_mp_cltn_shed", "cltn_shed" );
    _id_0737( "trigger_multiple_bcs_mp_cltn_18wheeler", "cltn_18wheeler" );
    _id_0737( "trigger_multiple_bcs_mp_cltn_dumpster", "cltn_dumpster" );
    _id_0737( "trigger_multiple_bcs_mp_cltn_flatbed", "cltn_flatbed" );
    _id_0737( "trigger_multiple_bcs_mp_cltn_2ndstoryblcny", "cltn_2ndstoryblcny" );
}

torqued_mp()
{
    _id_0737( "trigger_multiple_bcs_mp_trq_tower", "trq_tower" );
    _id_0737( "trigger_multiple_bcs_mp_trq_oncarousel", "trq_oncarousel" );
    _id_0737( "trigger_multiple_bcs_mp_trq_bycarousel", "trq_bycarousel" );
    _id_0737( "trigger_multiple_bcs_mp_trq_upstairstrainstation", "trq_upstairstrainstation" );
    _id_0737( "trigger_multiple_bcs_mp_trq_downtrainstation", "trq_downtrainstation" );
    _id_0737( "trigger_multiple_bcs_mp_trq_ticketbooth", "trq_ticketbooth" );
    _id_0737( "trigger_multiple_bcs_mp_trq_bytrain", "trq_bytrain" );
    _id_0737( "trigger_multiple_bcs_mp_trq_ontrain", "trq_ontrain" );
    _id_0737( "trigger_multiple_bcs_mp_trq_christmastree", "trq_christmastree" );
    _id_0737( "trigger_multiple_bcs_mp_trq_office", "trq_office" );
    _id_0737( "trigger_multiple_bcs_mp_trq_overlook", "trq_overlook" );
    _id_0737( "trigger_multiple_bcs_mp_trq_lodge", "trq_lodge" );
    _id_0737( "trigger_multiple_bcs_mp_trq_skishop", "trq_skishop" );
    _id_0737( "trigger_multiple_bcs_mp_trq_bymarket", "trq_bymarket" );
    _id_0737( "trigger_multiple_bcs_mp_trq_onmarket", "trq_onmarket" );
    _id_0737( "trigger_multiple_bcs_mp_trq_awning", "trq_awning" );
    _id_0737( "trigger_multiple_bcs_mp_trq_snowbank", "trq_snowbank" );
    _id_0737( "trigger_multiple_bcs_mp_trq_snowtrench", "trq_snowtrench" );
}

lost_mp()
{
    _id_0737( "trigger_multiple_bcs_mp_lst_chemspill", "lst_chemspill" );
    _id_0737( "trigger_multiple_bcs_mp_lst_engineroom", "lst_engineroom" );
    _id_0737( "trigger_multiple_bcs_mp_lst_insphere", "lst_insphere" );
    _id_0737( "trigger_multiple_bcs_mp_lst_bysphere", "lst_bysphere" );
    _id_0737( "trigger_multiple_bcs_mp_lst_core", "lst_core" );
    _id_0737( "trigger_multiple_bcs_mp_lst_hallway", "lst_hallway" );
    _id_0737( "trigger_multiple_bcs_mp_lst_inpipe", "lst_inpipe" );
    _id_0737( "trigger_multiple_bcs_mp_lst_bypipe", "lst_bypipe" );
    _id_0737( "trigger_multiple_bcs_mp_lst_inchempool", "lst_inchempool" );
    _id_0737( "trigger_multiple_bcs_mp_lst_bychempool", "lst_bychempool" );
    _id_0737( "trigger_multiple_bcs_mp_lst_wastestorage", "lst_wastestorage" );
}

mp_urban()
{
    _id_0737( "trigger_multiple_bcs_mp_urb_int_tp", "urb_int_tp" );
    _id_0737( "trigger_multiple_bcs_mp_urb_lower_tp", "urb_lower_tp" );
    _id_0737( "trigger_multiple_bcs_mp_urb_back_tp", "urb_back_tp" );
    _id_0737( "trigger_multiple_bcs_mp_urb_int_construct", "urb_int_construct" );
    _id_0737( "trigger_multiple_bcs_mp_urb_lower_construct", "urb_lower_construct" );
    _id_0737( "trigger_multiple_bcs_mp_urb_complex", "urb_complex" );
    _id_0737( "trigger_multiple_bcs_mp_urb_west_complex", "urb_west_complex" );
    _id_0737( "trigger_multiple_bcs_mp_urb_west_complex_window", "urb_west_complex_window" );
    _id_0737( "trigger_multiple_bcs_mp_urb_east_complex", "urb_east_complex" );
    _id_0737( "trigger_multiple_bcs_mp_urb_east_complex_window", "urb_east_complex_window" );
    _id_0737( "trigger_multiple_bcs_mp_urb_plaza", "urb_plaza" );
    _id_0737( "trigger_multiple_bcs_mp_urb_plaza_stairs", "urb_plaza_stairs" );
    _id_0737( "trigger_multiple_bcs_mp_urb_crime_scene", "urb_crime_scene" );
    _id_0737( "trigger_multiple_bcs_mp_urb_back_construct", "urb_back_construct" );
}
