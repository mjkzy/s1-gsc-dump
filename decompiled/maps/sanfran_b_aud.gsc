// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    config_system();
    init_snd_flags();
    init_globals();
    launch_threads();
    launch_loops();
    create_level_envelop_arrays();
    precache_presets();
    thread maps\sanfran_b_vo::init_pcap_vo();
    register_snd_messages();
}

config_system()
{
    soundscripts\_audio::set_stringtable_mapname( "shg" );
    soundscripts\_snd_filters::snd_set_occlusion( "med_occlusion" );
    soundscripts\_audio_mix_manager::mm_add_submix( "sfb_level_global_mix" );
    soundscripts\_audio_mix_manager::mm_add_submix( "temp_vo_premix" );
}

init_snd_flags()
{

}

init_globals()
{
    level.aud.ams_enabled = 0;
    level.aud.bump_music_for_burke_takedown = 0;
}

launch_threads()
{
    if ( soundscripts\_audio::aud_is_specops() )
        return;

    thread point_source_dambs();
    thread handle_npc_boost_jump_notetracks();
    thread handle_hatch_takedown_notetracks();
}

launch_loops()
{
    thread launch_intro_loops();
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -8415, 66864, -1133 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -8406, 67093, -1160 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_l_01", ( -8533, 66204, -1190 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -8583, 66988, -1170 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -7530, 66253, -1170 ), 1 );
    thread launch_outro_loops();
}

launch_intro_loops()
{
    if ( level.currentgen && !_func_21E( "sanfran_b_intro_tr" ) )
        return;

    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_m_01", ( -5971, 72165, -1405 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_02", ( -6041, 72238, -1409 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_01", ( -6212, 72309, -1348 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_01", ( -6146, 71895, -1426 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_01", ( -6453, 72232, -1353 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_s_01", ( -6278, 71944, -1419 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_l_02", ( -6167, 71830, -1400 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_01", ( -6146, 71865, -1455 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_l_01", ( -5942, 71867, -1383 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_s_01", ( -5950, 72049, -1465 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_01", ( -5971, 72165, -1405 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_02", ( -6637, 70983, -1307 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_l_01", ( -6291, 71600, -1312 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_l_02", ( -6314, 71482, -1312 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_s_01", ( -6227, 71472, -1342 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_m_01", ( -5986, 71638, -1338 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_02", ( -5982, 71456, -1294 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_01", ( -5998, 71358, -1268 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_s_01", ( -6358, 71219, -1375 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_m_01", ( -6358, 71046, -1350 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_s_01", ( -6280, 70981, -1323 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_02", ( -6479, 70770, -1313 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_m_01", ( -6411, 70750, -1330 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_s_01", ( -5928, 71150, -1320 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_01", ( -6031, 71100, -1320 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_m_01", ( -6099, 71063, -1320 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_l_01", ( -6043, 70866, -1309 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_l_02", ( -6797, 70685, -1342 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_m_01", ( -7786, 71198, -1334 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_s_01", ( -8256, 71039, -1331 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_m_01", ( -8179, 71476, -1285 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_s_01", ( -6094, 70383, -1338 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_m_01", ( -5699, 70132, -1335 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_l_01", ( -5739, 69369, -1328 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_s_01", ( -7148, 67537, -1340 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_02", ( -7387, 67550, -1331 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_01", ( -7460, 67441, -1336 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_01", ( -8528, 70343, -1326 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_h_01", ( -7466, 66867, -1183 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_m_01", ( -7552, 66840, -1186 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_s_01", ( -7241, 67130, -1183 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_01", ( -7310, 66861, -1190 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_m_01", ( -7333, 67214, -1067 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_01", ( -7288, 67079, -980 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_s_01", ( -7727, 67130, -1079 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_falling_l_02", ( -7247, 67272, -1190 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_falling_l_03", ( -7279, 67008, -1184 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_falling_l_01", ( -7359, 66914, -1184 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_falling_l_02", ( -7362, 66898, -1213 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_l_01", ( -7741, 66997, -1170 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_l_01", ( -8077, 67012, -1170 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_l_01", ( -8349, 66977, -1170 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_02", ( -7555, 67024, -1118 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_02", ( -7620, 66861, -1122 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_falling_l_02", ( -7725, 66921, -1162 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_falling_l_02", ( -7724, 67232, -1205 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_falling_l_03", ( -7895, 67244, -1235 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_l_01", ( -8141, 67245, -1235 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_falling_l_02", ( -8021, 67121, -1161 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_l_01", ( -8021, 67121, -1161 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_falling_l_01", ( -7907, 67123, -1170 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_falling_l_03", ( -7942, 66881, -1170 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_falling_l_02", ( -8208, 66881, -1170 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -8294, 66892, -1170 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_02", ( -8315, 67050, -1161 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -6805, 66604, -1139 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_02", ( -7117, 65789, -1139 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -8300, 66875, -1118 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_water_falling_l_03", ( -8224, 66910, -1190 ), 1, "aud_stop_intro" );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_transition_intro_to_outro" );
        level notify( "aud_stop_intro" );
    }
}

launch_outro_loops()
{
    if ( level.currentgen && !_func_21E( "sanfran_b_outro_tr" ) )
        level waittill( "tff_post_transition_intro_to_outro" );

    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_01", ( -7577, 66734, -1147 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7798, 66518, -1137 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7795, 66425, -1137 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_l_01", ( -7342, 66438, -1132 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7342, 66438, -1132 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7465, 66386, -1139 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7472, 66584, -1139 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7108, 66208, -1135 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7374, 66485, -1131 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7111, 66392, -1135 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7111, 65622, -1135 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7102, 66724, -1135 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7102, 66724, -1135 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_falling_l_01", ( -7628, 66708, -1159 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_falling_l_02", ( -7455, 66742, -1143 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7369, 66675, -1133 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_02", ( -6992, 65864, -1131 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_l_01", ( -7342, 66438, -1132 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7155, 66637, -1203 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_l_01", ( -7086, 66619, -1198 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_l_01", ( -7141, 66272, -1134 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -6809, 66109, -1129 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -6808, 66363, -1130 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -6809, 65853, -1130 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_l_01", ( -6801, 65968, -1197 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_l_01", ( -6799, 66291, -1197 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7342, 65991, -1128 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7250, 65988, -1128 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_l_01", ( -7287, 66012, -1196 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_l_01", ( -7107, 65631, -1217 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_02", ( -7387, 65688, -1126 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -7413, 66274, -1170 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -8406, 67093, -1160 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_h_01", ( -7601, 65752, -1190 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_02", ( -7599, 65773, -1190 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_l_02", ( -7599, 65765, -1190 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_02", ( -7915, 65794, -1170 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7886, 65769, -1133 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7917, 65790, -1180 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_falling_l_01", ( -7870, 65825, -1208 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_02", ( -7919, 65917, -1157 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -7843, 65624, -1164 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -7907, 66009, -1181 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -7829, 66480, -1322 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_alarm_ext_01", ( -8678, 66314, -1334 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -9749, 66631, -1547 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -9796, 66066, -1547 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -9829, 65289, -1547 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -8572, 64423, -1422 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_02", ( -8415, 64420, -1312 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_02", ( -8343, 64676, -1186 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_falling_l_01", ( -8343, 64676, -1186 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -8343, 64676, -1186 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -8709, 64410, -1479 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -8622, 65859, -1162 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -8049, 65758, -1187 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_02", ( -8452, 67226, -1123 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -8384, 67265, -1108 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_h_01", ( -7744, 67169, -1045 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_02", ( -7723, 67180, -1011 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -8125, 67267, -965 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -8029, 67172, -965 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7934, 67265, -965 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7745, 67270, -965 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7837, 67173, -965 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7930, 67048, -955 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -8125, 67267, -965 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -8123, 67047, -965 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -8030, 66919, -965 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7935, 66919, -965 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7839, 66914, -965 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_02", ( -8140, 66989, -953 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_spray_01", ( -7886, 67115, -955 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_falling_l_02", ( -7855, 67241, -943 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_l_01", ( -7855, 67241, -943 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_alarm_int_01", ( -7979, 66723, -891 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -7996, 66689, -867 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -7868, 66601, -897 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -8251, 66587, -863 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -8374, 66552, -885 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -8299, 66071, -879 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -7809, 66097, -733 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -8096, 66072, -724 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -8000, 66351, -721 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_01", ( -8298, 66255, -880 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_alarm_int_02", ( -8284, 66106, -741 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_bridge_01", ( -8049, 66703, -474 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_bridge_01", ( -7773, 66806, -468 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_steam_bridge_01", ( -7809, 66511, -606 ), 1 );
}

create_level_envelop_arrays()
{
    level.aud.envs = [];
    level.aud.envs["example_envelop"] = [ [ 0.0, 0.0 ], [ 0.082, 0.426 ], [ 0.238, 0.736 ], [ 0.408, 0.844 ], [ 0.756, 0.953 ], [ 1.0, 1.0 ] ];
}

precache_presets()
{

}

register_snd_messages()
{
    soundscripts\_snd::snd_register_message( "snd_zone_handler", ::zone_handler );
    soundscripts\_snd::snd_register_message( "snd_music_handler", ::music_handler );
    soundscripts\_snd::snd_register_message( "start_deck", ::start_deck );
    soundscripts\_snd::snd_register_message( "start_interior", ::start_interior );
    soundscripts\_snd::snd_register_message( "start_hangar", ::start_hangar );
    soundscripts\_snd::snd_register_message( "start_information_center", ::start_information_center );
    soundscripts\_snd::snd_register_message( "start_bridge", ::start_bridge );
    soundscripts\_snd::snd_register_message( "intro_scene", ::intro_scene );
    soundscripts\_snd::snd_register_message( "sfb_intro_burke_foley", ::sfb_intro_burke_foley );
    soundscripts\_snd::snd_register_message( "sfb_intro_car_explode", ::sfb_intro_car_explode );
    soundscripts\_snd::snd_register_message( "intro_scene_done", ::intro_scene_done );
    soundscripts\_snd::snd_register_message( "begin_rooftop_combat", ::begin_rooftop_combat );
    soundscripts\_snd::snd_register_message( "shrike_flyby_pair_01", ::shrike_flyby_pair_01 );
    soundscripts\_snd::snd_register_message( "warbird_strafe_01", ::warbird_strafe_01 );
    soundscripts\_snd::snd_register_message( "shrike_takeoff", ::shrike_takeoff );
    soundscripts\_snd::snd_register_message( "shrike_flyby_pair_02", ::shrike_flyby_pair_02 );
    soundscripts\_snd::snd_register_message( "warbird_circling_perimeter", ::warbird_circling_perimeter );
    soundscripts\_snd::snd_register_message( "attack_drone_audio_handler", ::attack_drone_audio_handler );
    soundscripts\_snd::snd_register_message( "jammer_plant", ::jammer_plant );
    soundscripts\_snd::snd_register_message( "warbird_dropoff_01", ::warbird_dropoff_01 );
    soundscripts\_snd::snd_register_message( "warbird_dropoff_02", ::warbird_dropoff_02 );
    soundscripts\_snd::snd_register_message( "shrike_flyby_03", ::shrike_flyby_03 );
    soundscripts\_snd::snd_register_message( "warbird_dropoff_03", ::warbird_dropoff_03 );
    soundscripts\_snd::snd_register_message( "warbird_dropoff_04", ::warbird_dropoff_04 );
    soundscripts\_snd::snd_register_message( "shrike_flyby_pair_04", ::shrike_flyby_pair_04 );
    soundscripts\_snd::snd_register_message( "enter_ship", ::enter_ship );
    soundscripts\_snd::snd_register_message( "if_the_boat_is_a_rockin_dont_come_a_knockin", ::if_the_boat_is_a_rockin_dont_come_a_knockin );
    soundscripts\_snd::snd_register_message( "aud_burke_open_door", ::aud_burke_open_door );
    soundscripts\_snd::snd_register_message( "interior_door1_done", ::interior_door1_done );
    soundscripts\_snd::snd_register_message( "aud_burke_takedown", ::aud_burke_takedown );
    soundscripts\_snd::snd_register_message( "power_outage_audio", ::power_outage_audio );
    soundscripts\_snd::snd_register_message( "aud_table_pulldown", ::aud_table_pulldown );
    soundscripts\_snd::snd_register_message( "pre_hangar_hall_explosion", ::pre_hangar_hall_explosion );
    soundscripts\_snd::snd_register_message( "enter_hangar", ::enter_hangar );
    soundscripts\_snd::snd_register_message( "warbird_hanger_dropoff", ::warbird_hanger_dropoff );
    soundscripts\_snd::snd_register_message( "shrike_hanger_flyby", ::shrike_hanger_flyby );
    soundscripts\_snd::snd_register_message( "littlebird_hanger_flyby", ::littlebird_hanger_flyby );
    soundscripts\_snd::snd_register_message( "hangar_doors_open", ::hangar_doors_open );
    soundscripts\_snd::snd_register_message( "warbird_flyover_shootdown", ::warbird_flyover_shootdown );
    soundscripts\_snd::snd_register_message( "aud_hangar_door_exit", ::aud_hangar_door_exit );
    soundscripts\_snd::snd_register_message( "aud_door_takedown_mix_handler", ::aud_door_takedown_mix_handler );
    soundscripts\_snd::snd_register_message( "aud_door_takedown_scream", ::aud_door_takedown_scream );
    soundscripts\_snd::snd_register_message( "enter_room_above_hangar", ::enter_room_above_hangar );
    soundscripts\_snd::snd_register_message( "enter_server_room", ::enter_server_room );
    soundscripts\_snd::snd_register_message( "enter_bridge", ::enter_bridge );
    soundscripts\_snd::snd_register_message( "cormack_shoots_bridge_guy", ::cormack_shoots_bridge_guy );
    soundscripts\_snd::snd_register_message( "start_camera_static", ::start_camera_static );
    soundscripts\_snd::snd_register_message( "rail_gun_start", ::rail_gun_start );
    soundscripts\_snd::snd_register_message( "shrike_railgun_flyby_01", ::shrike_railgun_flyby_01 );
    soundscripts\_snd::snd_register_message( "mob_fire", ::mob_fire );
    soundscripts\_snd::snd_register_message( "shrike_railgun_flyby_02", ::shrike_railgun_flyby_02 );
    soundscripts\_snd::snd_register_message( "shrike_railgun_flyby_03", ::shrike_railgun_flyby_03 );
    soundscripts\_snd::snd_register_message( "rail_gun_done", ::rail_gun_done );
    soundscripts\_snd::snd_register_message( "cargo_ship_hit_react", ::cargo_ship_hit_react );
    soundscripts\_snd::snd_register_message( "start_bridge_end_foley", ::start_bridge_end_foley );
    soundscripts\_snd::snd_register_message( "mob_audio_setup", ::mob_audio_setup );
    soundscripts\_snd::snd_register_message( "mob_camera_static", ::mob_camera_static );
    soundscripts\_snd::snd_register_message( "mob_xform", ::mob_xform );
    soundscripts\_snd::snd_register_message( "mob_turret_move", ::mob_turret_move );
    soundscripts\_snd::snd_register_message( "mob_fire", ::mob_fire );
    soundscripts\_snd::snd_register_message( "sfb_end_logo", ::sfb_end_logo );
    soundscripts\_snd::snd_register_message( "e3_demo_fade_out", ::e3_demo_fade_out );
    soundscripts\_snd::snd_register_message( "e3_demo_fade_in", ::e3_demo_fade_in );
}

zone_handler( var_0, var_1 )
{
    switch ( var_0 )
    {

    }
}

music_handler( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "intro_scene":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0.5 );
            wait 0.5;
            soundscripts\_audio_music::mus_play( "mus_sfb_intro_scene", 0.2 );
            break;
        case "intro_scene_done":
            soundscripts\_audio_music::mus_play( "mus_sfb_intro_scene_done", 0.2, 3 );
            break;
        case "begin_rooftop_combat":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0.1 );
            soundscripts\_audio_music::mus_play( "mus_sfb_begin_rooftop_combat", 0.2, 3 );
            break;
        case "first_jammer_set":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0.1 );
            soundscripts\_audio_music::mus_play( "mus_sfb_first_jammer_set", 0.2, 3 );
            break;
        case "enter_ship":
            soundscripts\_audio_music::mus_stop( 3 );
            wait 3;
            soundscripts\_audio::aud_set_music_submix( 0.0, 2 );
            wait 2;
            soundscripts\_audio_music::mus_play( "mus_sfb_enter_ship", 1 );
            soundscripts\_audio::aud_set_music_submix( 0.45, 8 );
            break;
        case "aud_burke_open_door":
            wait 6;
            soundscripts\_audio::aud_set_music_submix( 0.8, 5 );
            break;
        case "sanfranb_crmk_switchtosonar":
            soundscripts\_audio_music::mus_stop( 10 );
            wait 10;
            soundscripts\_audio::aud_set_music_submix( 1.0, 5.0 );
            start_ams( "virus1", "adaptive" );
            break;
        case "enter_hangar":
            stop_ams();
            soundscripts\_audio::aud_set_music_submix( 0.7, 4.0 );
            soundscripts\_audio_music::mus_play( "mus_sfb_enter_hangar", 4, 4 );
            break;
        case "enter_room_above_hangar":
            soundscripts\_audio_music::mus_stop( 8 );
            soundscripts\_audio::aud_set_music_submix( 0.8, 5.0 );
            start_ams( "virus1", "adaptive" );
            break;
        case "enter_server_room":
            break;
        case "enter_bridge":
            stop_ams();
            soundscripts\_audio::aud_set_music_submix( 0.2, 4.0 );
            soundscripts\_audio_music::mus_play( "mus_sfb_enter_bridge", 3, 3 );
            break;
        case "objective_complete":
            break;
        case "rail_gun_start":
            soundscripts\_audio::aud_set_music_submix( 0.7, 3.0 );
            soundscripts\_audio_music::mus_play( "mus_sfb_objective_complete", 3, 3 );
            break;
        case "switching_to_the_second_ship":
            soundscripts\_audio::aud_set_music_submix( 0.7, 3.0 );
            soundscripts\_audio_music::mus_play( "mus_sfb_switching_to_2nd_ship", 3, 3 );
            break;
        case "rail_gun_done":
            soundscripts\_audio_music::mus_stop( 6 );
            break;
        case "mus_sfb_pcap_ending":
            var_2 = var_1;
            soundscripts\_audio::aud_wait_delay( var_2, 0, 1 );
            soundscripts\_audio::aud_set_music_submix( 1.0, 1 );
            soundscripts\_audio_music::mus_play( "mus_sfb_pcap_ending", 0.1 );
            break;
        default:
            break;
    }
}

start_ams( var_0, var_1 )
{
    thread start_ams_thread( var_0, var_1 );
}

start_ams_thread( var_0, var_1 )
{
    if ( level.aud.ams_enabled )
        return;

    level.aud.ams_enabled = 1;
    soundscripts\_audio_vehicle_manager::snd_register_vehicle( "virus1", soundscripts\_audio_presets_music::virus1_preset_constructor );
    var_2 = spawnstruct();
    var_2.preset_name = var_0;
    var_2.initial_state = var_1;
    var_2.fadein_time = 3;
    var_2.fadeout_time = 5;
    soundscripts\_snd::snd_message( "ams_start", var_2 );
    var_3 = 0.25;

    while ( level.aud.ams_enabled )
    {
        var_4 = get_interior_intensity();

        if ( level.aud.bump_music_for_burke_takedown )
        {
            var_4 = 0.4;
            var_5 = _func_0D6( "bad_guys" );

            if ( var_5.size == 0 )
                level.aud.bump_music_for_burke_takedown = 0;
        }

        var_4 = clamp( var_3 + var_4, 0, 1 );
        soundscripts\_snd::snd_message( "ams_set_intensity", var_4 );
        wait 0.25;
    }

    soundscripts\_snd::snd_message( "ams_stop" );
}

stop_ams()
{
    level.aud.ams_enabled = 0;
}

get_interior_intensity()
{
    var_0 = 0;
    var_1 = 7;
    var_2 = 0;
    var_3 = _func_0D6( "bad_guys" );

    foreach ( var_5 in var_3 )
    {
        if ( isdefined( var_5.alertlevelint ) && var_5.alertlevelint >= 3 )
            var_2++;
    }

    var_0 = clamp( var_2 / var_1, 0, 1 );

    if ( var_0 > 0 && var_0 < 0.5 )
        var_0 = 0.5;

    return var_0;
}

start_deck( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "sf_b_ext_destroyed" );
}

start_interior( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "sf_b_ext_hallway_destroyed" );
}

start_hangar( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "sf_b_int_mess_hall_destroyed" );
}

start_information_center( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "sf_b_int_nav_deck" );
}

start_bridge( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "sf_b_int_catwalk_alarm" );
}

intro_scene()
{
    soundscripts\_snd::snd_music_message( "intro_scene" );
}

sfb_intro_burke_foley()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "sfb_intro", 3.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "sfb_intro_burke_foley_01", 0.01 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "sfb_intro_helicopter", 0.01 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "sfb_intro_cormack_exo_land", 5.8 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "sfb_intro_joker_exo_land", 6.05 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "sfb_intro_cormack_enters", 6.6 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "sfb_intro_exit_foley", 21.1 );
    wait 19.0;
    soundscripts\_audio_mix_manager::mm_clear_submix( "sfb_intro", 3.0 );
}

sfb_intro_car_explode()
{
    wait 7.03;
    soundscripts\_snd_playsound::snd_play_at( "boost_land_surface_hvy_ice", ( -6310, 71984, -1450 ) );
    wait 6.17;
    soundscripts\_snd_playsound::snd_play_2d( "sfb_intro_explo" );
    wait 1.7;
    soundscripts\_snd_playsound::snd_play_2d( "sfb_intro_explo_lfe" );
}

intro_scene_done()
{
    soundscripts\_snd::snd_music_message( "intro_scene_done" );
}

handle_npc_boost_jump_notetracks()
{
    maps\_anim::addnotetrack_customfunction( "burke", "boost_begin", ::handle_boost_jump_npc_note );
    maps\_anim::addnotetrack_customfunction( "cormack", "boost_begin", ::handle_boost_jump_npc_note );
    maps\_anim::addnotetrack_customfunction( "maddox", "boost_begin", ::handle_boost_jump_npc_note );
    maps\_anim::addnotetrack_customfunction( "burke", "boosters_off", soundscripts\_snd_common::boost_jump_disable_npc );
    maps\_anim::addnotetrack_customfunction( "cormack", "boosters_off", soundscripts\_snd_common::boost_jump_disable_npc );
    maps\_anim::addnotetrack_customfunction( "maddox", "boosters_off", soundscripts\_snd_common::boost_jump_disable_npc );
}

handle_boost_jump_npc_note( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "npc_boost_jump" );
}

begin_rooftop_combat()
{
    soundscripts\_snd::snd_music_message( "begin_rooftop_combat" );
}

shrike_flyby_pair_01()
{
    var_0 = self;
    var_1 = var_0[0];
    var_2 = var_0[1];
    var_1 soundscripts\_snd_playsound::snd_play_linked( "shrike_flyby_pair_1_01" );
    wait 1.5;
    var_2 soundscripts\_snd_playsound::snd_play_linked( "shrike_flyby_pair_1_02" );
}

warbird_strafe_01()
{
    var_0 = self;
}

shrike_takeoff( var_0, var_1 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "shrike_launch_hover" );
    wait 4.45;
    var_1 soundscripts\_snd_playsound::snd_play_linked( "shrike_launch_background" );
    wait 8;
    common_scripts\utility::flag_set( "useyourboosters_vo" );
}

shrike_flyby_pair_02( var_0, var_1 )
{
    var_1 soundscripts\_snd_common::snd_air_vehicle_smart_flyby( "shrike_flyby_pair_2_01", 7000 );
}

warbird_circling_perimeter()
{
    var_0 = self;
    var_0 _meth_828B();
}

attack_drone_audio_handler()
{
    if ( !isdefined( level.aud.mob_drone ) )
    {
        var_0 = 1;
        thread attack_drone_flybys_audio( var_0 );
    }
    else
    {
        var_0 = level.aud.mob_drone + 1;
        thread attack_drone_flybys_audio( var_0 );
    }

    level.aud.mob_drone = var_0;
}

attack_drone_flybys_audio( var_0 )
{
    var_1 = "mob_drone_flyby";
    var_2 = [];
    var_2[0] = 800;
    var_3 = [];
    var_3[0] = 20;
    var_3[1] = 5;
    thread soundscripts\_snd_common::snd_advanced_flyby_system( var_1, undefined, var_2, var_3, 1, undefined, undefined, 3, 2 );
}

jammer_plant()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "sfb_jammer_plant" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "sfb_jammer_plant", 0.72 );
    soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_jammer_beeps", 1.18 );
    wait 5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "sfb_jammer_plant" );
}

warbird_dropoff_01()
{
    var_0 = self;
    var_0 _meth_828B();
    var_0 soundscripts\_snd_playsound::snd_play_linked( "warbird_dropoff_02" );
    wait 3.0;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "warbird_dropoff_01_hover", undefined, undefined, undefined, undefined, ( 0, 500, 0 ) );
    var_0 waittill( "unloaded" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "warbird_depart_01_engine" );
}

warbird_dropoff_02()
{
    var_0 = self;
    var_0 _meth_828B();
    var_0 soundscripts\_snd_playsound::snd_play_linked( "warbird_dropoff_01" );
    var_0 waittill( "unloaded" );
    var_0 soundscripts\_snd_common::snd_air_vehicle_smart_flyby( "warbird_depart_01_current", 2000 );
}

shrike_flyby_03()
{
    var_0 = self;
    var_0 soundscripts\_snd_common::snd_air_vehicle_smart_flyby( "shrike_flyby_3_current", 3000 );
}

hangar_doors_open( var_0, var_1, var_2 )
{
    var_3 = var_0[0];
    var_4 = var_0[1];
    thread common_scripts\utility::play_sound_in_space( "sf_b_hangar_doors_start", var_2 );
    wait(var_1 - 0.16);
    thread common_scripts\utility::play_sound_in_space( "sf_b_hangar_doors_stop", var_3.origin );
    thread common_scripts\utility::play_sound_in_space( "sf_b_hangar_doors_stop", var_4.origin );
}

warbird_dropoff_03()
{
    var_0 = self;
    var_0 _meth_828B();
    var_0 soundscripts\_snd_playsound::snd_play_linked( "warbird_dropoff_04" );
    wait 3.0;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "warbird_dropoff_04_hover" );
    var_0 waittill( "unloaded" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "warbird_depart_04" );
}

warbird_dropoff_04()
{
    var_0 = self;
    var_0 _meth_828B();
    var_0 soundscripts\_snd_playsound::snd_play_linked( "warbird_dropoff_03" );
    wait 3.0;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "warbird_dropoff_03_hover" );
    var_0 waittill( "unloaded" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "warbird_depart_03" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "warbird_depart_03_engine" );
}

shrike_flyby_pair_04( var_0, var_1 )
{
    var_1 soundscripts\_snd_common::snd_air_vehicle_smart_flyby( "shrike_flyby_pair_4_01", 7500 );
}

enter_ship()
{
    soundscripts\_snd::snd_music_message( "enter_ship" );
}

if_the_boat_is_a_rockin_dont_come_a_knockin( var_0 )
{
    if ( var_0 == "interior" && soundscripts\_audio::aud_percent_chance( 66 ) )
        soundscripts\_snd_playsound::snd_play_2d( "sfb_metal_stress_interior" );
}

aud_burke_open_door()
{
    soundscripts\_snd::snd_music_message( "aud_burke_open_door" );
    soundscripts\_audio_mix_manager::mm_add_submix( "burke_rip_open_door", 0.05 );
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_burke_rip_open_door", 1.9 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_burke_rip_open_door_exo", 1.9 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_burke_rip_open_door_sweet", 5.9 );
    wait 15.8;
    soundscripts\_audio_mix_manager::mm_clear_submix( "burke_rip_open_door", 2.0 );
}

interior_door1_done()
{

}

aud_burke_takedown()
{
    level.aud.bump_music_for_burke_takedown = 1;
    soundscripts\_audio_mix_manager::mm_add_submix( "burke_takedown", 0.05 );
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_burke_takedown_exo", 0.6 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_burke_takedown_grab", 0.6 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_burke_takedown_shove", 1.2 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_burke_takedown_metal_accents", 1.1 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_burke_takedown_punch", 2.2 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_burke_takedown_punch02", 2.2 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_burke_takedown_fall", 2.9 );
    wait 4.3;
    soundscripts\_audio_mix_manager::mm_clear_submix( "burke_takedown", 2.0 );
}

power_outage_audio()
{
    soundscripts\_snd_playsound::snd_play_2d( "sfb_power_outage" );
}

aud_table_pulldown()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_guy_pulls_over_table", 0.5 );
}

pre_hangar_hall_explosion()
{
    soundscripts\_snd_playsound::snd_play_2d( "bomb_explo_shakes" );
}

enter_hangar()
{
    soundscripts\_snd::snd_music_message( "enter_hangar" );
}

shrike_hanger_flyby()
{
    var_0 = self;
    soundscripts\_audio_mix_manager::mm_add_submix( "shrike_hanger_flyby", 0.1 );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "shrike_flyby_hanger_jet" );
    wait 1.5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "shrike_hanger_flyby", 1.5 );
}

warbird_hanger_dropoff()
{
    var_0 = self;
    var_0 _meth_828B();
    wait 3.39;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "warbird_dropoff_hanger" );
    wait 2.05;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "warbird_dropoff_hanger_hover" );
    var_0 waittill( "unloaded" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "warbird_depart_hanger" );
}

littlebird_hanger_flyby()
{
    var_0 = self;
    var_0 _meth_828B();
    var_0 soundscripts\_snd_playsound::snd_play_linked( "littlebird_hanger_arrive" );
    wait 3;
    var_1 = soundscripts\_snd_playsound::snd_play_loop_linked( "littlebird_hanger_hover_lp", "littlebird_hanger_hover_stop", 1.15, 2 );
    level waittill( "littlebird_overwatch_advance" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "littlebird_hanger_advance" );
    level waittill( "flag_information_center" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "littlebird_hanger_depart" );
    wait 0.15;
    level notify( "littlebird_hanger_hover_stop" );
}

warbird_flyover_shootdown()
{
    var_0 = self;
    iprintlnbold( "START: warbird_flyover_shootdown" );
}

aud_hangar_door_exit()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "ship_hatch_open_mix", 2.0 );
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_ship_hatch_open", 1.2 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_ship_hatch_bounce", 3.7 );
    wait 8.5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "ship_hatch_open_mix", 2.0 );
}

handle_hatch_takedown_notetracks()
{
    maps\_anim::addnotetrack_customfunction( "cormack", "hatch_takedown_cormack_door", ::hatch_takedown_cormack_door, "door_takedown" );
    maps\_anim::addnotetrack_customfunction( "cormack", "hatch_takedown_cormack_punch", ::hatch_takedown_cormack_punch, "door_takedown" );
    maps\_anim::addnotetrack_customfunction( "guy", "hatch_takedown_bad_guy_punched", ::hatch_takedown_bad_guy_punched, "door_takedown" );
}

hatch_takedown_cormack_door( var_0 )
{
    var_1 = ( -8703, 66813, -1222 );
    soundscripts\_snd_playsound::snd_play_at( "sfb_hatch_takedown_door", var_1 );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "sfb_hatch_takedown_crmk_exo" );
}

hatch_takedown_cormack_punch( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "sfb_hatch_takedown_crmk_punch" );
}

hatch_takedown_bad_guy_punched( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "sfb_hatch_takedown_baddie_scream" );
}

aud_door_takedown_mix_handler()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "door_guy_takedown", 0.5 );
    soundscripts\_audio_zone_manager::azm_start_zone( "sf_b_int_nav_deck" );
    wait 5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "door_guy_takedown", 1 );
}

aud_door_takedown_scream()
{

}

enter_room_above_hangar()
{
    soundscripts\_snd::snd_music_message( "enter_room_above_hangar" );
}

enter_server_room()
{
    soundscripts\_snd::snd_music_message( "enter_server_room" );
}

enter_bridge()
{
    soundscripts\_snd::snd_music_message( "enter_bridge" );
}

cormack_shoots_bridge_guy()
{
    maps\_anim::addnotetrack_animsound( "guy", "guy_control_react", "sfb_bridge_foly_dead_guy_shot", "sfb_bridge_foly_dead_guy_shot" );
    maps\_anim::addnotetrack_animsound( "cormack", "control_room_pulloff", "sfb_bridge_foly_dead_guy_crmk_walk", "sfb_bridge_foly_dead_guy_crmk_walk" );
    maps\_anim::addnotetrack_animsound( "cormack", "control_room_pulloff", "sfb_bridge_foly_dead_guy_crmk_wipe", "sfb_bridge_foly_dead_guy_crmk_wipe" );
    maps\_anim::addnotetrack_animsound( "guy", "control_room_pulloff", "sfb_bridge_foly_dead_guy_drop", "sfb_bridge_foly_dead_guy_drop" );
}

start_camera_static()
{
    soundscripts\_snd_playsound::snd_play_2d( "sfb_camera_static_rail_gun" );
}

rail_gun_start()
{
    soundscripts\_snd::snd_music_message( "rail_gun_start" );
    soundscripts\_audio_mix_manager::mm_add_submix( "sfb_cargoship_destruct", 0.05 );
}

mob_audio_setup()
{
    if ( !isdefined( level.aud.mob_lat_move ) )
        level.aud.mob_lat_move = 0;

    if ( !isdefined( level.aud.mob_vert_move ) )
        level.aud.mob_vert_move = 0;

    thread mob_dismount_console();
}

mob_camera_static()
{
    soundscripts\_snd_playsound::snd_play_2d( "mob_camera_static" );
}

mob_xform()
{
    wait 0.6;
    soundscripts\_snd_playsound::snd_play_2d( "mob_xform" );
}

mob_turret_move( var_0 )
{
    switch ( var_0 )
    {
        case "lat_move":
            if ( level.aud.mob_lat_move == 0 )
            {
                level.aud.mob_lat_move = 1;
                level.player soundscripts\_snd_playsound::snd_play_loop_linked( "mob_lat_move_lp", "aud_mob_lat_stop" );
            }

            break;
        case "lat_stop":
            if ( level.aud.mob_lat_move == 1 )
            {
                level.aud.mob_lat_move = 0;
                level notify( "aud_mob_lat_stop" );
                level.player soundscripts\_snd_playsound::snd_play_linked( "mob_lat_stop" );
                earthquake( 0.15, 0.3, level.player.origin, 100 );
            }

            break;
        case "vert_move":
            if ( level.aud.mob_vert_move == 0 )
            {
                level.aud.mob_vert_move = 1;
                level.player soundscripts\_snd_playsound::snd_play_loop_linked( "mob_vert_move_lp", "aud_mob_vert_stop" );
            }

            break;
        case "vert_stop":
            if ( level.aud.mob_vert_move == 1 )
            {
                level.aud.mob_vert_move = 0;
                level notify( "aud_mob_vert_stop" );
                level.player soundscripts\_snd_playsound::snd_play_linked( "mob_vert_stop" );
            }

            break;
    }
}

mob_fire()
{
    soundscripts\_snd_playsound::snd_play_2d( "wpn_railgun_arclight_plr" );
}

mob_dismount_console()
{
    level.player waittill( "laser_off" );
    level notify( "aud_mob_vert_stop" );
    level notify( "aud_mob_lat_stop" );
}

sfb_end_logo()
{
    soundscripts\_snd_playsound::snd_play_2d( "sfb_end_logo" );
    soundscripts\_audio_mix_manager::mm_add_submix( "sfb_end_logo" );
}

shrike_railgun_flyby_01( var_0, var_1 )
{
    soundscripts\_snd_playsound::snd_play_2d( "shrike_flyby_railgun_1_jet" );
}

shrike_railgun_flyby_02( var_0, var_1 )
{
    soundscripts\_snd_playsound::snd_play_2d( "shrike_flyby_railgun_2_front" );
}

cargo_ship_hit_react( var_0 )
{
    if ( !isdefined( level.aud.cargo_ship_hit_count ) )
    {
        level.aud.cargo_ship_hit_count = 0;
        level.aud.cargo_ship_hit_aliases = [ "sfb_cargoship1_damage", "sfb_cargoship1_destroy", "sfb_cargoship2_damage", "sfb_cargoship2_destroy" ];
    }

    soundscripts\_snd_playsound::snd_play_2d( level.aud.cargo_ship_hit_aliases[level.aud.cargo_ship_hit_count] );
    level.aud.cargo_ship_hit_count++;
}

start_bridge_end_foley()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "bridge_end_foley" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "sfb_bridge_end_plyr_foly", 0.2 );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_bridge_end_brk_dist", 1.7 );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_bridge_end_brk_walk_up", 7.8 );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_bridge_end_brk_punch", 30.4 );
    level.cormack soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_bridge_end_crmk_point", 19.3 );
    level.cormack soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_bridge_end_crmk_away", 28.6 );
    level.maddox soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_bridge_end_mdx_up", 11.3 );
    level.maddox soundscripts\_snd_playsound::snd_play_delayed_linked( "sfb_bridge_end_mdx_away", 31.9 );
}

shrike_railgun_flyby_03( var_0, var_1 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "shrike_flyby_railgun_3_jet" );
}

rail_gun_done()
{
    soundscripts\_snd::snd_music_message( "rail_gun_done" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "sfb_cargoship_destruct", 0.05 );
    soundscripts\_audio_mix_manager::mm_add_submix( "bridge_end_foley" );
}

e3_demo_fade_out()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "mute_all", 3.0 );
}

e3_demo_fade_in()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "mute_all" );
    wait 0.05;
    soundscripts\_audio_mix_manager::mm_clear_submix( "mute_all", 2.0 );
}

point_source_dambs()
{
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "sf_b_fire_flareups", ( -7448, 66877, -1165 ), "fire_flareups_hall" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "sf_b_fire_flareups", ( -7580, 66731, -1168 ), "fire_flareups_mess_hall" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "sf_b_fire_flareups", ( -7605, 65714, -1190 ), "fire_flareups_extinguisher_hall" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "sf_b_fire_flareups", ( -7737, 67169, -1046 ), "fire_flareups_catwalk" );
}
