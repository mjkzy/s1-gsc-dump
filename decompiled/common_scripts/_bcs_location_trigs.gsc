// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

bcs_location_trigs_init()
{
    if ( isdefined( level._id_25F9 ) && isdefined( anim.bcs_locations ) )
        return;

    level._id_1347 = [];
    _id_1348();
    _id_1355();
    level._id_1347 = undefined;
    anim.locationlastcallouttimes = [];
}

_id_1355()
{
    anim.bcs_locations = [];
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

_id_1348()
{
    if ( common_scripts\utility::issp() )
    {
        _id_3C9D();
        _id_3B1C();
        _id_77F4();
        _id_77F2();
        _id_43D4();
        _id_7D8F();
        _id_29BC();
        _id_141A();
        _id_541F();
        _id_7291();
        _id_546E();
        _id_5BB4();
        _id_63A8();
    }
    else
    {
        _id_54E6();
        _id_5435();
        _id_5FC8();
        _id_5FC2();
        _id_5FAA();
        _id_5FAB();
        _id_5FBB();
        _id_5FBC();
        _id_5FC1();
        _id_5FC6();
        _id_5FCD();
        _id_5FCF();
        _id_5FD0();
        _id_5FD1();
        _id_5FA8();
        _id_63A9();
    }
}

_id_3C9D()
{
    _id_0737( "trigger_multiple_bcs_generic_doorway_generic", "doorway_generic" );
    _id_0737( "trigger_multiple_bcs_generic_window_generic", "window_generic" );
    _id_0737( "trigger_multiple_bcs_generic_1stfloor_generic", "1stfloor_generic" );
    _id_0737( "trigger_multiple_bcs_generic_1stfloor_doorway", "1stfloor_doorway" );
    _id_0737( "trigger_multiple_bcs_generic_1stfloor_window", "1stfloor_window" );
    _id_0737( "trigger_multiple_bcs_generic_2ndfloor_generic", "2ndfloor_generic" );
    _id_0737( "trigger_multiple_bcs_generic_2ndfloor_window", "2ndfloor_window" );
    _id_0737( "trigger_multiple_bcs_generic_rooftop", "rooftop" );
    _id_0737( "trigger_multiple_bcs_generic_2ndfloor_balcony", "2ndfloor_balcony" );
}

_id_3B1C()
{
    _id_0737( "trigger_multiple_bcs_fus_truck", "fus_truck" );
    _id_0737( "trigger_multiple_bcs_fus_tower", "fus_tower" );
    _id_0737( "trigger_multiple_bcs_fus_generator", "fus_generator" );
    _id_0737( "trigger_multiple_bcs_fus_mt", "fus_mt" );
    _id_0737( "trigger_multiple_bcs_fus_titan", "fus_titan" );
    _id_0737( "trigger_multiple_bcs_fus_hill", "fus_hill" );
    _id_0737( "trigger_multiple_bcs_fus_garage", "fus_garage" );
    _id_0737( "trigger_multiple_bcs_fus_crane", "fus_crane" );
    _id_0737( "trigger_multiple_bcs_fus_forklift", "fus_forklift" );
    _id_0737( "trigger_multiple_bcs_fus_pillar", "fus_pillar" );
    _id_0737( "trigger_multiple_bcs_fus_pipes", "fus_pipes" );
    _id_0737( "trigger_multiple_bcs_fus_balcony", "fus_balcony" );
    _id_0737( "trigger_multiple_bcs_fus_catwalk", "fus_catwalk" );
    _id_0737( "trigger_multiple_bcs_fus_fueltrucks", "fus_fueltrucks" );
    _id_0737( "trigger_multiple_bcs_fus_walkway", "fus_walkway" );
    _id_0737( "trigger_multiple_bcs_fus_stairs", "fus_stairs" );
}

_id_77F4()
{
    _id_0737( "trigger_multiple_bcs_sfa_bus", "sfa_bus" );
    _id_0737( "trigger_multiple_bcs_sfa_cardoor", "sfa_cardoor" );
    _id_0737( "trigger_multiple_bcs_sfa_cargovan", "sfa_cargovan" );
    _id_0737( "trigger_multiple_bcs_sfa_policecar", "sfa_policecar" );
    _id_0737( "trigger_multiple_bcs_sfa_roadsign", "sfa_roadsign" );
    _id_0737( "trigger_multiple_bcs_sfa_sidewalk", "sfa_sidewalk" );
    _id_0737( "trigger_multiple_bcs_sfa_sportscar", "sfa_sportscar" );
    _id_0737( "trigger_multiple_bcs_sfa_topbus", "sfa_topbus" );
    _id_0737( "trigger_multiple_bcs_sfa_tower", "sfa_tower" );
    _id_0737( "trigger_multiple_bcs_sfa_trailer", "sfa_trailer" );
    _id_0737( "trigger_multiple_bcs_sfa_truck", "sfa_truck" );
}

_id_77F2()
{
    _id_0737( "trigger_multiple_bcs_sfb_above", "above" );
    _id_0737( "trigger_multiple_bcs_sfb_containers", "sfb_containers" );
    _id_0737( "trigger_multiple_bcs_sfb_doors", "doors" );
    _id_0737( "trigger_multiple_bcs_sfb_helipad", "helipad" );
    _id_0737( "trigger_multiple_bcs_sfb_missileturret", "missileturret" );
    _id_0737( "trigger_multiple_bcs_sfb_table", "table" );
    _id_0737( "trigger_multiple_bcs_sfb_truck", "sfb_truck" );
    _id_0737( "trigger_multiple_bcs_sfb_vtol", "vtol" );
    _id_0737( "trigger_multiple_bcs_sfb_wreckage", "wreckage" );
    _id_0737( "trigger_multiple_bcs_sfb_cargocrane", "cargocrane" );
    _id_0737( "trigger_multiple_bcs_sfb_catwalk", "sfb_catwalk" );
    _id_0737( "trigger_multiple_bcs_sfb_console", "sfb_console" );
    _id_0737( "trigger_multiple_bcs_sfb_jammer", "sfb_jammer" );
    _id_0737( "trigger_multiple_bcs_sfb_launchpad", "sfb_launchpad" );
    _id_0737( "trigger_multiple_bcs_sfb_jet", "sfb_jet" );
}

_id_43D4()
{
    _id_0737( "trigger_multiple_bcs_grk_balcony", "grk_balcony" );
    _id_0737( "trigger_multiple_bcs_grk_1stfloor_window", "grk_1stfloor_window" );
    _id_0737( "trigger_multiple_bcs_grk_2ndfloor_window", "grk_2ndfloor_window" );
    _id_0737( "trigger_multiple_bcs_grk_3rdfloor_window", "grk_3rdfloor_window" );
    _id_0737( "trigger_multiple_bcs_grk_cafe", "grk_cafe" );
    _id_0737( "trigger_multiple_bcs_grk_rooftop", "grk_rooftop" );
    _id_0737( "trigger_multiple_bcs_grk_doorway", "grk_doorway" );
    _id_0737( "trigger_multiple_bcs_gre_vehic", "gre_vehic" );
    _id_0737( "trigger_multiple_bcs_gre_statue", "gre_statue" );
}

_id_7D8F()
{
    _id_0737( "trigger_multiple_bcs_seo_balcony", "seo_balcony" );
    _id_0737( "trigger_multiple_bcs_seo_bus", "seo_bus" );
    _id_0737( "trigger_multiple_bcs_seo_stairs", "seo_stairs" );
    _id_0737( "trigger_multiple_bcs_seo_2ndwindow", "seo_2ndwindow" );
    _id_0737( "trigger_multiple_bcs_seo_3rdbalcony", "seo_3rdbalcony" );
    _id_0737( "trigger_multiple_bcs_seo_sculpture", "seo_sculpture" );
    _id_0737( "trigger_multiple_bcs_seo_window", "seo_window" );
    _id_0737( "trigger_multiple_bcs_seo_window", "seo_window" );
    _id_0737( "trigger_multiple_bcs_seo_cafe", "seo_cafe" );
    _id_0737( "trigger_multiple_bcs_seo_counter", "seo_counter" );
}

_id_29BC()
{
    _id_0737( "trigger_multiple_bcs_det_bar", "det_bar" );
    _id_0737( "trigger_multiple_bcs_det_balcony", "det_balcony" );
    _id_0737( "trigger_multiple_bcs_det_walkway", "det_walkway" );
    _id_0737( "trigger_multiple_bcs_det_ambulance", "det_ambulance" );
}

_id_141A()
{
    _id_0737( "trigger_multiple_bcs_bet_plaza", "bet_plaza" );
    _id_0737( "trigger_multiple_bcs_bet_way", "bet_way" );
    _id_0737( "trigger_multiple_bcs_bet_1stfloor", "bet_1stfloor" );
    _id_0737( "trigger_multiple_bcs_bet_2ndfloor", "bet_2ndfloor" );
    _id_0737( "trigger_multiple_bcs_bet_3rdfloor", "bet_3rdfloor" );
    _id_0737( "trigger_multiple_bcs_bet_above", "bet_above" );
    _id_0737( "trigger_multiple_bcs_bet_balcony", "bet_balcony" );
    _id_0737( "trigger_multiple_bcs_bet_barge", "bet_barge" );
    _id_0737( "trigger_multiple_bcs_bet_checkpt", "bet_checkpt" );
    _id_0737( "trigger_multiple_bcs_bet_doorway", "bet_doorway" );
    _id_0737( "trigger_multiple_bcs_bet_open", "bet_open" );
    _id_0737( "trigger_multiple_bcs_bet_patio", "bet_patio" );
    _id_0737( "trigger_multiple_bcs_bet_rooftop", "bet_rooftop" );
    _id_0737( "trigger_multiple_bcs_bet_street", "bet_street" );
    _id_0737( "trigger_multiple_bcs_bet_drones", "bet_drones" );
    _id_0737( "trigger_multiple_bcs_bet_fountain", "bet_fountain" );
    _id_0737( "trigger_multiple_bcs_bet_skybridge", "bet_skybridge" );
    _id_0737( "trigger_multiple_bcs_bet_below", "bet_below" );
    _id_0737( "trigger_multiple_bcs_bet_bldng", "bet_bldng" );
    _id_0737( "trigger_multiple_bcs_bet_bridge", "bet_bridge" );
    _id_0737( "trigger_multiple_bcs_bet_deplycover", "bet_deplycover" );
    _id_0737( "trigger_multiple_bcs_bet_pallets", "bet_pallets" );
    _id_0737( "trigger_multiple_bcs_bet_catwalk", "bet_catwalk" );
    _id_0737( "trigger_multiple_bcs_bet_table", "bet_table" );
    _id_0737( "trigger_multiple_bcs_bet_crates", "bet_crates" );
    _id_0737( "trigger_multiple_bcs_bet_dock", "bet_dock" );
    _id_0737( "trigger_multiple_bcs_bet_leftshore", "bet_leftshore" );
    _id_0737( "trigger_multiple_bcs_bet_rightshore", "bet_rightshore" );
}

_id_541F()
{
    _id_0737( "trigger_multiple_bcs_lab_canisters", "lab_canisters" );
    _id_0737( "trigger_multiple_bcs_lab_camera", "lab_camera" );
    _id_0737( "trigger_multiple_bcs_lab_van", "lab_van" );
    _id_0737( "trigger_multiple_bcs_lab_lwrcatwalk", "lab_lwrcatwalk" );
    _id_0737( "trigger_multiple_bcs_lab_uprcatwalk", "lab_uprcatwalk" );
    _id_0737( "trigger_multiple_bcs_lab_forklift", "lab_forklift" );
    _id_0737( "trigger_multiple_bcs_lab_rooftop", "lab_rooftop" );
}

_id_7291()
{
    _id_0737( "trigger_multiple_bcs_rec_firepit", "rec_firepit" );
    _id_0737( "trigger_multiple_bcs_rec_hill", "rec_hill" );
    _id_0737( "trigger_multiple_bcs_rec_pool", "rec_pool" );
    _id_0737( "trigger_multiple_bcs_rec_road", "rec_road" );
    _id_0737( "trigger_multiple_bcs_rec_patio", "rec_patio" );
    _id_0737( "trigger_multiple_bcs_rec_table", "rec_table" );
    _id_0737( "trigger_multiple_bcs_rec_couch", "rec_couch" );
}

_id_546E()
{
    _id_0737( "trigger_multiple_bcs_lag_street", "lag_street" );
    _id_0737( "trigger_multiple_bcs_lag_dogs", "lag_dogs" );
    _id_0737( "trigger_multiple_bcs_lag_median", "lag_median" );
    _id_0737( "trigger_multiple_bcs_lag_rpgbus", "lag_rpgbus" );
    _id_0737( "trigger_multiple_bcs_lag_overpass", "lag_overpass" );
    _id_0737( "trigger_multiple_bcs_lag_suv", "lag_suv" );
    _id_0737( "trigger_multiple_bcs_lag_suvapproach", "lag_suvapproach" );
    _id_0737( "trigger_multiple_bcs_lag_topvan", "lag_topvan" );
}

_id_5BB4()
{
    _id_0737( "trigger_multiple_bcs_mp_merida_radiotower", "radiotower" );
    _id_0737( "trigger_multiple_bcs_mp_merida_embassy_generic", "embassy_generic" );
    _id_0737( "trigger_multiple_bcs_mp_merida_aaguns", "aaguns" );
    _id_0737( "trigger_multiple_bcs_mp_merida_tunnel", "tunnel" );
    _id_0737( "trigger_multiple_bcs_mp_merida_cannons_generic", "cannons_generic" );
    _id_0737( "trigger_multiple_bcs_mp_merida_pool", "pool" );
    _id_0737( "trigger_multiple_bcs_mp_merida_embassy_north", "embassy_north" );
    _id_0737( "trigger_multiple_bcs_mp_merida_embassy_south", "embassy_south" );
    _id_0737( "trigger_multiple_bcs_mp_merida_embassy_east", "embassy_east" );
    _id_0737( "trigger_multiple_bcs_mp_merida_embassy_west", "embassy_west" );
    _id_0737( "trigger_multiple_bcs_mp_merida_cannons_embassy", "cannons_embassy" );
    _id_0737( "trigger_multiple_bcs_mp_merida_cannons_radiotower", "cannons_radiotower" );
}

_id_54E6()
{
    _id_0737( "trigger_multiple_bcs_mp_lsr_radardish", "lsr_radardish" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_laserairdefensegun", "lsr_laserairdefensegun" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_razorback", "lsr_razorback" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_underhelipad", "lsr_underhelipad" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_bunkerlookout", "lsr_bunkerlookout" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_inradartower", "lsr_inradartower" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_byradartower", "lsr_byradartower" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_shippingcontainer", "lsr_shippingcontainer" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_onhelipad", "lsr_onhelipad" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_onbeach", "lsr_onbeach" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_onbeach", "lsr_bybridge" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_bylasergenerator", "lsr_bylasergenerator" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_underlaser", "lsr_underlaser" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_byhelipad", "lsr_byhelipad" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_electricalroom", "lsr_electricalroom" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_piperoom", "lsr_piperoom" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_bybuoy", "lsr_bybuoy" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_bygenerator", "lsr_bygenerator" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_offswitch", "lsr_offswitch" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_missilerack", "lsr_missilerack" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_underchains", "lsr_underchains" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_beachbunkerrooftop", "lsr_beachbunkerrooftop" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_bunkerrooftop", "lsr_bunkerrooftop" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_nettedcargo", "lsr_nettedcargo" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_cagedcargo", "lsr_cagedcargo" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_overturnedcar", "lsr_overturnedcar" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_bridgebase", "lsr_bridgebase" );
    _id_0737( "trigger_multiple_bcs_mp_lsr_cornerbunker", "lsr_cornerbunker" );
}

_id_5435()
{
    _id_0737( "trigger_multiple_bcs_mp_lab_parkinglot", "lab_parkinglot" );
    _id_0737( "trigger_multiple_bcs_mp_lab_serverroom", "lab_serverroom" );
    _id_0737( "trigger_multiple_bcs_mp_lab_holoroom", "lab_holoroom" );
    _id_0737( "trigger_multiple_bcs_mp_lab_dryingroom", "lab_dryingroom" );
    _id_0737( "trigger_multiple_bcs_mp_lab_chemvats", "lab_chemvats" );
    _id_0737( "trigger_multiple_bcs_mp_lab_generator", "lab_generator" );
    _id_0737( "trigger_multiple_bcs_mp_lab_lobby", "lab_lobby" );
    _id_0737( "trigger_multiple_bcs_mp_lab_behindcrates", "lab_behindcrates" );
    _id_0737( "trigger_multiple_bcs_mp_lab_scienceroom", "lab_scienceroom" );
    _id_0737( "trigger_multiple_bcs_mp_lab_storageroom", "lab_storageroom" );
    _id_0737( "trigger_multiple_bcs_mp_lab_trench", "lab_trench" );
    _id_0737( "trigger_multiple_bcs_mp_lab_behindvehicle", "lab_behindvehicle" );
}

_id_5FC8()
{
    _id_0737( "trigger_multiple_bcs_mp_ref_oncrane", "ref_oncrane" );
    _id_0737( "trigger_multiple_bcs_mp_ref_byloadingdocks", "ref_byloadingdocks" );
    _id_0737( "trigger_multiple_bcs_mp_ref_nearelevatorentrance", "ref_nearelevatorentrance" );
    _id_0737( "trigger_multiple_bcs_mp_ref_inelevator", "ref_inelevator" );
    _id_0737( "trigger_multiple_bcs_mp_ref_oncatwalks", "ref_oncatwalks" );
    _id_0737( "trigger_multiple_bcs_mp_ref_seccheckpoint", "ref_seccheckpoint" );
    _id_0737( "trigger_multiple_bcs_mp_ref_helopadentrance", "ref_helopadentracne" );
    _id_0737( "trigger_multiple_bcs_mp_ref_checkinstation", "ref_checkinstation" );
    _id_0737( "trigger_multiple_bcs_mp_ref_maintenceentrance", "ref_maintenceentrance" );
    _id_0737( "trigger_multiple_bcs_mp_ref_insidelounge", "ref_insidelounge" );
    _id_0737( "trigger_multiple_bcs_mp_ref_bylockmechanism", "ref_bylockmechanism" );
    _id_0737( "trigger_multiple_bcs_mp_ref_inelevatorshaft", "ref_inelevatorshaft" );
    _id_0737( "trigger_multiple_bcs_mp_ref_underhelipad", "ref_underhelipad" );
    _id_0737( "trigger_multiple_bcs_mp_ref_bylgcontainers", "ref_bylgcontainers" );
    _id_0737( "trigger_multiple_bcs_mp_ref_bylockers", "ref_bylockers" );
    _id_0737( "trigger_multiple_bcs_mp_ref_abovelockers", "ref_abovelockers" );
    _id_0737( "trigger_multiple_bcs_mp_ref_byadtowers", "ref_byadtowers" );
}

_id_5FC2()
{
    _id_0737( " trigger_multiple_bcs_mp_psn_insidecellblock", "psn_insidecellblock" );
    _id_0737( "trigger_multiple_bcs_mp_psn_psnfrontentrance", "psn_psnfrontentrance" );
    _id_0737( "trigger_multiple_bcs_mp_psn_insidemaintenancebldg", "psn_insidemaintenancebldg" );
    _id_0737( "trigger_multiple_bcs_mp_psn_onmaintenancebldgroof", "psn_onmaintenancebldgroof" );
    _id_0737( "trigger_multiple_bcs_mp_psn_prisonyard", "psn_prisonyard" );
    _id_0737( "trigger_multiple_bcs_mp_psn_bballcourt", "psn_bballcourt" );
    _id_0737( "trigger_multiple_bcs_mp_psn_psnbus", "psn_psnbus" );
    _id_0737( "trigger_multiple_bcs_mp_psn_sectower", "psn_sectower" );
    _id_0737( "trigger_multiple_bcs_mp_psn_insidegarage", "psn_insidegarage" );
    _id_0737( "trigger_multiple_bcs_mp_psn_topofgarage", "psn_topofgarage" );
    _id_0737( "trigger_multiple_bcs_mp_psn_destroyedwall", "psn_destroyedwall" );
    _id_0737( "trigger_multiple_bcs_mp_psn_cellblockcatwalk", "psn_cellblockcatwalk" );
    _id_0737( "trigger_multiple_bcs_mp_psn_lobbyentrance", "psn_lobbyentrance" );
    _id_0737( "trigger_multiple_bcs_mp_psn_electricalbox", "psn_electricalbox" );
    _id_0737( "trigger_multiple_bcs_mp_psn_policecar", "psn_policecar" );
    _id_0737( "trigger_multiple_bcs_mp_psn_behinddumpster", "psn_behinddumpster" );
    _id_0737( "trigger_multiple_bcs_mp_psn_catwalk", "psn_catwalk" );
    _id_0737( "trigger_multiple_bcs_mp_psn_laundrybin", "psn_laundrybin" );
    _id_0737( "trigger_multiple_bcs_mp_psn_psnrooftop", "psn_psnrooftop" );
    _id_0737( "trigger_multiple_bcs_mp_psn_behindac", "psn_behindac" );
    _id_0737( "trigger_multiple_bcs_mp_psn_insidelockerbldg", "psn_insidelockerbldg" );
}

_id_5FAA()
{
    _id_0737( "trigger_multiple_bcs_mp_dam_frontgate", "dam_frontgate" );
    _id_0737( "trigger_multiple_bcs_mp_dam_semitruck", "dam_semitruck" );
    _id_0737( "trigger_multiple_bcs_mp_dam_contructionsite", "dam_contructionsite" );
    _id_0737( "trigger_multiple_bcs_mp_dam_insideoffice", "dam_insideoffice" );
    _id_0737( "trigger_multiple_bcs_mp_dam_oncatwalks", "dam_oncatwalks" );
    _id_0737( "trigger_multiple_bcs_mp_dam_centerstreet", "dam_centerstreet" );
    _id_0737( "trigger_multiple_bcs_mp_dam_onminigun", "dam_onminigun" );
    _id_0737( "trigger_multiple_bcs_mp_dam_cranebase", "dam_cranebase" );
    _id_0737( "trigger_multiple_bcs_mp_dam_infactory", "dam_infactory" );
    _id_0737( "trigger_multiple_bcs_mp_dam_inturbinebldg", "dam_inturbinebldg" );
    _id_0737( "trigger_multiple_bcs_mp_dam_movingpipe", "dam_movingpipe" );
    _id_0737( "trigger_multiple_bcs_mp_dam_electricalgrid", "dam_electricalgrid" );
    _id_0737( "trigger_multiple_bcs_dam_insidelounge", "dam_insidelounge" );
    _id_0737( "trigger_multiple_bcs_mp_dam_inpipes", "dam_inpipes" );
    _id_0737( "trigger_multiple_bcs_mp_dam_underground", "dam_underground" );
    _id_0737( "trigger_multiple_bcs_mp_dam_factoryrooftop", "dam_factoryrooftop" );
}

_id_5FAB()
{
    _id_0737( "trigger_multiple_bcs_mp_det_inschool", "det_inschool" );
    _id_0737( "trigger_multiple_bcs_mp_det_bylockers", "det_bylockers" );
    _id_0737( "trigger_multiple_bcs_mp_det_hospitalentrance", "det_hospitalentrance" );
    _id_0737( "trigger_multiple_bcs_mp_det_hospitallobby", "det_hospitallobby" );
    _id_0737( "trigger_multiple_bcs_mp_det_inparkinggarage", "det_inparkinggarage" );
    _id_0737( "trigger_multiple_bcs_mp_det_garageentrance", "det_garageentrance" );
    _id_0737( "trigger_multiple_bcs_mp_det_piperoom", "det_piperoom" );
    _id_0737( "trigger_multiple_bcs_mp_det_onramp", "det_onramp" );
    _id_0737( "trigger_multiple_bcs_mp_det_inalley", "det_inalley" );
    _id_0737( "trigger_multiple_bcs_mp_det_bytrailers", "det_bytrailers" );
    _id_0737( "trigger_multiple_bcs_mp_det_ontrailers", "det_ontrailers" );
    _id_0737( "trigger_multiple_bcs_mp_det_inthepod", "det_inthepod" );
    _id_0737( "trigger_multiple_bcs_mp_det_throughpark", "det_throughpark" );
    _id_0737( "trigger_multiple_bcs_mp_det_byplayground", "det_byplayground" );
    _id_0737( "triger_multiple_bcs_mp_det_garageoverlook", "det_garageoverlook" );
    _id_0737( "trigger_multiple_bcs_mp_det_backalley", "det_backalley" );
    _id_0737( "trigger_multiple_bcs_mp_det_parkoffice", "det_parkoffice" );
    _id_0737( "trigger_multiple_bcs_mp_hospitaloffice", "det_hospitaloffice" );
    _id_0737( "trigger_multiple_bcs_mp_det_throughstreet", "det_throughstreet" );
    _id_0737( "trigger_multiple_bcs_mp_det_upperstreet", "det_upperstreet" );
    _id_0737( "trigger_multiple_bcs_mp_det_lowerstreet", "det_lowerstreet" );
    _id_0737( "trigger_multiple_bcs_mp_det_bycontainers", "det_bycontainers" );
    _id_0737( "trigger_multiple_bcs_mp_det_bydiner", "det_bydiner" );
}

_id_5FBB()
{
    _id_0737( "trigger_multiple_bcs_mp_grn_2ndflooraquarium", "grn_2ndflooraquarium" );
    _id_0737( "trigger_multiple_bcs_mp_grn_hotelbar", "grn_hotelbar" );
    _id_0737( "trigger_multiple_bcs_mp_grn_incafe", "grn_incafe" );
    _id_0737( "trigger_multiple_bcs_mp_grn_behindcherrytree", "grn_behindcherrytree" );
    _id_0737( "trigger_multiple_bcs_mp_grn_aquariumhallway", "grn_aquariumhallway" );
    _id_0737( "trigger_multiple_bcs_mp_grn_aquariumpatio", "grn_aquariumpatio" );
    _id_0737( "trigger_multiple_bcs_mp_grn_inelevator", "grn_inelevator" );
    _id_0737( "trigger_multiple_bcs_mp_grn_behindaquariumdesk", "grn_behindaquariumdesk" );
    _id_0737( "trigger_multiple_bcs_mp_grn_inzengarden", "grn_inzengarden" );
    _id_0737( "trigger_multiple_bcs_mp_grn_topofzengarden", "grn_topofzengarden" );
    _id_0737( "trigger_multiple_bcs_mp_grn_hotelentrance", "grn_hotelentrance" );
    _id_0737( "trigger_multiple_bcs_mp_grn_hotellobby", "grn_hotellobby" );
    _id_0737( "trigger_multiple_bcs_mp_grn_inaquarium", "grn_aquarium" );
    _id_0737( "trigger_multiple_bcs_mp_grn_inlounge", "grn_inlounge" );
    _id_0737( "trigger_multiple_bcs_mp_grn_behindstatue", "grn_behindstatue" );
    _id_0737( "trigger_multiple_bcs_mp_grn_insidewalkway", "grn_insidewalkway" );
    _id_0737( "trigger_multiple_bcs_mp_grn_underawning", "grn_underawning" );
    _id_0737( "trigger_multiple_bcs_mp_grn_topofawning", "grn_topofawning" );
    _id_0737( "trigger_multiple_bcs_mp_grn_behindlargerock", "grn_behindlargerock" );
    _id_0737( "trigger_multiple_bcs_mp_grn_nearsculpture", "grn_nearsculpture" );
    _id_0737( "trigger_multiple_bcs_mp_grn_behindsmallplanter", "grn_behindsmallplanter" );
}

_id_5FBC()
{
    _id_0737( "trigger_multiple_bcs_mp_ins_byriverbed", "ins_byriverbed" );
    _id_0737( "trigger_multiple_bcs_mp_ins_underexcavator", "ins_underexcavator" );
    _id_0737( "trigger_multiple_bcs_mp_ins_oncliffs", "ins_oncliffs" );
    _id_0737( "trigger_multiple_bcs_mp_ins_centertemple", "ins_centertemple" );
    _id_0737( "trigger_multiple_bcs_mp_ins_towerofruins", "ins_towerofruins" );
    _id_0737( "triger_multiple_bcs_mp_ins_nearpryramidhall", "ins_nearpryramidhall" );
    _id_0737( "trigger_multiple_bcs_mp_ins_insidepryramid", "ins_insidepryramid" );
    _id_0737( "trigger_multiple_bcs_mp_ins_behindtrailers", "ins_behindtrailers" );
    _id_0737( "trigger_multiple_bcs_mp_ins_powergenerators", "ins_powergenerators" );
    _id_0737( "trigger_multiple_bcs_mp_ins_onrubble", "ins_onrubble" );
}

_id_5FC1()
{
    _id_0737( "trigger_multiple_bcs_mp_lev_secgates", "lev_secgates" );
    _id_0737( "trigger_multiple_bcs_mp_lev_controlroom", "lev_controlroom" );
    _id_0737( "trigger_multiple_bcs_mp_lev_accessroofs", "lev_accessroofs" );
    _id_0737( "trigger_multiple_bcs_mp_lev_mainhangar", "lev_mainhangar" );
    _id_0737( "trigger_multiple_bcs_mp_lev_dronestorage", "lev_dronestorage" );
    _id_0737( "trigger_multiple_bcs_mp_lev_inflightcontrol", "lev_flightcontrol" );
    _id_0737( "trigger_multiple_bcs_mp_lev_flightcontrolroof", "lev_flightcontrolroof" );
    _id_0737( "trigger_multiple_bcs_mp_lev_flightcontrolalley", "lev_flightcontrolalley" );
    _id_0737( "trigger_multiple_bcs_mp_lev_observationdeck", "lev_observationdeck" );
    _id_0737( "trigger_multiple_bcs_mp_lev_serveraccessroof", "lev_serveraccessroof" );
    _id_0737( "trigger_multiple_bcs_mp_lev_hangarlounge", "lev_hangarlounge" );
    _id_0737( "trigger_multiple_bcs_mp_lev_powercontrol", "lev_powercontrol" );
    _id_0737( "trigger_multiple_bcs_mp_lev_readyrooms", "lev_readyrooms" );
    _id_0737( "trigger_multiple_bcs_mp_lev_rearhangar", "lev_rearhangar" );
    _id_0737( "trigger_multiple_bcs_mp_lev_serveraccess", "lev_serveraccess" );
    _id_0737( "trigger_multiple_bcs_mp_lev_nearwaterfall", "lev_nearwaterfall" );
    _id_0737( "trigger_multiple_bcs_mp_lev_nearrockslide", "lev_nearrockslide" );
}

_id_5FC6()
{
    _id_0737( "trigger_multiple_bcs_mp_rec_inobservatory", "rec_inobservatory" );
    _id_0737( "trigger_multiple_bcs_mp_rec_bytram", "rec_bytram" );
    _id_0737( "trigger_multiple_bcs_mp_rec_byskywalk", "rec_byskywalk" );
    _id_0737( "trigger_multiple_bcs_mp_rec_inravine", "rec_inravine" );
    _id_0737( "trigger_multiple_bcs_mp_rec_insiderockhall", "rec_insiderockhall" );
    _id_0737( "trigger_multiple_bcs_mp_rec_byhangardoor", "rec_byhangardoor" );
    _id_0737( "trigger_multiple_bcs_mp_rec_inplaza", "rec_inplaza" );
    _id_0737( "trigger_multiple_bcs_mp_rec_bychopper", "rec_bychopper" );
    _id_0737( "trigger_multiple_bcs_mp_rec_onlaunchdeck", "rec_onlaunchdeck" );
    _id_0737( "trigger_multiple_bcs_mp_rec_nearridge", "rec_nearridge" );
    _id_0737( "trigger_multiple_bcs_mp_rec_undercontroltower", "rec_undercontroltower" );
    _id_0737( "trigger_multiple_bcs_mp_rec_gatecontrolroom", "rec_gatecontrolroom" );
    _id_0737( "trigger_multiple_bcs_mp_rec_underdeck", "rec_underdeck" );
    _id_0737( "trigger_multiple_bcs_mp_rec_observationdeck", "rec_observationdeck" );
    _id_0737( "trigger_multiple_bcs_mp_rec_byrustedvan", "rec_byrustedvan" );
}

_id_5FCD()
{
    _id_0737( "trigger_multiple_bcs_mp_slr_inparkinglot", "slr_inparkinglot" );
    _id_0737( "trigger_multiple_bcs_mp_slr_bymainentry", "slr_bymainentry" );
    _id_0737( "trigger_multiple_bcs_mp_slr_atpool", "slr_atpool" );
    _id_0737( "trigger_multiple_bcs_mp_slr_indraintunnel", "slr_indraintunnel" );
    _id_0737( "trigger_multiple_bcs_mp_slr_inoffice", "slr_inoffice" );
    _id_0737( "trigger_multiple_bcs_mp_slr_bysmalltanks", "slr_bysmalltanks" );
    _id_0737( "trigger_multiple_bcs_mp_slr_intowercontrolroom", "slr_intowercontrolroom" );
    _id_0737( "trigger_multiple_bcs_mp_slr_bytransformers", "slr_bytransformers" );
    _id_0737( "trigger_multiple_bcs_mp_slr_condensercontrolroom", "slr_condensercontrolroom" );
    _id_0737( "trigger_multiple_bcs_mp_slr_inbacklot", "slr_inbacklot" );
    _id_0737( "trigger_multiple_bcs_mp_slr_bycyclonetank", "slr_bycyclonetank" );
    _id_0737( "trigger_multiple_bcs_mp_slr_indrainarea", "slr_indrainarea" );
    _id_0737( "trigger_multiple_bcs_mp_slr_indriveway", "slr_indriveway" );
    _id_0737( "trigger_multiple_bcs_mp_slr_visitorcenter", "slr_visitorcenter" );
    _id_0737( "trigger_multiple_bcs_mp_slr_inpumproom", "slr_inpumproom" );
    _id_0737( "trigger_multiple_bcs_mp_slr_sciencearea", "slr_sciencearea" );
    _id_0737( "trigger_multiple_bcs_mp_slr_ingarage", "slr_ingarage" );
    _id_0737( "trigger_multiple_bcs_mp_slr_oncatwalks", "slr_oncatwalks" );
    _id_0737( "trigger_multiple_bcs_mp_slr_bycondensers", "slr_bycondensers" );
    _id_0737( "trigger_multiple_bcs_mp_slr_inutilityroom", "slr_inutilityroom" );
    _id_0737( "trigger_multiple_bcs_mp_slr_onutilityroof", "slr_onutilityroof" );
}

_id_5FCF()
{
    _id_0737( "trigger_multiple_bcs_mp_trc_hotellobby", "trc_hotellobby" );
    _id_0737( "trigger_multiple_bcs_mp_trc_atgrotto", "trc_atgrotto" );
    _id_0737( "trigger_multiple_bcs_mp_trc_insaunatunnel", "trc_insaunatunnel" );
    _id_0737( "trigger_multiple_bcs_mp_trc_saunaentrance", "trc_saunaentrance" );
    _id_0737( "trigger_multiple_bcs_mp_trc_inlowerruins", "trc_inlowerruins" );
    _id_0737( "trigger_multiple_bcs_mp_trc_inupperruins", "trc_inupperruins" );
    _id_0737( "trigger_multiple_bcs_mp_trc_onupperterrace", "trc_onupperterrace" );
    _id_0737( "trigger_multiple_bcs_mp_trc_incafe", "trc_incafe" );
    _id_0737( "trigger_multiple_bcs_mp_trc_undertower", "trc_undertower" );
    _id_0737( "trigger_multiple_bcs_mp_trc_nightclubentrance", "trc_nightclubentrance" );
    _id_0737( "trigger_multiple_bcs_mp_trc_yellowroom", "trc_yellowroom" );
    _id_0737( "trigger_multiple_bcs_mp_trc_redroom", "trc_redroom" );
    _id_0737( "trigger_multiple_bcs_mp_trc_lowerterrace", "trc_lowerterrace" );
    _id_0737( "trigger_multiple_bcs_mp_trc_atbonfire", "trc_atbonfire" );
    _id_0737( "trigger_multiple_bcs_mp_trc_poseidonspool", "trc_poseidonspool" );
    _id_0737( "trigger_multiple_bcs_mp_trc_saunaroof", "trc_saunaroof" );
    _id_0737( "trigger_multiple_bcs_mp_trc_inshowers", "trc_inshowers" );
    _id_0737( "trigger_multiple_bcs_mp_trc_topofminervamall", "trc_topofminervamall" );
    _id_0737( "trigger_multiple_bcs_mp_trc_sixbellspatio", "trc_sixbellspatio" );
}

_id_5FD0()
{
    _id_0737( "trigger_multiple_bcs_mp_trq_nearbusstop", "trq_nearbusstop" );
    _id_0737( "trigger_multiple_bcs_mp_trq_incafe", "trq_incafe" );
    _id_0737( "trigger_multiple_bcs_mp_trq_chocolateshop", "trq_chocolateshop" );
    _id_0737( "trigger_multiple_bcs_mp_trq_baseofclocktower", "trq_baseofclocktower" );
    _id_0737( "trigger_multiple_bcs_mp_trq_inclocktower", "trq_inclocktower" );
    _id_0737( "trigger_multiple_bcs_mp_trq_nearfountain", "trq_nearfountain" );
    _id_0737( "trigger_multiple_bcs_mp_trq_outdoorcafe", "trq_outdoorcafe" );
    _id_0737( "trigger_multiple_bcs_mp_trq_parkinglot", "trq_parkinglot" );
    _id_0737( "trigger_multiple_bcs_mp_trq_gatedpatio", "trq_gatedpatio" );
    _id_0737( "trigger_multiple_bcs_mp_trq_nearrestaurant", "trq_nearrestaurant" );
    _id_0737( "trigger_multiple_bcs_mp_trq_insemi", "trq_insemi" );
    _id_0737( "trigger_multiple_bcs_mp_trq_nearsnackbar", "trq_nearsnackbar" );
    _id_0737( "trigger_multiple_bcs_mp_trq_insideticketcounter", "trq_insideticketcounter" );
    _id_0737( "trigger_multiple_bcs_mp_trq_frontoftrain", "trq_frontoftrain" );
    _id_0737( "trigger_multiple_bcs_mp_trq_backoftrain", "trq_backoftrain" );
    _id_0737( "trigger_multiple_bcs_mp_trq_utilitywalkway", "trq_utilitywalkway" );
    _id_0737( "trigger_multiple_bcs_mp_trq_onskywalk", "trq_onskywalk" );
    _id_0737( "trigger_multiple_bcs_mp_trq_topofawning", "trq_topofawning" );
    _id_0737( "trigger_multiple_bcs_mp_trq_behindbearstatue", "trq_behindbearstatue" );
    _id_0737( "trigger_multiple_bcs_mp_trq_behindcar", "trq_behindcar" );
    _id_0737( "trigger_multiple_bcs_mp_trq_incoffeeshop", "trq_incoffeeshop" );
    _id_0737( "trigger_multiple_bcs_mp_trq_inconstructionblgd", "trq_inconstructionblgd" );
    _id_0737( "trigger_multiple_bcs_mp_trq_inelevator", "trq_inelevator" );
    _id_0737( "trigger_multiple_bcs_mp_trq_onroof", "trq_onroof" );
    _id_0737( "trigger_multiple_bcs_mp_trq_behindsecuritytruck", "trq_behindsecuritytruck" );
    _id_0737( "trigger_multiple_bcs_mp_trq_aboveticketcounter", "trq_aboveticketcounter" );
}

_id_5FD1()
{
    _id_0737( "trigger_multiple_bcs_mp_vns_inpool", "vns_inpool" );
    _id_0737( "trigger_multiple_bcs_mp_vns_bypool", "vns_bypool" );
    _id_0737( "trigger_multiple_bcs_mp_vns_inlounge", "vns_inlounge" );
    _id_0737( "trigger_multiple_bcs_mp_vns_inlobby", "vns_inlobby" );
    _id_0737( "trigger_multiple_bcs_mp_vns_onbalcony", "vns_onbalcony" );
    _id_0737( "trigger_multiple_bcs_mp_vns_byhelipad", "vns_byhelipad" );
    _id_0737( "trigger_multiple_bcs_mp_vns_onfountain", "vns_onfountain" );
    _id_0737( "trigger_multiple_bcs_mp_vns_byfountain", "vns_byfountain" );
    _id_0737( "trigger_multiple_bcs_mp_vns_onpoolshade", "vns_onpoolshade" );
    _id_0737( "trigger_multiple_bcs_mp_vns_inzengarden", "vns_inzengarden" );
    _id_0737( "trigger_multiple_bcs_mp_vns_inbar", "vns_inbar" );
    _id_0737( "trigger_multiple_bcs_mp_vns_bybar", "vns_bybar" );
    _id_0737( "trigger_multiple_bcs_mp_vns_onwoodendeck", "vns_onwoodendeck" );
    _id_0737( "trigger_multiple_bcs_mp_vns_inobservationlounge", "vns_inobservationlounge" );
    _id_0737( "trigger_multiple_bcs_mp_vns_bywaterfall", "vns_bywaterfall" );
    _id_0737( "trigger_multiple_bcs_mp_vns_incentercourtyard", "vns_incentercourtyard" );
    _id_0737( "trigger_multiple_bcs_mp_vns_onpatio", "vns_onpatio" );
    _id_0737( "trigger_multiple_bcs_mp_vns_byfallentree", "vns_byfallentree" );
    _id_0737( "trigger_multiple_bcs_mp_vns_inbansaigarden", "vns_inbansaigarden" );
    _id_0737( "trigger_multiple_bcs_mp_vns_bypenthouse", "vns_bypenthouse" );
    _id_0737( "trigger_multiple_bcs_mp_vns_byhorsestatue", "vns_byhorsestatue" );
    _id_0737( "trigger_multiple_bcs_mp_vns_bysoliderstatue", "vns_bysoliderstatue" );
    _id_0737( "trigger_multiple_bcs_mp_vns_onhallwayrooftop", "vns_onhallwayrooftop" );
    _id_0737( "trigger_multiple_bcs_mp_vns_onbalconystaircase", "vns_onbalconystaircase" );
    _id_0737( "trigger_multiple_bcs_mp_vns_onoutsidebalconystaircase", "vns_onoutsidebalconystaircase" );
    _id_0737( "trigger_multiple_bcs_mp_vns_onobservationdeck", "vns_onobservationdeck" );
    _id_0737( "trigger_multiple_bcs_mp_vns_onobservationrooftop", "vns_onobservationrooftop" );
    _id_0737( "trigger_multiple_bcs_mp_vns_underwaterfall", "vns_underwaterfall" );
    _id_0737( "trigger_multiple_bcs_mp_vns_insaunalobby", "vns_insaunalobby" );
    _id_0737( "trigger_multiple_bcs_mp_vns_underkeyholearchway", "vns_underkeyholearchway" );
    _id_0737( "trigger_multiple_bcs_mp_vns_onoverhang", "vns_onoverhang" );
    _id_0737( "trigger_multiple_bcs_mp_vns_bylanterns", "vns_bylanterns" );
    _id_0737( "trigger_multiple_bcs_mp_vns_onpenthouseroof", "vns_onpenthouseroof" );
}

_id_5FA8()
{
    _id_0737( "trigger_multiple_bcs_mp_cbk_rearentrancenetcafe", "cbk_rearentrancenetcafe" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_netcafe", "cbk_netcafe" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_videostore", "cbk_videostore" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_videostoreroof", "cbk_videostoreroof" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_byshanty", "cbk_byshanty" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_powerstationroof", "cbk_powerstationroof" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_centercoil", "cbk_centercoil" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_glassoffices", "cbk_glassoffices" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_grassybalcony", "cbk_grassybalcony" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_fabricsshop", "cbk_fabricsshop" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_fabricsshoproof", "cbk_fabricsshoproof" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_westcourtyard", "cbk_westcourtyard" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_nearskywalk", "cbk_nearskywalk" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_baseofapttower", "cbk_baseofapttower" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_northcourtyard", "cbk_northcourtyard" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_atopensewer", "cbk_atopensewer" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_eastcourtyard", "cbk_eastcourtyard" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_nearmarket", "cbk_nearmarket" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_oneonezero", "cbk_oneonezero" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_southcourtyard", "cbk_southcourtyard" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_southerncourtyard", "cbk_southerncourtyard" );
    _id_0737( "trigger_multiple_bcs_mp_cbk_outsideofficebldg", "cbk_outsideofficebldg" );
}

_id_63A8()
{
    _id_0737( "trigger_multiple_bcs_ns_acrosschasm", "acrosschasm" );
    _id_0737( "trigger_multiple_bcs_ns_amcrt_stck", "amcrt_stck" );
    _id_0737( "trigger_multiple_bcs_ns_barr_conc", "barr_conc" );
    _id_0737( "trigger_multiple_bcs_ns_brls", "brls" );
    _id_0737( "trigger_multiple_bcs_ns_catwlk", "catwlk" );
    _id_0737( "trigger_multiple_bcs_ns_cell_l", "cell_l" );
    _id_0737( "trigger_multiple_bcs_ns_cell_r", "cell_r" );
    _id_0737( "trigger_multiple_bcs_ns_celldr_endhl", "celldr_endhl" );
    _id_0737( "trigger_multiple_bcs_ns_corrgatedmtl", "corrgatedmtl" );
    _id_0737( "trigger_multiple_bcs_ns_cot", "cot" );
    _id_0737( "trigger_multiple_bcs_ns_crt_stck", "crt_stck" );
    _id_0737( "trigger_multiple_bcs_ns_crtstk_nrldge", "crtstk_nrldge" );
    _id_0737( "trigger_multiple_bcs_ns_cv_cent", "cv_cent" );
    _id_0737( "trigger_multiple_bcs_ns_cv_cent_concsup", "cv_cent_concsup" );
    _id_0737( "trigger_multiple_bcs_ns_cv_cent_tv", "cv_cent_tv" );
    _id_0737( "trigger_multiple_bcs_ns_cv_small_l", "cv_small_l" );
    _id_0737( "trigger_multiple_bcs_ns_cv_wall_inside", "cv_wall_inside" );
    _id_0737( "trigger_multiple_bcs_ns_cv_wall_outside", "cv_wall_outside" );
    _id_0737( "trigger_multiple_bcs_ns_dpstr", "dpstr" );
    _id_0737( "trigger_multiple_bcs_ns_drvwy", "drvwy" );
    _id_0737( "trigger_multiple_bcs_ns_dsk_lg", "dsk_lg" );
    _id_0737( "trigger_multiple_bcs_ns_dsk_stck", "dsk_stck" );
    _id_0737( "trigger_multiple_bcs_ns_fuelcont", "fuelcont" );
    _id_0737( "trigger_multiple_bcs_ns_fuelconts", "fuelconts" );
    _id_0737( "trigger_multiple_bcs_ns_gbgcns", "gbgcns" );
    _id_0737( "trigger_multiple_bcs_ns_hdghog", "hdghog" );
    _id_0737( "trigger_multiple_bcs_ns_hesco_nrledge", "hesco_nrledge" );
    _id_0737( "trigger_multiple_bcs_ns_hescobarr", "hescobarr" );
    _id_0737( "trigger_multiple_bcs_ns_icemach", "icemach" );
    _id_0737( "trigger_multiple_bcs_ns_intsec_3w", "intsec_3w" );
    _id_0737( "trigger_multiple_bcs_ns_lckr_cntr", "lckr_cntr" );
    _id_0737( "trigger_multiple_bcs_ns_lckr_l", "lckr_l" );
    _id_0737( "trigger_multiple_bcs_ns_lckr_ne", "lckr_ne" );
    _id_0737( "trigger_multiple_bcs_ns_lckr_r", "lckr_r" );
    _id_0737( "trigger_multiple_bcs_ns_lckr_sw", "lckr_sw" );
    _id_0737( "trigger_multiple_bcs_ns_lowwall_bwire", "lowwall_bwire" );
    _id_0737( "trigger_multiple_bcs_ns_newsbox", "newsbox" );
    _id_0737( "trigger_multiple_bcs_ns_phnbth", "phnbth" );
    _id_0737( "trigger_multiple_bcs_ns_pipes_behind", "pipes_behind" );
    _id_0737( "trigger_multiple_bcs_ns_pipes_nside", "pipes_nside" );
    _id_0737( "trigger_multiple_bcs_ns_rappel_left", "rappel_left" );
    _id_0737( "trigger_multiple_bcs_ns_samlnchr", "samlnchr" );
    _id_0737( "trigger_multiple_bcs_ns_sentrygun", "sentrygun" );
    _id_0737( "trigger_multiple_bcs_ns_shwr_cntr", "shwr_cntr" );
    _id_0737( "trigger_multiple_bcs_ns_shwr_ne", "shwr_ne" );
    _id_0737( "trigger_multiple_bcs_ns_shwr_sw", "shwr_sw" );
    _id_0737( "trigger_multiple_bcs_ns_sndbgs", "sndbgs" );
    _id_0737( "trigger_multiple_bcs_ns_stairs_down", "stairs_down" );
    _id_0737( "trigger_multiple_bcs_ns_stairs_up", "stairs_up" );
    _id_0737( "trigger_multiple_bcs_ns_stairs_ylw", "stairs_ylw" );
    _id_0737( "trigger_multiple_bcs_ns_tun_leadoutside", "tun_leadoutside" );
    _id_0737( "trigger_multiple_bcs_ns_vendmach", "vendmach" );
    _id_0737( "trigger_multiple_bcs_ns_wirespl_lg", "wirespl_lg" );
    _id_0737( "trigger_multiple_bcs_ns_wlkwy_abv_archs", "wlkwy_abv_archs" );
    _id_0737( "trigger_multiple_bcs_df_monument_courtyard", "monument_courtyard" );
    _id_0737( "trigger_multiple_bcs_df_monument_top", "monument_top" );
    _id_0737( "trigger_multiple_bcs_df_car_parked", "car_parked" );
    _id_0737( "trigger_multiple_bcs_df_embassy", "embassy" );
    _id_0737( "trigger_multiple_bcs_df_embassy_1st", "embassy_1st" );
    _id_0737( "trigger_multiple_bcs_df_embassy_3rd", "embassy_3rd" );
    _id_0737( "trigger_multiple_bcs_df_vehicle_snowcat", "vehicle_snowcat" );
    _id_0737( "trigger_multiple_bcs_df_vehicle_dumptruck", "vehicle_dumptruck" );
    _id_0737( "trigger_multiple_bcs_df_building_red", "building_red" );
    _id_0737( "trigger_multiple_bcs_df_vehicle_snowmobile", "vehicle_snowmobile" );
    _id_0737( "trigger_multiple_bcs_df_scaffolding_generic", "scaffolding_generic" );
    _id_0737( "trigger_multiple_bcs_df_container_red", "container_red" );
    _id_0737( "trigger_multiple_bcs_df_tires_large", "tires_large" );
    _id_0737( "trigger_multiple_bcs_df_memorial_building", "memorial_building" );
    _id_0737( "trigger_multiple_bcs_df_stand_hotdog", "stand_hotdog" );
    _id_0737( "trigger_multiple_bcs_df_stand_trading", "stand_trading" );
    _id_0737( "trigger_multiple_bcs_df_subway_entrance", "subway_entrance" );
    _id_0737( "trigger_multiple_bcs_df_rubble_generic", "rubble_generic" );
    _id_0737( "trigger_multiple_bcs_df_cases_right", "cases_right" );
    _id_0737( "trigger_multiple_bcs_df_cases_left", "cases_left" );
    _id_0737( "trigger_multiple_bcs_df_cases_generic", "cases_generic" );
    _id_0737( "trigger_multiple_bcs_df_barrier_orange", "barrier_orange" );
    _id_0737( "trigger_multiple_bcs_df_barrier_hesco", "barrier_hesco" );
    _id_0737( "trigger_multiple_bcs_df_stryker_destroyed", "stryker_destroyed" );
    _id_0737( "trigger_multiple_bcs_df_fan_exhaust", "fan_exhaust" );
    _id_0737( "trigger_multiple_bcs_df_tower_jamming", "tower_jamming" );
    _id_0737( "trigger_multiple_bcs_df_ac_generic", "ac_generic" );
    _id_0737( "trigger_multiple_bcs_df_table_computer", "table_computer" );
    _id_0737( "trigger_multiple_bcs_df_bulkhead_generic", "bulkhead_generic" );
    _id_0737( "trigger_multiple_bcs_df_bunk_generic", "bunk_generic" );
    _id_0737( "trigger_multiple_bcs_df_console_generic", "console_generic" );
    _id_0737( "trigger_multiple_bcs_df_deck_generic", "deck_generic" );
}

_id_63A9()
{
    _id_0737( "trigger_multiple_bcs_mp_dome_bunker", "bunker" );
    _id_0737( "trigger_multiple_bcs_mp_dome_bunker_back", "bunker_back" );
    _id_0737( "trigger_multiple_bcs_mp_dome_office", "office" );
    _id_0737( "trigger_multiple_bcs_mp_dome_dome", "dome" );
    _id_0737( "trigger_multiple_bcs_mp_dome_catwalk", "catwalk" );
    _id_0737( "trigger_multiple_bcs_mp_dome_loadingbay", "loadingbay" );
    _id_0737( "trigger_multiple_bcs_mp_dome_hallway", "hallway" );
    _id_0737( "trigger_multiple_bcs_mp_dome_hallway_loadingbay", "hallway_loadingbay" );
    _id_0737( "trigger_multiple_bcs_mp_dome_hallway_office", "hallway_office" );
    _id_0737( "trigger_multiple_bcs_mp_dome_wall_broken", "wall_broken" );
    _id_0737( "trigger_multiple_bcs_mp_dome_tank", "tank" );
    _id_0737( "trigger_multiple_bcs_mp_dome_radar", "radar" );
    _id_0737( "trigger_multiple_bcs_mp_dome_humvee", "humvee" );
}
