// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    level.callbackstartgametype = ::seoul2_callbackstartgametype;
    maps\mp\mp_seoul2_precache::main();
    maps\createart\mp_seoul2_art::main();
    maps\mp\mp_seoul2_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_seoul2_lighting::main();
    maps\mp\mp_seoul2_aud::main();
    maps\mp\_compass::_id_831E( "compass_map_mp_seoul2" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level._id_5985 = ::seoul2customkillstreakfunc;
    level thread seoul2customairstrikeheight();
    level thread setup_physics_objects();
    level thread setupsupportdropvolumes();
    level._id_655B = ::seoulcustomorbitallaserfunc;
    level._id_6573 = ::seoulcustomospfunc;
    level._id_65AB = "mp_seoul2_osp";
    level._id_65A9 = "mp_seoul2_osp";
    level._id_A197 = "mp_seoul2_osp";
    level._id_A18C = "mp_seoul2_osp";
    level._id_9F74 = "mp_seoul2_osp";
    level._id_9F73 = "mp_seoul2_osp";
    level._id_2F3B = "mp_seoul2_osp";
    level._id_2F12 = "mp_seoul2_osp";
    level.swarmvisionset = "mp_seoul2_osp";
    level.swarmlightset = "mp_seoul2_osp";

    if ( level.nextgen )
        level thread _id_2E21();
}

seoul2_callbackstartgametype()
{
    maps\mp\gametypes\_gamelogic::callback_startgametype();
    common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

setup_physics_objects()
{
    var_0 = getentarray( "physics_lanterns", "targetname" );
    var_1 = getentarray( "physics_alley_lights", "targetname" );

    foreach ( var_3 in var_1 )
        var_3 _meth_856C( 1 );

    foreach ( var_6 in var_0 )
        var_6 _meth_856C( 1 );
}

seoul2customkillstreakfunc()
{
    level thread maps\mp\killstreaks\streak_mp_seoul2::streak_init();
}

seoul2customairstrikeheight()
{
    if ( !isdefined( level._id_099D ) )
        level._id_099D = spawnstruct();

    level._id_099D._id_89DC = 5000;
    level._id_731E = 18000;
}

seoulcustomorbitallaserfunc()
{
    level._id_655C._id_89DC = 3000;
}

seoulcustomospfunc()
{
    level._id_6574._id_8A00 = 4500;
    level._id_6574._id_89DC = 8000;
    level._id_6574._id_0252 = 25;
    level._id_6574._id_0380 = 25;
    level._id_6574._id_04BD = -40;
    level._id_6574._id_0089 = 70;
}

setupsupportdropvolumes()
{
    var_0 = getent( "badplace_trigs", "targetname" );

    while ( !isdefined( level.orbital_util_covered_volumes ) )
        waitframe();

    level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_0;

    while ( !isdefined( level.goliath_bad_landing_volumes ) )
        waitframe();

    level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = var_0;
}

_id_2E21()
{
    var_0 = getent( "drone_cleaner_01", "targetname" );
    maps\mp\_audio::scriptmodelplayanimwithnotify_uniquename( var_0, "lost_repair_drone_standby_idle02", "drone_cleaner_01_notify", "aud_lost_drone_idle_02", "mp_seoul2_drone_idle_02", "aud_drone_01_end_01", "aud_drone_01_end_02", "aud_drone_01_end_03" );
    var_0 thread maps\mp\mp_seoul2_fx::play_drill_fx();
    var_1 = getent( "drone_cleaner_02", "targetname" );
    maps\mp\_audio::scriptmodelplayanimwithnotify_uniquename( var_1, "lost_repair_drone_standby_idle03", "drone_cleaner_02_notify", "aud_lost_drone_idle_03", "mp_seoul2_drone_idle_03", "aud_drone_02_end_01", "aud_drone_02_end_02", "aud_drone_02_end_03" );
    var_2 = getent( "drone_cleaner_03", "targetname" );
    maps\mp\_audio::scriptmodelplayanimwithnotify_uniquename( var_2, "lost_repair_drone_standby_idle03", "drone_cleaner_03_notify", "aud_lost_drone_idle_03", "mp_seoul2_drone_idle_03b", "aud_drone_03_end_01", "aud_drone_03_end_02", "aud_drone_03_end_03" );
}
