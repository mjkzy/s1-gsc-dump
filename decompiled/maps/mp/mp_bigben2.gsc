// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    level.callbackstartgametype = ::bigben2_callbackstartgametype;
    maps\mp\mp_bigben2_precache::main();
    maps\createart\mp_bigben2_art::main();
    maps\mp\mp_bigben2_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_bigben2_lighting::main();
    maps\mp\mp_bigben2_aud::main();
    _id_A75F::init();
    maps\mp\_compass::_id_831E( "compass_map_mp_bigben2" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level._id_65AB = "mp_bigben2_osp";
    level._id_65A9 = "mp_bigben2_osp";
    level._id_2F3B = "mp_bigben2_drone";
    level._id_2F12 = "mp_bigben2_drone";
    level._id_A197 = "mp_bigben2_warbird";
    level._id_A18C = "mp_bigben2_warbird";
    level._id_9F74 = "mp_bigben2_osp";
    level._id_9F73 = "mp_bigben2_osp";
    level._id_0A9D = 0;
    thread flickeringlights();
    level thread resetuplinkballoutofbounds();
    level._id_655B = ::bigben2vulcanoverrides;
    level._id_6573 = ::bigben2paladinoverrides;
    level._id_5985 = ::bigben2customkillstreakfunc;

    if ( level.nextgen )
        thread start_radar_animations();

    thread fixdroppedbomb();

    if ( level.nextgen )
        thread patch_clip_fixes();
    else
        thread resetuplinkballcg();

    if ( isdefined( level.gametype ) && ( level.gametype == "sd" || level.gametype == "sr" ) )
        level thread fix_b_bomb_site_killcam();
}

fix_b_bomb_site_killcam()
{
    while ( !isdefined( level.bombzones ) )
        waitframe();

    var_0 = getentarray( "bombzone", "targetname" );
    var_1 = getentarray( var_0[1].target, "targetname" );
    var_1[0].killcament.origin = ( 4236.0, 2260.0, 468.0 );
}

resetuplinkballcg()
{
    var_0 = spawn( "trigger_radius", ( 1878.0, 2636.0, 224.0 ), 0, 70, 50 );
    var_0.targetname = "out_of_bounds_at_rest";
    var_1 = spawn( "trigger_radius", ( 1856.0, 3926.0, 224.0 ), 0, 70, 50 );
    var_1.targetname = "out_of_bounds_at_rest";
}

bigben2customkillstreakfunc()
{
    level thread maps\mp\killstreaks\streak_mp_bigben2::init();
}

bigben2vulcanoverrides()
{
    level._id_655C.spawnpoint = ( 4000.0, 4000.0, 0.0 );
    level._id_655C._id_89DC = 3024;
}

bigben2paladinoverrides()
{
    level._id_6574._id_89DC = 9279;
    level._id_6574._id_8A00 = 8000;
    level._id_6574._id_8989 = 312;
}

bigben2_callbackstartgametype()
{
    maps\mp\gametypes\_gamelogic::callback_startgametype();
    common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

flickeringlights()
{
    var_0 = _func_231( "damaged", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( 0, 1 );

    var_4 = _func_231( "destroyed", "targetname" );

    foreach ( var_6 in var_4 )
        var_6 _meth_83F6( 0, 4 );
}

brokensigns()
{
    var_0 = _func_231( "sign_damaged", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( 0, 1 );
}

start_radar_animations()
{
    var_0 = getent( "radar_dish", "targetname" );
    var_1 = getent( "large_radar_stick_1", "targetname" );
    var_2 = getent( "radar_stick_1", "targetname" );
    var_3 = getent( "radar_stick_2", "targetname" );
    var_4 = getent( "radar_stick_3", "targetname" );
    var_5 = getent( "radar_stick_4", "targetname" );
    var_6 = getent( "radar_stick_5", "targetname" );
    var_0 scriptmodelplayanimdeltamotion( "bbn_radar_dish_01_idle" );
    var_1 scriptmodelplayanimdeltamotion( "bbn_radar_stick_02_idle" );
    var_2 scriptmodelplayanimdeltamotion( "bbn_radar_stick_02_idle" );
    wait 0.3;
    var_3 scriptmodelplayanimdeltamotion( "bbn_radar_stick_02_idle" );
    wait 1;
    var_4 scriptmodelplayanimdeltamotion( "bbn_radar_stick_02_idle" );
    wait 0.25;
    var_5 scriptmodelplayanimdeltamotion( "bbn_radar_stick_02_idle" );
    wait 0.45;
    var_6 scriptmodelplayanimdeltamotion( "bbn_radar_stick_02_idle" );
}

resetuplinkballoutofbounds()
{
    level endon( "game_ended" );

    if ( level.gametype == "ball" )
    {
        while ( !isdefined( level.balls ) )
            wait 0.05;

        foreach ( var_1 in level.balls )
            var_1 thread _id_A200();
    }
}

_id_A200()
{
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "dropped" );
        wait 0.1;
        thread monitorballstate();
        var_0 = common_scripts\utility::waittill_any_return( "pickup_object", "reset" );
    }
}

monitorballstate()
{
    self endon( "pickup_object" );
    self endon( "reset" );

    for (;;)
    {
        if ( _id_5168() )
        {
            thread maps\mp\gametypes\_gameobjects::returnhome();
            return;
        }

        wait 0.05;
    }
}

_id_5168()
{
    var_0 = getentarray( "object_out_of_bounds", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( !self.visuals[0] istouching( var_0[var_1] ) )
            continue;

        return 1;
    }

    if ( self.visuals[0].origin[2] <= 176 )
        return 1;

    return 0;
}

fixdroppedbomb()
{
    if ( level.gametype == "sd" )
    {
        while ( !isdefined( level.sdbomb ) )
            wait 0.05;

        level.sdbomb thread _id_A200();
    }
    else if ( level.gametype == "sr" )
    {
        while ( !isdefined( level.sdbomb ) )
            wait 0.05;

        level.sdbomb thread _id_A200();
    }
    else if ( level.gametype == "ball" )
    {
        while ( !isdefined( level.balls ) )
            wait 0.05;

        foreach ( var_1 in level.balls )
            var_1 thread _id_A200();
    }
    else if ( level.gametype == "ctf" )
    {
        while ( !isdefined( level.teamflags ) || !isdefined( level.teamflags[game["defenders"]] ) || !isdefined( level.teamflags[game["attackers"]] ) )
            wait 0.05;

        level.teamflags[game["defenders"]] thread _id_A200();
        level.teamflags[game["attackers"]] thread _id_A200();
    }
}

patch_clip_fixes()
{
    thread issue_17896();
    thread issue_17935();
    thread issue_17999();
    thread issue_18482();
    thread issue_18855();
    thread issue_17154();
    thread issue_18770();
    thread issue_18797();
    thread issue_18457();
    thread issue_17696();
    thread issue_18772();
    thread issue_13645();
    thread issue_18752();
    thread issue_13590();
    thread issue_18582();
    thread issue_16533();
    thread issue_19907();
    thread issue_20694();
    thread issue_20908();
    thread issue_20914();
    thread issue_16646();
    thread issue_22753();
    thread issue_23525();
    thread issue_23548();
    thread issue_23543();
    thread issue_23543_b();
    thread issue_23522();
    thread issue_23551();
    thread issue_14030();
    thread issue_23552();
    thread issue_25514();
    thread waterlanding_deathtriggertoohigh();
    thread anotherattempttofixmiddleledgeaft();
    thread anotherattempttofixmiddleledgeforward();
    thread radarantennagrappletotop();
    thread ticketinglampost();
    thread hoverintobow();
    thread sterngrappleoutmap();
}

sterngrappleoutmap()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1088.0, 2592.0, 272.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1088.0, 2592.0, 528.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1088.0, 2592.0, 784.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1088.0, 2848.0, 272.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1088.0, 2848.0, 528.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1088.0, 2848.0, 784.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1088.0, 3104.0, 272.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1088.0, 3104.0, 528.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1088.0, 3104.0, 784.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1088.0, 3360.0, 272.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1088.0, 3360.0, 528.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1088.0, 3360.0, 784.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1088.0, 3616.0, 272.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1088.0, 3616.0, 528.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1088.0, 3616.0, 784.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1088.0, 3872.0, 272.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1088.0, 3872.0, 528.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1088.0, 3872.0, 784.0 ), ( 0.0, 0.0, 0.0 ) );
}

hoverintobow()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5979.0, 3801.0, 219.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5979.0, 3929.0, 219.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5979.0, 3945.0, 219.0 ), ( 0.0, 0.0, 0.0 ) );
}

ticketinglampost()
{
    var_0 = 773;

    for ( var_1 = 0; var_1 < 12; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3108, 5321, var_0 ), ( 0.0, 0.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3108, 5320, var_0 ), ( 0.0, 0.0, 0.0 ) );
        var_0 += 128;
    }
}

radarantennagrappletotop()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3768.0, 2420.0, 986.0 ), ( 15.9999, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3803.0, 2420.0, 1109.0 ), ( 15.9999, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3838.0, 2420.0, 1232.0 ), ( 15.9999, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3873.0, 2420.0, 1355.0 ), ( 15.9999, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3908.0, 2420.0, 1478.0 ), ( 15.9999, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3943.0, 2420.0, 1601.0 ), ( 15.9999, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3978.0, 2420.0, 1724.0 ), ( 15.9999, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4013.0, 2420.0, 1847.0 ), ( 15.9999, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3733.0, 2420.0, 863.0 ), ( 15.9999, 0.0, 0.0 ) );
}

anotherattempttofixmiddleledgeforward()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3778.5, 2625.0, 1080.0 ), ( 0.0, 16.9995, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3778.5, 2625.0, 1336.0 ), ( 0.0, 16.9995, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3778.5, 2625.0, 1592.0 ), ( 0.0, 16.9995, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3747.0, 2728.0, 1080.0 ), ( 0.0, 16.9995, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3747.0, 2728.0, 1336.0 ), ( 0.0, 16.9995, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3747.0, 2728.0, 1592.0 ), ( 0.0, 16.9995, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3710.0, 2976.0, 1080.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3710.0, 2976.0, 1336.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3710.0, 2976.0, 1592.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3710.0, 3232.0, 1080.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3710.0, 3232.0, 1336.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3710.0, 3232.0, 1592.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3710.0, 3488.0, 1080.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3710.0, 3488.0, 1336.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3710.0, 3488.0, 1592.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3710.0, 3744.0, 1080.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3710.0, 3744.0, 1336.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3710.0, 3744.0, 1592.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3710.0, 4000.0, 1080.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3710.0, 4000.0, 1336.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3710.0, 4000.0, 1592.0 ), ( 0.0, 0.0, 0.0 ) );
}

anotherattempttofixmiddleledgeaft()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 2464.0, 1136.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 2464.0, 1392.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 2464.0, 1648.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 2720.0, 1136.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 2720.0, 1392.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 2720.0, 1648.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 2976.0, 1136.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 2976.0, 1392.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 2976.0, 1648.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 3232.0, 1136.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 3232.0, 1392.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 3232.0, 1648.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 3488.0, 1136.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 3488.0, 1392.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 3488.0, 1648.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 3744.0, 1136.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 3744.0, 1392.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 3744.0, 1648.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 4000.0, 1136.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 4000.0, 1392.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4256.0, 4000.0, 1648.0 ), ( 0.0, 0.0, 0.0 ) );
}

waterlanding_deathtriggertoohigh()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4379.0, 4740.0, 132.0 ), ( 0.0, 326.9, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3685.0, 4735.0, 132.0 ), ( 0.0, 302.3, 0.0 ) );
}

issue_17935()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_grapple_16_256_256", ( 6663.0, 5566.5, 335.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_grapple_16_256_256", ( 6919.5, 5566.5, 335.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_grapple_16_256_256", ( 7175.5, 5566.5, 335.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_grapple_16_256_256", ( 6663.0, 5566.5, 586.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_grapple_16_256_256", ( 6919.5, 5566.5, 586.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_grapple_16_256_256", ( 7175.5, 5566.5, 586.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 6656.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 6912.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 7168.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 6656.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 6912.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 7168.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 6656.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 6912.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 7168.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 7424.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 7424.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 7424.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 7680.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 7680.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 7680.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 7936.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 7936.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 7936.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 8192.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 8192.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 8192.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 8448.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 8448.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 8448.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 8704.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 8704.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 8704.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 8960.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 8960.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 8960.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 9216.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 9216.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 9216.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 9472.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 9472.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 9472.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 9728.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 9728.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 9728.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 9984.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 9984.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 9984.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 10240.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 10240.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 10240.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 10496.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 10496.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 10496.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 10752.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 10752.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 10752.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 11008.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 11008.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 11008.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 11264.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 11264.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 11264.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 11520.5, 5581.0, 337.5 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 11520.5, 5581.0, 593.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 11520.5, 5581.0, 849.5 ), ( 0.0, 270.0, 0.0 ) );
}

issue_17999()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5094.5, 4159.0, 878.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4966.5, 4159.0, 878.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4838.5, 4159.0, 878.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5094.5, 4159.0, 1005.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4966.5, 4159.0, 1005.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4838.5, 4159.0, 1005.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5094.5, 4159.0, 1133.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4966.5, 4159.0, 1133.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4838.5, 4159.0, 1133.5 ), ( 0.0, 0.0, 0.0 ) );
}

issue_17896()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 696.0, 3084.0, 604.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 696.0, 3212.0, 604.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 696.0, 3340.0, 604.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 696.0, 3084.0, 732.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 696.0, 3212.0, 732.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 696.0, 3340.0, 732.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 696.0, 3084.0, 860.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 696.0, 3212.0, 860.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 696.0, 3340.0, 860.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 440.0, 3084.0, 604.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 568.0, 3084.0, 604.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 440.0, 3084.0, 732.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 568.0, 3084.0, 732.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 440.0, 3084.0, 860.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 568.0, 3084.0, 860.0 ), ( 0.0, 0.0, 0.0 ) );
}

issue_18482()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 3863.5, 4380.5, 804.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 3847.5, 4380.5, 804.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 3863.5, 4380.5, 932.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 3847.5, 4380.5, 932.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 3863.5, 4380.5, 1060.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 3847.5, 4380.5, 1060.5 ), ( 0.0, 0.0, 0.0 ) );
}

issue_18855()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 6661.0, 5586.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 6661.0, 5602.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 6661.0, 5618.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 6917.0, 5586.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 6917.0, 5602.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 6917.0, 5618.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 7173.0, 5586.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 7173.0, 5602.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 7173.0, 5618.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 7429.0, 5586.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 7429.0, 5602.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 7429.0, 5618.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 7685.0, 5586.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 7685.0, 5602.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 7685.0, 5618.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 7941.0, 5586.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 7941.0, 5602.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 7941.0, 5618.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 8197.0, 5586.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 8197.0, 5602.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 8197.0, 5618.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 8453.0, 5586.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 8453.0, 5602.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 8453.0, 5618.5, 450.0 ), ( 0.0, 270.0, 0.0 ) );
}

issue_17154()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 4293.0, 3912.0, 1212.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 4293.0, 3912.0, 1340.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 4293.0, 3912.0, 1468.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 4293.0, 3912.0, 1596.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 4293.0, 3912.0, 1724.0 ), ( 0.0, 0.0, 0.0 ) );
}

issue_18770()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 2025.0, 3845.0, 558.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 2025.0, 3836.0, 558.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 2025.0, 3845.0, 526.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 2025.0, 3836.0, 526.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 2025.0, 3845.0, 494.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 2025.0, 3836.0, 494.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 2057.0, 3845.0, 590.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 2057.0, 3836.0, 590.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 2025.0, 3845.0, 590.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 2025.0, 3836.0, 590.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1998.0, 3845.0, 590.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1998.0, 3836.0, 590.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1998.0, 3845.0, 558.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1998.0, 3836.0, 558.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1998.0, 3845.0, 526.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1998.0, 3836.0, 526.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1998.0, 3845.0, 494.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1998.0, 3836.0, 494.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1998.0, 3836.0, 462.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1998.0, 3845.0, 462.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1973.7, 3845.0, 587.3 ), ( 343.4, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1973.7, 3836.0, 587.3 ), ( 343.4, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1982.9, 3845.0, 556.7 ), ( 343.4, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1982.9, 3836.0, 556.7 ), ( 343.3, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1992.0, 3845.0, 526.0 ), ( 343.3, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1992.0, 3836.0, 526.0 ), ( 343.3, 0.0, 0.0 ) );
}

issue_18797()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 2464.0, 4178.0, 327.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 2464.0, 4218.0, 327.5 ), ( 0.0, 0.0, 0.0 ) );
}

issue_18457()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2168.0, 5236.0, 352.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2168.0, 5236.0, 480.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2168.0, 5236.0, 608.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2168.0, 5236.0, 736.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2168.0, 5236.0, 864.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2168.0, 5236.0, 992.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2168.0, 5236.0, 1120.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2168.0, 5236.0, 1248.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2726.0, 5236.0, 352.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2726.0, 5236.0, 480.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2726.0, 5236.0, 608.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2726.0, 5236.0, 736.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2726.0, 5236.0, 864.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2726.0, 5236.0, 992.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2726.0, 5236.0, 1120.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2726.0, 5236.0, 1248.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5416.0, 5236.0, 352.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5416.0, 5236.0, 480.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5416.0, 5236.0, 608.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5416.0, 5236.0, 736.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5416.0, 5236.0, 864.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5416.0, 5236.0, 992.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5416.0, 5236.0, 1120.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5416.0, 5236.0, 1248.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5976.0, 5236.0, 352.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5976.0, 5236.0, 480.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5976.0, 5236.0, 608.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5976.0, 5236.0, 736.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5976.0, 5236.0, 864.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5976.0, 5236.0, 992.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5976.0, 5236.0, 1120.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5976.0, 5236.0, 1248.0 ), ( 0.0, 0.0, 0.0 ) );
}

issue_17696()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 5116.0, 5528.0, 1072.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 5116.0, 5528.0, 816.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 5116.0, 5528.0, 560.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 5116.0, 5528.0, 304.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 5328.0, 5528.0, 1072.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 5328.0, 5528.0, 816.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 5328.0, 5528.0, 560.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 5328.0, 5528.0, 304.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 5584.0, 5528.0, 1072.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 5584.0, 5528.0, 816.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 5584.0, 5528.0, 560.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 5584.0, 5528.0, 304.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 5840.0, 5528.0, 1072.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 5840.0, 5528.0, 816.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 5840.0, 5528.0, 560.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 5840.0, 5528.0, 304.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 6096.0, 5528.0, 1072.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 6096.0, 5528.0, 816.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 6096.0, 5528.0, 560.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 6096.0, 5528.0, 304.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 6228.0, 5448.0, 1072.0 ), ( 0.0, 180.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 6228.0, 5448.0, 816.0 ), ( 0.0, 180.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 6228.0, 5448.0, 560.0 ), ( 0.0, 180.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 6228.0, 5448.0, 304.0 ), ( 0.0, 180.0, 0.0 ) );
}

issue_18772()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 4844.0, 2518.0, 462.0 ), ( 0.0, 10.9998, 0.0 ) );
}

issue_13645()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 3686.0, 5387.0, 470.0 ), ( 360.0, 270.0, 9.89992 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 3798.0, 5387.0, 480.0 ), ( 0.0, 89.9999, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 4306.0, 5388.0, 480.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 4418.0, 5388.0, 470.0 ), ( 360.0, 89.9999, 9.9996 ) );
}

issue_18752()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 976.0, 2496.0, 392.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 976.0, 2496.0, 456.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 976.0, 2496.0, 520.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 976.0, 2496.0, 584.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 976.0, 2496.0, 648.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 976.0, 2496.0, 712.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 976.0, 2496.0, 776.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 976.0, 2496.0, 840.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 976.0, 2496.0, 904.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 976.0, 2496.0, 968.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 976.0, 2496.0, 1032.0 ), ( 0.0, 0.0, 0.0 ) );
}

issue_13590()
{
    var_0 = spawn( "trigger_radius", ( 5872.0, 2688.0, 556.0 ), 0, 73, 50 );
    var_0.targetname = "out_of_bounds";
    var_1 = spawn( "trigger_radius", ( 5876.0, 3873.0, 556.0 ), 0, 73, 50 );
    var_1.targetname = "out_of_bounds";
}

issue_18628()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3742.0, 2456.0, 990.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3742.0, 2456.0, 1118.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3742.0, 2456.0, 1246.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3788.0, 2816.0, 1036.0 ), ( 0.0, 20.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3788.0, 2816.0, 1164.0 ), ( 0.0, 20.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3788.0, 2816.0, 1292.0 ), ( 0.0, 20.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3788.0, 2816.0, 1420.0 ), ( 0.0, 20.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3788.0, 2816.0, 1548.0 ), ( 0.0, 20.0, 0.0 ) );
}

issue_18582()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2704.0, 4432.0, 288.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2832.0, 4432.0, 288.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2960.0, 4432.0, 288.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2704.0, 4304.0, 288.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2832.0, 4304.0, 288.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 2960.0, 4304.0, 288.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5392.0, 4432.0, 288.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5264.0, 4432.0, 288.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5136.0, 4432.0, 288.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5136.0, 4304.0, 288.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5264.0, 4304.0, 288.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 5392.0, 4304.0, 288.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4953.21, 4608.72, 286.304 ), ( 5.86831, 282.064, 1.25168 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4926.6, 4733.23, 299.391 ), ( 5.86831, 282.064, 1.25168 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4801.4, 4706.77, 296.609 ), ( 5.86831, 282.064, 1.25168 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4828.01, 4582.25, 283.522 ), ( 5.86831, 282.064, 1.25168 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3275.02, 4692.6, 303.4 ), ( 5.86833, 258.064, 1.25167 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3248.68, 4568.05, 290.3 ), ( 5.86833, 258.064, 1.25167 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3149.91, 4719.41, 300.6 ), ( 5.86833, 258.064, 1.25167 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3123.53, 4594.76, 287.5 ), ( 5.86833, 258.064, 1.25167 ) );
}

issue_16533()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 4464.0, 4296.0, 796.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 4464.0, 4283.0, 827.0 ), ( 0.0, 0.0, 45.9991 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 4464.0, 4237.0, 871.0 ), ( 0.0, 0.0, 45.9991 ) );
    var_0 = maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 3857.0, 4413.0, 692.0 ), ( 0.0, 0.0, 0.0 ) );
    var_1 = maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 3857.0, 4349.0, 692.0 ), ( 0.0, 0.0, 0.0 ) );
    var_2 = maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 3857.0, 4285.0, 692.0 ), ( 0.0, 0.0, 0.0 ) );
    var_3 = maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 3857.0, 4413.0, 756.0 ), ( 0.0, 0.0, 0.0 ) );
    var_4 = maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 3857.0, 4349.0, 756.0 ), ( 0.0, 0.0, 0.0 ) );
    var_5 = maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 3857.0, 4285.0, 756.0 ), ( 0.0, 0.0, 0.0 ) );
    var_0 _meth_8568( 0 );
    var_0 _meth_856C( 0 );
    var_1 _meth_8568( 0 );
    var_1 _meth_856C( 0 );
    var_2 _meth_8568( 0 );
    var_2 _meth_856C( 0 );
    var_3 _meth_8568( 0 );
    var_3 _meth_856C( 0 );
    var_4 _meth_8568( 0 );
    var_4 _meth_856C( 0 );
    var_5 _meth_8568( 0 );
    var_5 _meth_856C( 0 );
}

issue_19907()
{
    var_0 = maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 6040.0, 2720.0, 284.0 ), ( 0.0, 0.0, 0.0 ) );
    var_0 = maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 6040.0, 2720.0, 156.0 ), ( 0.0, 0.0, 0.0 ) );
    var_0 = maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 6040.0, 2592.0, 284.0 ), ( 0.0, 0.0, 0.0 ) );
    var_0 = maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 6040.0, 2592.0, 156.0 ), ( 0.0, 0.0, 0.0 ) );
    var_0 = maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 5968.14, 2513.89, 284.0 ), ( 0.0, 290.0, 0.0 ) );
    var_0 = maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 5968.14, 2513.89, 156.0 ), ( 0.0, 290.0, 0.0 ) );
    var_0 = maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 5847.86, 2470.11, 284.0 ), ( 0.0, 290.0, 0.0 ) );
    var_0 = maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 5847.86, 2470.11, 156.0 ), ( 0.0, 290.0, 0.0 ) );
}

issue_20694()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 2448.0, 4208.0, 328.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 2448.0, 4180.0, 328.0 ), ( 0.0, 0.0, 0.0 ) );
}

issue_20908()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3648.0, 5960.0, 1512.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3776.0, 5960.0, 1512.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3904.0, 5960.0, 1512.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4032.0, 5960.0, 1512.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4160.0, 5960.0, 1512.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4288.0, 5960.0, 1512.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4416.0, 5960.0, 1512.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4544.0, 5960.0, 1512.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3648.0, 5920.0, 1640.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3776.0, 5920.0, 1640.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3904.0, 5920.0, 1640.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4032.0, 5920.0, 1640.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4160.0, 5920.0, 1640.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4288.0, 5920.0, 1640.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4416.0, 5920.0, 1640.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4544.0, 5920.0, 1640.0 ), ( 0.0, 0.0, 0.0 ) );
}

issue_20914()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 3844.0, 3804.0, 912.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 3844.0, 3740.0, 912.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 3844.0, 3676.0, 912.0 ), ( 0.0, 0.0, 0.0 ) );
}

issue_18972()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3024.0, 1139.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3024.0, 1267.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3024.0, 1395.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3024.0, 1523.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3152.0, 1139.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3152.0, 1267.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3152.0, 1395.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3152.0, 1523.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3280.0, 1139.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3280.0, 1267.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3280.0, 1395.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3280.0, 1523.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3408.0, 1139.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3408.0, 1267.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3408.0, 1395.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3408.0, 1523.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3536.0, 1139.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3536.0, 1267.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3536.0, 1395.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 4261.0, 3536.0, 1523.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3536.0, 1031.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3536.0, 1159.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3536.0, 1287.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3536.0, 1415.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3408.0, 1031.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3408.0, 1159.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3408.0, 1287.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3408.0, 1415.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3280.0, 1031.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3280.0, 1159.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3280.0, 1287.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3280.0, 1415.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3152.0, 1031.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3152.0, 1159.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3152.0, 1287.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3152.0, 1415.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3024.0, 1031.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3024.0, 1159.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3024.0, 1287.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 3761.0, 3024.0, 1415.5 ), ( 0.0, 0.0, 0.0 ) );
}

issue_16646()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 976.0, 2496.0, 350.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 976.0, 2496.0, 414.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 976.0, 2496.0, 478.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 976.0, 2496.0, 542.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 976.0, 2496.0, 606.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 976.0, 2496.0, 670.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 976.0, 2496.0, 734.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 976.0, 2496.0, 798.0 ), ( 0.0, 0.0, 0.0 ) );
}

issue_17170()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 3724.0, 2450.0, 976.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 3724.0, 2450.0, 1040.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 3724.0, 2450.0, 1104.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 3724.0, 2450.0, 1168.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 3724.0, 2450.0, 1232.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 3724.0, 2450.0, 1296.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 3724.0, 2450.0, 1360.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 3724.0, 2450.0, 1424.0 ), ( 0.0, 0.0, 0.0 ) );
}

issue_22753()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 4688.0, 4232.0, 272.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 4644.0, 4232.0, 272.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 4516.0, 4232.0, 272.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 4388.0, 4232.0, 272.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 4260.0, 4232.0, 272.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 4132.0, 4232.0, 272.0 ), ( 0.0, 270.0, 0.0 ) );
}

issue_23525()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 6042.0, 2656.0, 224.0 ), ( 0.0, 0.0, 0.0 ) );
}

issue_23545()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 6042.0, 3898.0, 224.0 ), ( 0.0, 0.0, 0.0 ) );
}

issue_23548()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1338.0, 3853.0, 224.0 ), ( 0.0, 286.3, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1583.5, 3925.5, 224.0 ), ( 0.0, 286.3, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1829.0, 3997.5, 224.0 ), ( 0.0, 286.3, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 2074.5, 4070.0, 224.0 ), ( 0.0, 286.3, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 2320.0, 4142.5, 224.0 ), ( 0.0, 286.3, 0.0 ) );
}

issue_23543()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 4749.5, 4486.5, 522.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 4749.5, 4422.5, 522.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 4749.5, 4358.5, 522.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 4749.5, 4294.5, 522.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 4749.5, 4230.5, 522.5 ), ( 0.0, 0.0, 0.0 ) );
}

issue_23522()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 4749.5, 4230.5, 522.5 ), ( 0.0, 0.0, 0.0 ) );
}

issue_23551()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4576.0, 2130.0, 628.0 ), ( -10.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4200.0, 2130.0, 628.0 ), ( -10.0, 270.0, 0.0 ) );
}

issue_14030()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 4234.0, 4174.0, 1006.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 4170.0, 4174.0, 1006.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 4034.0, 4173.0, 1006.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 3970.0, 4173.0, 1006.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 3818.0, 4173.0, 1006.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 3754.0, 4173.0, 1006.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 3684.0, 4144.0, 1025.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 3687.0, 4052.0, 1003.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 3687.0, 3988.0, 1003.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 3687.0, 3895.0, 1024.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 3687.0, 3895.0, 1024.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 3728.0, 3572.0, 992.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 4229.0, 3376.0, 1104.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 3728.0, 3378.0, 992.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 4229.0, 3185.0, 1104.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 3728.0, 3192.0, 992.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 4230.0, 2992.0, 1104.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 3728.0, 2998.0, 992.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 3758.0, 2805.0, 992.0 ), ( 0.0, 18.4995, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 3820.0, 2617.0, 992.0 ), ( 0.0, 18.4995, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 3813.0, 2549.0, 1160.0 ), ( 0.0, 320.1, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 3816.0, 2356.0, 1160.0 ), ( 0.0, 226.2, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 4085.0, 2356.0, 1160.0 ), ( 0.0, 320.1, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 4090.0, 2546.0, 1160.0 ), ( 0.0, 226.2, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 3819.0, 2618.0, 1004.0 ), ( 0.0, 199.1, 0.0 ) );
}

issue_23543_b()
{
    var_0 = 864;

    for ( var_1 = 0; var_1 < 4; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3888, 4332, var_0 ), ( 0.0, 0.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3872, 4332, var_0 ), ( 0.0, 0.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3856, 4332, var_0 ), ( 0.0, 0.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3840, 4332, var_0 ), ( 0.0, 0.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 3824, 4332, var_0 ), ( 0.0, 0.0, 0.0 ) );
        var_0 += 256;
    }

    var_0 = 911;

    for ( var_1 = 0; var_1 < 4; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4469, 4163, var_0 ), ( 0.0, 0.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4453, 4163, var_0 ), ( 0.0, 0.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 4437, 4163, var_0 ), ( 0.0, 0.0, 0.0 ) );
        var_0 += 256;
    }

    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 4718.5, 4307.0, 420.0 ), ( 11.2, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 4718.5, 4381.0, 420.0 ), ( 11.2, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 4718.5, 4455.0, 420.0 ), ( 11.2, 0.0, 0.0 ) );
}

issue_23552()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 4111.5, 3737.0, 931.5 ), ( 350.3, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 4115.5, 3697.0, 906.0 ), ( 350.3, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 4111.5, 3697.0, 931.5 ), ( 350.3, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 4115.5, 3737.0, 906.0 ), ( 350.3, 0.0, 0.0 ) );
}

issue_25514()
{
    var_0 = 429;

    for ( var_1 = 0; var_1 < 20; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 4689, 4253.5, var_0 ), ( 0.0, 270.0, 0.0 ) );
        var_0 += 64;
    }
}
