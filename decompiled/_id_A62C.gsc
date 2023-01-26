// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_8722()
{
    var_0 = 1.0;
    var_1 = 0.8;
    var_2 = 0;
    var_3 = 10;
    var_4 = 15;
    var_5 = var_4 - var_2;
    var_6 = 0.7;
    var_7 = 1.0;
    var_8 = 0.8;
    var_9 = 1.0;
    var_10 = 1.1;
    var_11 = 0.0;
    var_12 = 0.5;
    var_13 = 0.85;
    var_14 = 1.0;
    var_15 = 0.0;
    var_16 = 0.5;
    var_17 = 1.0;
    var_18 = 0.8;
    var_19 = 1.1;
    var_20 = 0.0;
    var_21 = 1.0;
    var_22 = 0.5;
    var_23 = 1.5;
    _id_A5DA::_id_118C( "pdrone_swarm" );
    _id_A5DA::_id_1187( 0.25 );
    _id_A5DA::_id_1188( "pdrn_swarm_rotor_ww" );
    _id_A5DA::_id_118B( "speed" );
    _id_A5DA::_id_1183( "volume", "pdrn_rotor_vel2vol" );
    _id_A5DA::_id_1183( "pitch", "pdrn_rotor_vel2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_118B( "doppler_exaggerated" );
    _id_A5DA::_id_1183( "pitch", "pdrn_doppler2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_1198();
    _id_A5DA::_id_1188( "pdrn_swarm_rotor_main_lp" );
    _id_A5DA::_id_118B( "speed", 0.65, 0.3 );
    _id_A5DA::_id_1183( "volume", "pdrn_rotor_vel2vol" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_118B( "doppler_exaggerated", 0.65, 0.3 );
    _id_A5DA::_id_1183( "pitch", "pdrn_doppler2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_1198();
    _id_A5DA::_id_1197();
    _id_A5DA::_id_1189();
    _id_A5DA::_id_118A( "pdrone_flyby", "pdrn_flyby_duck_envelope", 0.25, 1, [ "pdrn_by_comp" ] );
    _id_A5DA::_id_118B( "speed", 1.0, 1.0 );
    _id_A5DA::_id_1183( "pitch", "pdrn_flyby_vel2pch" );
    _id_A5DA::_id_1183( "volume", "pdrn_flyby_vel2vol" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_118B( "doppler_exaggerated", 1.0, 1.0 );
    _id_A5DA::_id_1183( "pitch", "pdrn_doppler2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_119A();
    _id_A5DA::_id_1199();
    _id_A5DA::_id_1185();
    _id_A5DA::_id_1186( "to_state_hover", ::_id_67B1, [ "speed", "distance2d" ] );
    _id_A5DA::_id_1180( "ALL" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_flying", ::_id_67B0, [ "speed", "distance2d" ] );
    _id_A5DA::_id_1180( "ALL" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_distant", ::_id_67AF, [ "distance2d" ] );
    _id_A5DA::_id_1180( "pdrn_swarm_rotor_main_lp" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_flyby", ::_id_6769, [ "distance2d" ] );
    _id_A5DA::_id_1180( "ALL" );
    _id_A5DA::_id_1182( "pdrone_flyby" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_deathspin", ::_id_6766 );
    _id_A5DA::_id_1180( "NONE" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_destruct", ::_id_6767 );
    _id_A5DA::_id_1180( "NONE" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_off", ::_id_676D );
    _id_A5DA::_id_1180( "NONE" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1195();
    _id_A5DA::_id_118D( 0.25, 50 );
    _id_A5DA::_id_118F( "main_oneshots", "state_hover", "to_state_hover", 50, 1.0 );
    _id_A5DA::_id_118E( "state_off" );
    _id_A5DA::_id_1184( "state_hover", "to_state_hover" );
    _id_A5DA::_id_1184( "state_distant", "to_state_distant" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_hover" );
    _id_A5DA::_id_1184( "state_flyby", "to_state_flyby" );
    _id_A5DA::_id_1184( "state_flying", "to_state_flying" );
    _id_A5DA::_id_1184( "state_distant", "to_state_distant" );
    _id_A5DA::_id_1184( "state_deathspin", "to_state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_flying" );
    _id_A5DA::_id_1184( "state_flyby", "to_state_flyby" );
    _id_A5DA::_id_1184( "state_distant", "to_state_distant" );
    _id_A5DA::_id_1184( "state_deathspin", "to_state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_distant" );
    _id_A5DA::_id_1184( "state_hover", "to_state_hover" );
    _id_A5DA::_id_1184( "state_flying", "to_state_flying" );
    _id_A5DA::_id_1184( "state_flyby", "to_state_flyby" );
    _id_A5DA::_id_1184( "state_deathspin", "to_state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_flyby", 3.0 );
    _id_A5DA::_id_1184( "state_hover", "to_state_hover" );
    _id_A5DA::_id_1184( "state_flying", "to_state_flying" );
    _id_A5DA::_id_1184( "state_flyby", "to_state_flyby" );
    _id_A5DA::_id_1184( "state_distant", "to_state_distant" );
    _id_A5DA::_id_1184( "state_deathspin", "to_state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_destruct" );
    _id_A5DA::_id_1184( "state_off", "to_state_off" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_119F();
    _id_A5DA::_id_119D();
    _id_A5DA::_id_117D( "pdrn_loopset_vol_env", [ [ var_4 * 0.0, 0.65 * var_0 ], [ var_4 * 0.0204, 0.66155 * var_0 ], [ var_4 * 0.0816, 0.670545 * var_0 ], [ var_4 * 0.1836, 0.688885 * var_0 ], [ var_4 * 0.3265, 0.72749 * var_0 ], [ var_4 * 0.5102, 0.80554 * var_0 ], [ var_4 * 0.7346, 0.926535 * var_0 ], [ var_4 * 1.0, 1.0 * var_0 ] ] );
    _id_A5DA::_id_117D( "pdrn_rotor_vel2vol", [ [ var_2, var_7 ], [ var_4, var_7 ] ] );
    _id_A5DA::_id_117D( "pdrn_rotor_vel2pch", [ [ var_2, var_8 ], [ var_3, var_9 ], [ var_4, var_10 ] ] );
    _id_A5DA::_id_117D( "pdrn_flyby_vel2vol", [ [ var_2, var_20 ], [ var_4, var_21 ] ] );
    _id_A5DA::_id_117D( "pdrn_flyby_vel2pch", [ [ var_2, var_22 ], [ var_4, var_23 ] ] );
    _id_A5DA::_id_117D( "pdrn_flyby_duck_envelope", [ [ 0.0, 1.0 ], [ 1.0, 1.0 ] ] );
    _id_A5DA::_id_117D( "pdrn_doppler2pch", [ [ 0.0, 0.0 ], [ 2.0, 2.0 ] ] );
    _id_A5DA::_id_119C();
}

_id_67B1( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];
    var_4 = var_0["distance2d"];
    var_5 = _id_A5DA::_id_2B70( var_4 );

    if ( var_3 <= 5.1 && var_5 < 50.0 )
        var_2 = 1;

    return var_2;
}

_id_67B0( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];
    var_4 = var_0["distance2d"];
    var_5 = _id_A5DA::_id_2B70( var_4 );

    if ( var_3 > 5.1 && var_5 < 50.0 )
        var_2 = 1;

    return var_2;
}

_id_67AF( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["distance2d"];
    var_4 = _id_A5DA::_id_2B70( var_3 );

    if ( var_4 >= 50.0 )
        var_2 = 1;

    return var_2;
}

_id_871D()
{
    var_0 = 0;
    var_1 = 10;
    var_2 = 30;
    var_3 = var_2 - var_0;
    var_4 = 0.4;
    var_5 = 0.4;
    var_6 = var_5 - var_4;
    var_7 = 1.5;
    var_8 = 1.9;
    var_9 = var_8 - var_7;
    var_10 = 270.0;
    var_11 = 1080;
    var_12 = 0.0;
    var_13 = 1.0;
    var_14 = var_13 - var_12;
    var_15 = 1.0;
    var_16 = 2.0;
    var_17 = var_16 - var_15;
    var_18 = 0.0;
    var_19 = 0.45;
    var_20 = var_19 - var_18;
    var_21 = 0.9;
    var_22 = 1.4;
    var_23 = var_22 - var_21;
    var_24 = 0.0;
    var_25 = 0.5;
    var_26 = var_2 * 0.0;
    var_27 = var_2 * 0.65;
    var_28 = 288;
    var_29 = 720;
    var_30 = 0.0;
    var_31 = 1.0;
    var_32 = var_2 * 0.6;
    var_33 = var_2 * 1.0;
    var_34 = var_33 - var_32;
    var_35 = 0.85;
    var_36 = 1.25;
    var_37 = 30;
    var_38 = 0.0;
    var_39 = 0.8;
    var_40 = 0.75;
    var_41 = 1.25;
    var_42 = 100;
    var_43 = 200;
    var_44 = 500;
    var_45 = 6.0;
    var_46 = 5.0;
    var_47 = undefined;
    var_48 = 0.6;
    var_49 = 0.5;
    _id_A5DA::_id_118C( "pdrone_atlas", ::_id_6762 );
    _id_A5DA::_id_117D( "atlasdrn_realhelo_spd2vol", [ [ var_0, var_4 ], [ var_2, var_5 ] ] );
    _id_A5DA::_id_117D( "atlasdrn_realhelo_spd2pch", [ [ var_0, var_7 ], [ var_2, var_8 ] ] );
    _id_A5DA::_id_117D( "atlasdrn_snthhelo_spd2pch", [ [ var_2 * 0.0, var_15 + 0.0 * var_17 ], [ var_2 * 0.0204, var_15 + 0.033 * var_17 ], [ var_2 * 0.0816, var_15 + 0.0587 * var_17 ], [ var_2 * 0.1836, var_15 + 0.1111 * var_17 ], [ var_2 * 0.3265, var_15 + 0.2214 * var_17 ], [ var_2 * 0.5102, var_15 + 0.4444 * var_17 ], [ var_2 * 0.7346, var_15 + 0.7901 * var_17 ], [ var_2 * 1.0, var_15 + 1.0 * var_17 ] ] );
    _id_A5DA::_id_117D( "atlasdrn_snthhelo_dst2vol", [ [ var_10, var_13 ], [ var_11, var_12 ] ] );
    _id_A5DA::_id_117D( "atlasdrn_snthhelo_spd2vol", [ [ var_0, var_12 ], [ var_2, var_13 ] ] );
    _id_A5DA::_id_117D( "atlasdrn_hover_spd2pch", [ [ var_0, var_21 ], [ var_2, var_22 ] ] );
    _id_A5DA::_id_117D( "atlasdrn_hover_spd2vol", [ [ var_0, var_19 ], [ var_2, var_18 ] ] );
    _id_A5DA::_id_117D( "atlasdrn_travelslw_spd2vol", [ [ var_26, var_25 ], [ var_27, var_24 ] ] );
    _id_A5DA::_id_117D( "atlasdrn_travelfst_dst2vol", [ [ var_28, var_31 ], [ var_29, var_30 ] ] );
    _id_A5DA::_id_117D( "atlasdrn_travelfst_spd2vol", [ [ var_32 + var_34 * 0.0, var_31 * 0.0 ], [ var_32 + var_34 * 0.0204, var_31 * 0.033 ], [ var_32 + var_34 * 0.0816, var_31 * 0.0587 ], [ var_32 + var_34 * 0.1836, var_31 * 0.1111 ], [ var_32 + var_34 * 0.3265, var_31 * 0.2214 ], [ var_32 + var_34 * 0.5102, var_31 * 0.4444 ], [ var_32 + var_34 * 0.7346, var_31 * 0.7901 ], [ var_32 + var_34 * 1.0, var_31 * 1.0 ] ] );
    _id_A5DA::_id_117D( "atlasdrn_travelfst_spd2pch", [ [ var_0, var_35 ], [ var_2, var_36 ] ] );
    _id_A5DA::_id_117D( "atlasdrn_flyby_vel2vol", [ [ var_0, var_38 ], [ var_3 * 0.25, var_39 * 0.5 ], [ var_2, var_39 ] ] );
    _id_A5DA::_id_117D( "atlasdrn_flyby_vel2pch", [ [ var_0, var_40 ], [ var_2, var_41 ] ] );
    _id_A5DA::_id_117D( "atlasdrn_doppler2pch", [ [ 0.0, 0.0 ], [ 2.0, 2.0 ] ] );
    _id_A5DA::_id_117D( "atlasdrn_flyby_duck_envelope", [ [ 0.0, 1.0 ], [ 0.4, 0.7 ], [ 0.6, 0.5 ], [ 0.8, 0.7 ], [ 1.0, 1.0 ] ] );
    _id_A5DA::_id_1187( 1.0, var_48, var_49 );
    _id_A5DA::_id_1188( "atlasdrn_real_helo_lp" );
    _id_A5DA::_id_118B( "SPEED" );
    _id_A5DA::_id_1183( "volume", "atlasdrn_realhelo_spd2vol" );
    _id_A5DA::_id_1183( "pitch", "atlasdrn_realhelo_spd2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_118B( "DOPPLER_EXAGGERATED" );
    _id_A5DA::_id_1183( "pitch", "atlasdrn_doppler2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_1198();
    _id_A5DA::_id_1188( "atlasdrn_snth_helo_lp" );
    _id_A5DA::_id_118B( "DISTANCE" );
    _id_A5DA::_id_1183( "volume", "atlasdrn_snthhelo_dst2vol" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_118B( "SPEED" );
    _id_A5DA::_id_1183( "volume", "atlasdrn_snthhelo_spd2vol" );
    _id_A5DA::_id_1183( "pitch", "atlasdrn_snthhelo_spd2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_118B( "DOPPLER" );
    _id_A5DA::_id_1183( "pitch", "atlasdrn_doppler2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_1198();
    _id_A5DA::_id_1188( "atlasdrn_hover_lp" );
    _id_A5DA::_id_118B( "SPEED" );
    _id_A5DA::_id_1183( "volume", "atlasdrn_hover_spd2vol" );
    _id_A5DA::_id_1183( "pitch", "atlasdrn_hover_spd2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_1198();
    _id_A5DA::_id_1188( "atlasdrn_travel_fst_lp" );
    _id_A5DA::_id_118B( "DISTANCE2D" );
    _id_A5DA::_id_1183( "volume", "atlasdrn_travelfst_dst2vol" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_118B( "SPEED" );
    _id_A5DA::_id_1183( "volume", "atlasdrn_travelfst_spd2vol" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_118B( "DOPPLER" );
    _id_A5DA::_id_1183( "pitch", "atlasdrn_doppler2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_1198();
    _id_A5DA::_id_1197();
    _id_A5DA::_id_1189();
    _id_A5DA::_id_118A( "atlasdrn_flyby1", "atlasdrn_flyby_duck_envelope", 0.25 );
    _id_A5DA::_id_118B( "SPEED", 1.0, 1.0 );
    _id_A5DA::_id_1183( "pitch", "atlasdrn_flyby_vel2pch" );
    _id_A5DA::_id_1183( "volume", "atlasdrn_flyby_vel2vol" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_119A();
    _id_A5DA::_id_1199();
    _id_A5DA::_id_1185();
    _id_A5DA::_id_1186( "to_state_hover", ::_id_0DAB, [ "speed", "distance2d" ] );
    _id_A5DA::_id_1180( "ALL" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_flying", ::_id_0DA9, [ "speed", "distance2d" ] );
    _id_A5DA::_id_1180( "ALL" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_distant", ::_id_0DA7, [ "distance2d" ] );
    _id_A5DA::_id_1180( "NONE" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_flyby", ::_id_0DA8, [ "distance2d" ] );
    _id_A5DA::_id_1180( "ALL" );
    _id_A5DA::_id_1182( "atlasdrn_flyby1" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_deathspin", ::_id_0DA5 );
    _id_A5DA::_id_1180( "NONE" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_destruct", ::_id_0DA6 );
    _id_A5DA::_id_1180( "NONE" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_off", ::_id_0DAC );
    _id_A5DA::_id_1180( "NONE" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1195();
    _id_A5DA::_id_118D( 0.25, 50 );
    _id_A5DA::_id_118F( "main_oneshots", "state_hover", "to_state_hover", 50, 1.0 );
    _id_A5DA::_id_118E( "state_off" );
    _id_A5DA::_id_1184( "state_hover", "to_state_hover" );
    _id_A5DA::_id_1184( "state_distant", "to_state_distant" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_hover" );
    _id_A5DA::_id_1184( "state_flyby", "to_state_flyby" );
    _id_A5DA::_id_1184( "state_flying", "to_state_flying" );
    _id_A5DA::_id_1184( "state_distant", "to_state_distant" );
    _id_A5DA::_id_1184( "state_deathspin", "to_state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_flying" );
    _id_A5DA::_id_1184( "state_flyby", "to_state_flyby" );
    _id_A5DA::_id_1184( "state_distant", "to_state_distant" );
    _id_A5DA::_id_1184( "state_deathspin", "to_state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_distant" );
    _id_A5DA::_id_1184( "state_hover", "to_state_hover" );
    _id_A5DA::_id_1184( "state_flying", "to_state_flying" );
    _id_A5DA::_id_1184( "state_flyby", "to_state_flyby" );
    _id_A5DA::_id_1184( "state_deathspin", "to_state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_flyby", 3.0 );
    _id_A5DA::_id_1184( "state_hover", "to_state_hover" );
    _id_A5DA::_id_1184( "state_flying", "to_state_flying" );
    _id_A5DA::_id_1184( "state_flyby", "to_state_flyby" );
    _id_A5DA::_id_1184( "state_distant", "to_state_distant" );
    _id_A5DA::_id_1184( "state_deathspin", "to_state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_destruct" );
    _id_A5DA::_id_1184( "state_off", "to_state_off" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_119F();
    _id_A5DA::_id_119D();
    _id_A5DA::_id_119C();
}

_id_6762( var_0 )
{
    var_1 = self;
    var_2 = var_1 _id_A5DA::_id_11CA();
    var_2 thread _id_0DAD();
}

_id_0DAC()
{
    return 0;
}

_id_0DAB( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];
    var_4 = var_0["distance2d"];
    var_5 = _id_A5DA::_id_2B70( var_4 );

    if ( var_3 <= 5.1 && var_5 < 20.0 )
        var_2 = 1;

    return var_2;
}

_id_0DA9( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];
    var_4 = var_0["distance2d"];
    var_5 = _id_A5DA::_id_2B70( var_4 );

    if ( var_3 > 5.1 && var_5 < 20.0 )
        var_2 = 1;

    return var_2;
}

_id_0DA7( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["distance2d"];
    var_4 = _id_A5DA::_id_2B70( var_3 );

    if ( var_4 >= 20.0 )
        var_2 = 1;

    return var_2;
}

_id_0DA8( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["distance2d"];
    var_4 = _id_A5DA::_id_2B70( var_3 );

    if ( !isdefined( var_1._id_391B ) )
    {
        var_1._id_391B = spawnstruct();
        var_1._id_391B._id_6F48 = var_4;
        var_1._id_391B._id_6F39 = 0;
    }
    else
    {
        var_5 = var_4 - var_1._id_391B._id_6F48;

        if ( var_5 < 0 && var_4 < 6.0 )
            var_2 = 1;

        var_1._id_391B._id_6F48 = var_4;
        var_1._id_391B._id_6F39 = var_5;
    }

    return var_2;
}

_id_0DAA( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["distance2d"];
    var_4 = var_0["relative_speed"];
    var_5 = _id_A5DA::_id_2B70( var_3 );

    if ( var_5 < 30 )
        var_2 = 1;

    return var_2;
}

_id_0DA5( var_0, var_1 )
{
    return 0;
}

_id_0DA6( var_0, var_1 )
{
    return 0;
}

_id_0DAD()
{
    self endon( "death" );
    var_0 = self;
    var_1 = 360;
    var_2 = level.player.origin;
    var_3 = 0.25;
    var_4 = 17.6;

    while ( isdefined( var_0 ) )
    {
        if ( distance( level.player.origin, var_0.origin ) < var_1 )
        {
            var_5 = length( level.player getvelocity() ) / var_4;

            if ( var_5 > 0.5 )
            {
                if ( _id_A5D2::_id_0FE9( 20 ) )
                {
                    var_0 _id_A59A::_id_69C1( "atlasdrn_lens_focus" );
                    wait(randomfloatrange( 2, 5 ));
                }
            }

            var_2 = level.player.origin;
        }

        wait(var_3);
    }
}

_id_871E()
{
    var_0 = 0;
    var_1 = 30;
    var_2 = var_1 - var_0;
    var_3 = 0.4;
    var_4 = 0.4;
    var_5 = 1.5;
    var_6 = 1.9;
    var_7 = 270.0;
    var_8 = 3600;
    var_9 = 0.0;
    var_10 = 1.0;
    var_11 = var_10 - var_9;
    var_12 = 1.0;
    var_13 = 2.0;
    var_14 = var_13 - var_12;
    var_15 = 0.0;
    var_16 = 0.45;
    var_17 = var_16 - var_15;
    var_18 = 0.9;
    var_19 = 1.4;
    var_20 = var_19 - var_18;
    var_21 = 288;
    var_22 = 720;
    var_23 = 0.0;
    var_24 = 1.0;
    var_25 = var_1 * 0.6;
    var_26 = var_1 * 1.0;
    var_27 = var_26 - var_25;
    var_28 = 0.85;
    var_29 = 1.25;
    var_30 = 0.0;
    var_31 = 1.0;
    var_32 = 0.5;
    var_33 = 1.5;
    var_34 = 100;
    var_35 = 200;
    var_36 = 500;
    var_37 = 6.0;
    var_38 = 20.0;
    var_39 = 5.0;
    var_40 = undefined;
    var_41 = 0.3;
    var_42 = 0.3;
    _id_A5DA::_id_118C( "pdrone_atlas_large" );
    _id_A5DA::_id_1187( 3.0, var_41, var_42 );
    _id_A5DA::_id_1188( "adrn_real_helo_lp" );
    _id_A5DA::_id_118B( "SPEED" );
    _id_A5DA::_id_1183( "volume", "adrn_realhelo_spd2vol" );
    _id_A5DA::_id_1183( "pitch", "adrn_realhelo_spd2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_118B( "DOPPLER_EXAGGERATED" );
    _id_A5DA::_id_1183( "pitch", "adrn_doppler2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_1198();
    _id_A5DA::_id_1188( "adrn_snth_helo_lp" );
    _id_A5DA::_id_118B( "SPEED" );
    _id_A5DA::_id_1183( "volume", "adrn_snthhelo_spd2vol" );
    _id_A5DA::_id_1183( "pitch", "adrn_snthhelo_spd2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_118B( "DOPPLER" );
    _id_A5DA::_id_1183( "pitch", "adrn_doppler2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_1198();
    _id_A5DA::_id_1188( "adrn_hover_lp" );
    _id_A5DA::_id_118B( "SPEED" );
    _id_A5DA::_id_1183( "volume", "adrn_hover_spd2vol" );
    _id_A5DA::_id_1183( "pitch", "adrn_hover_spd2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_1198();
    _id_A5DA::_id_1188( "adrn_travel_fst_lp" );
    _id_A5DA::_id_118B( "SPEED" );
    _id_A5DA::_id_1183( "volume", "adrn_travelfst_spd2vol" );
    _id_A5DA::_id_1183( "pitch", "adrn_travelfst_spd2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_118B( "DOPPLER" );
    _id_A5DA::_id_1183( "pitch", "adrn_doppler2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_1198();
    _id_A5DA::_id_1197();
    _id_A5DA::_id_1189();
    _id_A5DA::_id_118A( "adrn_flyby1", "adrn_flyby_duckenvelope", 0.25 );
    _id_A5DA::_id_118B( "SPEED", 1.0, 1.0 );
    _id_A5DA::_id_1183( "pitch", "adrn_flyby_vel2pch" );
    _id_A5DA::_id_1183( "volume", "adrn_flyby_vel2vol" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_119A();
    _id_A5DA::_id_1199();
    _id_A5DA::_id_1185();
    _id_A5DA::_id_1186( "to_state_hover", ::_id_0871, [ "speed", "distance2d" ] );
    _id_A5DA::_id_1180( "ALL" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_flying", ::_id_086F, [ "speed", "distance2d" ] );
    _id_A5DA::_id_1180( "ALL" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_distant", ::_id_086D, [ "distance2d" ] );
    _id_A5DA::_id_1180( [ "adrn_real_helo_lp" ] );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_flyby", ::_id_086E, [ "distance2d" ] );
    _id_A5DA::_id_1180( "ALL" );
    _id_A5DA::_id_1182( "adrn_flyby1" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_deathspin", ::_id_086B );
    _id_A5DA::_id_1180( "NONE" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_destruct", ::_id_086C );
    _id_A5DA::_id_1180( "NONE" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_off", ::_id_0872 );
    _id_A5DA::_id_1180( "NONE" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1195();
    _id_A5DA::_id_118D( 0.25, 50 );
    _id_A5DA::_id_118F( "main_oneshots", "state_hover", "to_state_hover", 50, 1.0 );
    _id_A5DA::_id_118E( "state_off" );
    _id_A5DA::_id_1184( "state_hover", "to_state_hover" );
    _id_A5DA::_id_1184( "state_distant", "to_state_distant" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_hover" );
    _id_A5DA::_id_1184( "state_flyby", "to_state_flyby" );
    _id_A5DA::_id_1184( "state_flying", "to_state_flying" );
    _id_A5DA::_id_1184( "state_distant", "to_state_distant" );
    _id_A5DA::_id_1184( "state_deathspin", "to_state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_flying" );
    _id_A5DA::_id_1184( "state_flyby", "to_state_flyby" );
    _id_A5DA::_id_1184( "state_distant", "to_state_distant" );
    _id_A5DA::_id_1184( "state_deathspin", "to_state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_distant" );
    _id_A5DA::_id_1184( "state_hover", "to_state_hover" );
    _id_A5DA::_id_1184( "state_flying", "to_state_flying" );
    _id_A5DA::_id_1184( "state_flyby", "to_state_flyby" );
    _id_A5DA::_id_1184( "state_deathspin", "to_state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_flyby", 3.0 );
    _id_A5DA::_id_1184( "state_hover", "to_state_hover" );
    _id_A5DA::_id_1184( "state_flying", "to_state_flying" );
    _id_A5DA::_id_1184( "state_flyby", "to_state_flyby" );
    _id_A5DA::_id_1184( "state_distant", "to_state_distant" );
    _id_A5DA::_id_1184( "state_deathspin", "to_state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_destruct" );
    _id_A5DA::_id_1184( "state_off", "to_state_off" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_119F();
    _id_A5DA::_id_119D();
    _id_A5DA::_id_117D( "adrn_realhelo_spd2vol", [ [ 0.0, 0.2827 ], [ 30.0, 0.466 ] ] );
    _id_A5DA::_id_117D( "adrn_realhelo_spd2pch", [ [ 0.0, 1.45 ], [ 22.5178, 1.7906 ], [ 30.0, 2.0 ] ] );
    _id_A5DA::_id_117D( "adrn_snthhelo_spd2vol", [ [ 0.0, 0.0026 ], [ 4.2043, 0.0 ], [ 12.4703, 0.144 ], [ 30.0, 0.5 ] ] );
    _id_A5DA::_id_117D( "adrn_snthhelo_spd2pch", [ [ 0.0, 0.555 ], [ 30.0, 2.0 ] ] );
    _id_A5DA::_id_117D( "adrn_snthhelo_dst2vol", [ [ var_7, var_10 ], [ var_8, var_9 ] ] );
    _id_A5DA::_id_117D( "adrn_hover_spd2vol", [ [ 0.0, 0.0974 ], [ 2.3515, 0.0958 ], [ 5.4157, 0.1084 ], [ 13.4679, 0.2027 ], [ 18.171, 0.2403 ], [ 30.0, 0.3 ] ] );
    _id_A5DA::_id_117D( "adrn_hover_spd2pch", [ [ 0.0, 0.8584 ], [ 30.0, 1.25 ] ] );
    _id_A5DA::_id_117D( "adrn_travelfst_spd2vol", [ [ 0.0, 0.0 ], [ 7.4109, 0.0 ], [ 13.9667, 0.0385 ], [ 19.1686, 0.1026 ], [ 23.3729, 0.1686 ], [ 26.2233, 0.2456 ], [ 30.0, 0.35 ] ] );
    _id_A5DA::_id_117D( "adrn_travelfst_spd2pch", [ [ 0.0, 0.8584 ], [ 30.0, 1.25 ] ] );
    _id_A5DA::_id_117D( "adrn_travelfst_dst2vol", [ [ 0.0, 0.2827 ], [ 30.0, 0.466 ] ] );
    _id_A5DA::_id_117D( "adrn_flyby_vel2vol", [ [ var_0, var_30 ], [ var_2 * 0.25, var_31 * 0.5 ], [ var_1, var_31 ] ] );
    _id_A5DA::_id_117D( "adrn_flyby_vel2pch", [ [ var_0, var_32 ], [ var_1, var_33 ] ] );
    _id_A5DA::_id_117D( "adrn_doppler2pch", [ [ 0.0, 0.0 ], [ 2.0, 2.0 ] ] );
    _id_A5DA::_id_117D( "adrn_flyby_duckenvelope", [ [ 0.0, 1.0 ], [ 0.4, 0.7 ], [ 0.6, 0.5 ], [ 0.8, 0.7 ], [ 1.0, 1.0 ] ] );
    _id_A5DA::_id_119C();
}

_id_0872()
{
    return 0;
}

_id_0871( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];
    var_4 = var_0["distance2d"];
    var_5 = _id_A5DA::_id_2B70( var_4 );

    if ( var_3 <= 5.1 && var_5 < 30.0 )
        var_2 = 1;

    return var_2;
}

_id_086F( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];
    var_4 = var_0["distance2d"];
    var_5 = _id_A5DA::_id_2B70( var_4 );

    if ( var_3 > 5.1 && var_5 < 30.0 )
        var_2 = 1;

    return var_2;
}

_id_086D( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["distance2d"];
    var_4 = _id_A5DA::_id_2B70( var_3 );

    if ( var_4 >= 30.0 )
        var_2 = 1;

    return var_2;
}

_id_086E( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["distance2d"];
    var_4 = _id_A5DA::_id_2B70( var_3 );

    if ( !isdefined( var_1._id_391B ) )
    {
        var_1._id_391B = spawnstruct();
        var_1._id_391B._id_6F48 = var_4;
        var_1._id_391B._id_6F39 = 0;
    }
    else
    {
        var_5 = var_4 - var_1._id_391B._id_6F48;

        if ( var_5 < 0 && var_4 < 6.0 )
            var_2 = 1;

        var_1._id_391B._id_6F48 = var_4;
        var_1._id_391B._id_6F39 = var_5;
    }

    return var_2;
}

_id_0870( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["distance2d"];
    var_4 = var_0["relative_speed"];
    var_5 = _id_A5DA::_id_2B70( var_3 );

    if ( var_5 < 30 )
        var_2 = 1;

    return var_2;
}

_id_086B( var_0, var_1 )
{
    return 0;
}

_id_086C( var_0, var_1 )
{
    return 0;
}

_id_871F()
{
    var_0 = 1.0;
    var_1 = 0.8;
    var_2 = 0;
    var_3 = 10;
    var_4 = 15;
    var_5 = var_4 - var_2;
    var_6 = 0.7;
    var_7 = 1.0;
    var_8 = 0.8;
    var_9 = 1.0;
    var_10 = 1.1;
    var_11 = 0.0;
    var_12 = 0.5;
    var_13 = 0.85;
    var_14 = 1.0;
    var_15 = 0.0;
    var_16 = 0.5;
    var_17 = 1.0;
    var_18 = 0.8;
    var_19 = 1.1;
    var_20 = 0.0;
    var_21 = 1.0;
    var_22 = 0.5;
    var_23 = 1.5;
    _id_A5DA::_id_118C( "pdrone" );
    _id_A5DA::_id_1187( 3 );
    _id_A5DA::_id_1188( "pdrn_rotor_ww_lw" );
    _id_A5DA::_id_118B( "speed" );
    _id_A5DA::_id_1183( "volume", "pdrn_rotor_ww_lw" );
    _id_A5DA::_id_1183( "volume", "pdrn_loopset_vol_env" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_118B( "doppler_exaggerated" );
    _id_A5DA::_id_1183( "pitch", "pdrn_doppler2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_1198();
    _id_A5DA::_id_1188( "pdrn_rotor_ww_md" );
    _id_A5DA::_id_118B( "speed" );
    _id_A5DA::_id_1183( "volume", "pdrn_rotor_ww_hi" );
    _id_A5DA::_id_1183( "volume", "pdrn_loopset_vol_env" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_118B( "doppler_exaggerated" );
    _id_A5DA::_id_1183( "pitch", "pdrn_doppler2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_1198();
    _id_A5DA::_id_1188( "pdrn_rotor_ww_hi" );
    _id_A5DA::_id_118B( "speed" );
    _id_A5DA::_id_1183( "volume", "pdrn_rotor_ww_md" );
    _id_A5DA::_id_1183( "volume", "pdrn_loopset_vol_env" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_118B( "doppler_exaggerated" );
    _id_A5DA::_id_1183( "pitch", "pdrn_doppler2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_1198();
    _id_A5DA::_id_1188( "pdrn_rotor_main_lp" );
    _id_A5DA::_id_118B( "speed", 0.65, 0.3 );
    _id_A5DA::_id_1183( "volume", "pdrn_rotor_vel2vol" );
    _id_A5DA::_id_1183( "volume", "pdrn_loopset_vol_env" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_118B( "doppler_exaggerated", 0.65, 0.3 );
    _id_A5DA::_id_1183( "pitch", "pdrn_doppler2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_1198();

    if ( !level.currentgen )
    {
        _id_A5DA::_id_1188( "pdrn_whine_lp" );
        _id_A5DA::_id_118B( "speed", 0.65, 0.3 );
        _id_A5DA::_id_1183( "volume", "pdrn_whine_vel2vol" );
        _id_A5DA::_id_119B();
        _id_A5DA::_id_118B( "doppler_exaggerated", 0.65, 0.3 );
        _id_A5DA::_id_1183( "pitch", "pdrn_doppler2pch" );
        _id_A5DA::_id_119B();
        _id_A5DA::_id_1198();
        _id_A5DA::_id_1188( "pdrn_pink_hipass_lp" );
        _id_A5DA::_id_118B( "speed" );
        _id_A5DA::_id_1183( "volume", "pdrn_noise_hi_vel2vol" );
        _id_A5DA::_id_119B();
        _id_A5DA::_id_118B( "distance" );
        _id_A5DA::_id_1183( "volume", "pdrn_noise_hi_dist2vol" );
        _id_A5DA::_id_119B();
        _id_A5DA::_id_118B( "doppler_exaggerated", 0.65, 0.3 );
        _id_A5DA::_id_1183( "pitch", "pdrn_doppler2pch" );
        _id_A5DA::_id_119B();
        _id_A5DA::_id_1198();
        _id_A5DA::_id_1188( "pdrn_pink_lopass_lp" );
        _id_A5DA::_id_118B( "speed" );
        _id_A5DA::_id_1183( "volume", "pdrn_noise_lo_vel2vol" );
        _id_A5DA::_id_119B();
        _id_A5DA::_id_118B( "distance" );
        _id_A5DA::_id_1183( "volume", "pdrn_noise_lo_dist2vol" );
        _id_A5DA::_id_119B();
        _id_A5DA::_id_118B( "doppler_exaggerated", 0.65, 0.3 );
        _id_A5DA::_id_1183( "pitch", "pdrn_doppler2pch" );
        _id_A5DA::_id_119B();
        _id_A5DA::_id_1198();
    }

    _id_A5DA::_id_1197();
    _id_A5DA::_id_1189();
    _id_A5DA::_id_118A( "pdrone_flyby", "pdrn_flyby_duck_envelope", 0.25, 1, [ "pdrn_by_1", "pdrn_by_2" ] );
    _id_A5DA::_id_118B( "speed", 1.0, 1.0 );
    _id_A5DA::_id_1183( "pitch", "pdrn_flyby_vel2pch" );
    _id_A5DA::_id_1183( "volume", "pdrn_flyby_vel2vol" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_118B( "doppler_exaggerated", 1.0, 1.0 );
    _id_A5DA::_id_1183( "pitch", "pdrn_doppler2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_119A();
    _id_A5DA::_id_118A( "foo_oneshot", "pdrn_flyby_duck_envelope", 0.25, 1, [ "pdrn_by_1", "pdrn_by_2" ] );
    _id_A5DA::_id_118B( "speed", 1.0, 1.0 );
    _id_A5DA::_id_1183( "pitch", "pdrn_flyby_vel2pch" );
    _id_A5DA::_id_1183( "volume", "pdrn_flyby_vel2vol" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_118B( "doppler_exaggerated", 1.0, 1.0 );
    _id_A5DA::_id_1183( "pitch", "pdrn_doppler2pch" );
    _id_A5DA::_id_119B();
    _id_A5DA::_id_119A();
    _id_A5DA::_id_1199();
    _id_A5DA::_id_1185();
    _id_A5DA::_id_1186( "to_state_hover", ::_id_676C, [ "speed", "distance2d" ] );
    _id_A5DA::_id_1180( "ALL" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_flying", ::_id_676A, [ "speed", "distance2d" ] );
    _id_A5DA::_id_1180( "ALL" );
    _id_A5DA::_id_1182( "foo_oneshot" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_distant", ::_id_6768, [ "distance2d" ] );
    _id_A5DA::_id_1180( "pdrn_rotor_main_lp" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_flyby", ::_id_6769, [ "distance2d" ] );
    _id_A5DA::_id_1180( "ALL" );

    if ( !0 )
        _id_A5DA::_id_1182( "pdrone_flyby" );

    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_deathspin", ::_id_6766 );
    _id_A5DA::_id_1180( "NONE" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_destruct", ::_id_6767 );
    _id_A5DA::_id_1180( "NONE" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1186( "to_state_off", ::_id_676D );
    _id_A5DA::_id_1180( "NONE" );
    _id_A5DA::_id_1196();
    _id_A5DA::_id_1195();
    _id_A5DA::_id_118D( 0.25, 50 );
    _id_A5DA::_id_118F( "main_oneshots", "state_hover", "to_state_hover", 50, 1.0 );
    _id_A5DA::_id_118E( "state_off" );
    _id_A5DA::_id_1184( "state_hover", "to_state_hover" );
    _id_A5DA::_id_1184( "state_distant", "to_state_distant" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_hover" );
    _id_A5DA::_id_1184( "state_flyby", "to_state_flyby" );
    _id_A5DA::_id_1184( "state_flying", "to_state_flying" );
    _id_A5DA::_id_1184( "state_distant", "to_state_distant" );
    _id_A5DA::_id_1184( "state_deathspin", "to_state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_flying" );
    _id_A5DA::_id_1184( "state_flyby", "to_state_flyby" );
    _id_A5DA::_id_1184( "state_distant", "to_state_distant" );
    _id_A5DA::_id_1184( "state_deathspin", "to_state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_distant" );
    _id_A5DA::_id_1184( "state_hover", "to_state_hover" );
    _id_A5DA::_id_1184( "state_flying", "to_state_flying" );
    _id_A5DA::_id_1184( "state_flyby", "to_state_flyby" );
    _id_A5DA::_id_1184( "state_deathspin", "to_state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_flyby", 3.0 );
    _id_A5DA::_id_1184( "state_hover", "to_state_hover" );
    _id_A5DA::_id_1184( "state_flying", "to_state_flying" );
    _id_A5DA::_id_1184( "state_flyby", "to_state_flyby" );
    _id_A5DA::_id_1184( "state_distant", "to_state_distant" );
    _id_A5DA::_id_1184( "state_deathspin", "to_state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_deathspin" );
    _id_A5DA::_id_1184( "state_destruct", "to_state_destruct" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_118E( "state_destruct" );
    _id_A5DA::_id_1184( "state_off", "to_state_off" );
    _id_A5DA::_id_119E();
    _id_A5DA::_id_119F();
    _id_A5DA::_id_119D();
    _id_A5DA::_id_117D( "pdrn_foo_env_function", ::_id_397F );
    _id_A5DA::_id_117D( "pdrn_loopset_vol_env", [ [ var_4 * 0.0, 0.65 * var_0 ], [ var_4 * 0.0204, 0.66155 * var_0 ], [ var_4 * 0.0816, 0.670545 * var_0 ], [ var_4 * 0.1836, 0.688885 * var_0 ], [ var_4 * 0.3265, 0.72749 * var_0 ], [ var_4 * 0.5102, 0.80554 * var_0 ], [ var_4 * 0.7346, 0.926535 * var_0 ], [ var_4 * 1.0, 1.0 * var_0 ] ] );
    _id_A5DA::_id_117D( "pdrn_rotor_ww_lw", [ [ var_4 * 0.0, 1.0 ], [ var_4 * 0.333, 1.0 ], [ var_4 * 0.666, 0.0 ], [ var_4 * 1.0, 0.0 ] ] );
    _id_A5DA::_id_117D( "pdrn_rotor_ww_md", [ [ var_4 * 0.0, 0.0 ], [ var_4 * 0.333, 1.0 ], [ var_4 * 0.666, 1.0 ], [ var_4 * 1.0, 0.0 ] ] );
    _id_A5DA::_id_117D( "pdrn_rotor_ww_hi", [ [ var_4 * 0.0, 0.0 ], [ var_4 * 0.333, 0.0 ], [ var_4 * 0.666, 1.0 ], [ var_4 * 1.0, 1.0 ] ] );
    _id_A5DA::_id_117D( "pdrn_rotor_vel2vol", [ [ var_2, var_6 ], [ var_4, var_7 ] ] );
    _id_A5DA::_id_117D( "pdrn_rotor_vel2pch", [ [ var_2, var_8 ], [ var_3, var_9 ], [ var_4, var_10 ] ] );
    _id_A5DA::_id_117D( "pdrn_whine_vel2vol", [ [ var_2, var_11 ], [ var_2 + ( var_4 - var_2 ) * 0.666, var_11 + ( var_12 - var_11 ) * 0.0 ], [ var_4, var_12 ] ] );
    _id_A5DA::_id_117D( "pdrn_whine_vel2pch", [ [ var_2, var_13 ], [ var_4, var_14 ] ] );
    _id_A5DA::_id_117D( "pdrn_noise_lo_vel2vol", [ [ var_2, var_15 ], [ var_2 + ( var_4 - var_2 ) * 0.66, var_11 ], [ var_4, var_16 ] ] );
    _id_A5DA::_id_117D( "pdrn_noise_hi_vel2vol", [ [ var_2, var_15 ], [ var_2 + ( var_4 - var_2 ) * 0.66, var_11 ], [ var_4, var_17 ] ] );
    _id_A5DA::_id_117D( "pdrn_noise_vel2pch", [ [ var_2, var_18 ], [ var_4, var_18 ] ] );
    _id_A5DA::_id_117D( "pdrn_noise_hi_dist2vol", [ [ _id_A5DA::_id_A3A9( 0 ), var_17 ], [ _id_A5DA::_id_A3A9( 4 ), var_17 * 0.25 ], [ _id_A5DA::_id_A3A9( 6 ), var_17 * 0.4 ], [ _id_A5DA::_id_A3A9( 8 ), var_15 ] ] );
    _id_A5DA::_id_117D( "pdrn_noise_lo_dist2vol", [ [ _id_A5DA::_id_A3A9( 3 ), var_16 ], [ _id_A5DA::_id_A3A9( 12 ), var_15 ] ] );
    _id_A5DA::_id_117D( "pdrn_flyby_vel2vol", [ [ var_2, var_20 ], [ var_4, var_21 ] ] );
    _id_A5DA::_id_117D( "pdrn_flyby_vel2pch", [ [ var_2, var_22 ], [ var_4, var_23 ] ] );
    _id_A5DA::_id_117D( "pdrn_flyby_duck_envelope", [ [ 0.0, 1.0 ], [ 0.33, 0.33 ], [ 0.66, 0.33 ], [ 1.33, 1.0 ] ] );
    _id_A5DA::_id_117D( "pdrn_doppler2pch", [ [ 0.0, 0.0 ], [ 2.0, 2.0 ] ] );
    _id_A5DA::_id_119C();
}

_id_397F()
{
    return 1.0;
}

_id_676D()
{
    return 0;
}

_id_676C( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];
    var_4 = var_0["distance2d"];
    var_5 = _id_A5DA::_id_2B70( var_4 );

    if ( var_3 <= 5.1 && var_5 < 25 )
        var_2 = 1;

    return var_2;
}

_id_676A( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];
    var_4 = var_0["distance2d"];
    var_5 = _id_A5DA::_id_2B70( var_4 );

    if ( var_3 > 5.1 && var_5 < 25 )
        var_2 = 1;

    return var_2;
}

_id_6768( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["distance2d"];
    var_4 = _id_A5DA::_id_2B70( var_3 );

    if ( var_4 >= 25 )
        var_2 = 1;

    return var_2;
}

_id_6769( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["distance2d"];
    var_4 = _id_A5DA::_id_2B70( var_3 );

    if ( !isdefined( var_1._id_391B ) )
    {
        var_1._id_391B = spawnstruct();
        var_1._id_391B._id_6F48 = var_4;
        var_1._id_391B._id_6F39 = 0;
    }
    else
    {
        var_5 = var_4 - var_1._id_391B._id_6F48;

        if ( var_5 < 0 && var_4 < 6.0 )
        {
            if ( 0 )
                var_2 = [ "pdrone_flyby" ];
            else
                var_2 = 1;
        }

        var_1._id_391B._id_6F48 = var_4;
        var_1._id_391B._id_6F39 = var_5;
    }

    return var_2;
}

_id_676B( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["distance2d"];
    var_4 = var_0["relative_speed"];
    var_5 = _id_A5DA::_id_2B70( var_3 );

    if ( var_5 < 30 )
        var_2 = 1;

    return var_2;
}

_id_6766( var_0, var_1 )
{
    return 0;
}

_id_6767( var_0, var_1 )
{
    return 0;
}

_id_67AE( var_0, var_1 )
{
    if ( !isdefined( var_1._id_4E7C ) )
    {
        var_1._id_4E7C = 1.0;
        var_1._id_4E7B = 1.0;
        var_1._id_5C30 = 0.7;
        var_1._id_5A10 = 1.2;
        var_1._id_868B = 0.65;
        var_1._id_8686 = 0.3;
    }

    if ( abs( var_1._id_4E7B - var_1._id_4E7C ) < 0.0001 )
        var_1._id_4E7C = randomfloatrange( var_1._id_5C30, var_1._id_5A10 );

    if ( var_1._id_4E7C > var_1._id_4E7B )
        var_2 = var_1._id_868B;
    else
        var_2 = var_1._id_8686;

    var_1._id_4E7B += var_2 * ( var_1._id_4E7C - var_1._id_4E7B );
    return var_0 * var_1._id_4E7B;
}

_id_67AD( var_0, var_1 )
{
    if ( !isdefined( var_1._id_4E7C ) )
        var_1._id_A346 = 0;

    var_1._id_A346 += 1;
    var_2 = gettime() * 0.001;
    var_3 = 0;
    var_4 = 2;
    var_5 = 2;
    var_6 = 1;
    var_7 = perlinnoise2d( var_2, var_3, var_4, var_5, 1 );
    return var_0 * 1;
}

_id_67AC( var_0, var_1 )
{
    if ( !isdefined( var_1._id_4E7C ) || gettime() >= var_1._id_4E7D + var_1._id_4E60 )
    {
        var_1._id_4E7B = 1.0;
        var_1._id_4E7C = randomfloatrange( 0.7, 1.2 );
        var_1._id_4E7D = gettime();
        var_1._id_4E60 = randomintrange( 500, 500 );
    }

    var_2 = ( var_1._id_4E7C - var_1._id_4E7B ) / var_1._id_4E60;
    var_1._id_4E7B += var_2;
    return var_0 * 1;
}
