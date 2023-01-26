// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    level.callbackstartgametype = ::highrise2_callbackstartgametype;
    common_scripts\_mp_pipes::main();
    maps\mp\mp_highrise2_precache::main();
    maps\createart\mp_highrise2_art::main();
    maps\mp\mp_highrise2_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_highrise2_lighting::main();
    maps\mp\mp_highrise2_aud::main();
    maps\mp\_compass::_id_831E( "compass_map_mp_highrise2" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level._id_65AB = "mp_highrise2_osp";
    level._id_65A9 = "mp_highrise2_osp";
    level._id_2F3B = "mp_highrise2_drone";
    level._id_2F12 = "mp_highrise2_drone";
    level._id_A197 = "mp_highrise2_warbird";
    level._id_A18C = "mp_highrise2_warbird";
    setdvar( "sm_minSpotLightScore", 0.0005 );
    level thread droneanims();
    level thread resetuplinkballoutofbounds();
    level thread customairstrikeheight();
    level._id_6573 = ::custompaladinoverrides;
    level._id_655B = ::customlaserstreakfunc;
    level.pipes_use_simple_normal = 1;
    thread scriptinvalidcarepackagearea();

    if ( level.nextgen )
        thread scriptpatchclip();

    thread scriptpatchkilltrigger();
}

scriptpatchkilltrigger()
{
    thread spawnkilltriggerthink( ( 346.0, 6398.0, 3097.0 ), 108, 128 );
}

spawnkilltriggerthink( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    var_3 = spawn( "trigger_radius", var_0, 0, var_1, var_2 );

    if ( !isdefined( var_3 ) )
        return;

    for (;;)
    {
        var_3 waittill( "trigger", var_4 );

        if ( isdefined( var_4 ) && isplayer( var_4 ) && isdefined( var_4.health ) )
            var_4 dodamage( var_4.health + 999, var_3.origin );
    }
}

highrise2_callbackstartgametype()
{
    maps\mp\gametypes\_gamelogic::callback_startgametype();
    common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

customairstrikeheight()
{
    if ( !isdefined( level._id_099D ) )
        level._id_099D = spawnstruct();

    level._id_099D._id_89DC = 4700;
}

custompaladinoverrides()
{
    var_0 = maps\mp\killstreaks\_aerial_utility::_id_3FC1();
    level._id_6574._id_89F2 = var_0.origin;
    level._id_6574._id_89DC = 10000;
    level._id_6574._id_0089 = 60;
    level._id_6574._id_0252 = 35;
    level._id_6574._id_0380 = 35;
    level._id_6574._id_04BD = -30;
    level._id_6574._id_8A00 = 6000;
}

customlaserstreakfunc()
{
    var_0 = maps\mp\killstreaks\_aerial_utility::_id_3FC1();
    level._id_655C.spawnpoint = var_0.origin;
    level._id_655C._id_89DC = var_0.origin[2] - 3550;
}

droneanims()
{
    var_0 = getentarray( "drone_lift_animated", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = "hr_drone_idle_01";

        if ( isdefined( var_2.script_parameters ) )
            var_3 = var_2.script_parameters;

        var_2 thread animatedrone( var_3 );
    }

    if ( level.nextgen )
    {
        thread spawmdroneandanimate( "hr2_drone_lift_nocable_rig_01", "hr_drone_flight_01", ( 364.0, 16624.0, 2000.0 ), ( 0.0, 0.0, 0.0 ) );
        thread spawmdroneandanimate( "hr2_drone_lift_nocable_rig_01", "hr_drone_flight_01", ( -3124.0, -12888.0, 4434.0 ), ( 0.0, 0.0, 0.0 ) );
    }
}

animatedrone( var_0 )
{
    wait 0.05;
    self scriptmodelplayanim( var_0 );
    playfxontag( common_scripts\utility::getfx( "mp_hr2_drone_lightbeam" ), self, "tag_light" );
    waitframe();
    playfxontag( common_scripts\utility::getfx( "mp_hr2_drone_prop_wind" ), self, "tag_light" );
    waitframe();
}

spawmdroneandanimate( var_0, var_1, var_2, var_3 )
{
    var_4 = spawn( "script_model", var_2 );
    var_4 setmodel( var_0 );
    var_4.angles = var_3;
    wait 0.05;
    var_4 scriptmodelplayanim( var_1 );
    playfxontag( common_scripts\utility::getfx( "mp_hr2_drone_lightbeam" ), var_4, "tag_light" );
    waitframe();
    playfxontag( common_scripts\utility::getfx( "mp_hr2_drone_prop_wind" ), var_4, "tag_light" );
    waitframe();
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

    if ( isdefined( var_0 ) )
    {
        for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        {
            if ( !self.visuals[0] istouching( var_0[var_1] ) )
                continue;

            return 1;
        }
    }

    return 0;
}

scriptinvalidcarepackagearea()
{
    var_0 = getentarray( "orbital_node_covered", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( level.goliath_bad_landing_volumes ) )
            level.goliath_bad_landing_volumes = [];

        level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = var_2;
        var_3 = _func_1FE( var_2 );

        if ( !isdefined( level.goliath_bad_landing_nodes ) )
            level.goliath_bad_landing_nodes = [];

        if ( var_3.size > 0 )
        {
            foreach ( var_5 in var_3 )
                level.goliath_bad_landing_nodes[level.goliath_bad_landing_nodes.size] = var_5;
        }
    }

    var_8 = [];
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -448.0, 6620.0, 2888.0 ), 250, 0, 22 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -964.0, 6620.0, 2888.0 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -964.0, 7140.0, 2888.0 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -448.0, 7140.0, 2888.0 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -1404.0, 7140.0, 2888.0 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -1404.0, 6620.0, 2888.0 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -1620.0, 6498.0, 2888.0 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -1984.0, 6620.0, 2888.0 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -2240.0, 6620.0, 2888.0 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -2240.0, 7140.0, 2888.0 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -1876.0, 7140.0, 2888.0 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_remove_duplicates( var_8 );
    level.goliath_bad_landing_nodes = common_scripts\utility::array_combine( var_8, level.goliath_bad_landing_nodes );

    if ( level.goliath_bad_landing_nodes.size > 0 )
    {
        foreach ( var_5 in level.goliath_bad_landing_nodes )
            _func_2D6( var_5, "none" );
    }
}

scriptpatchclip()
{
    thread outsideexecutiveofficeledgestuck();
    thread insideexecutiveofficethroughvent();
    thread cratejumpthroughceiling();
}

cratejumpthroughceiling()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1427.0, 6198.0, 2776.0 ), ( 270.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1301.0, 6198.0, 2776.0 ), ( 270.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1427.0, 6132.0, 2776.0 ), ( 270.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1301.0, 6132.0, 2776.0 ), ( 270.0, 0.0, 0.0 ) );
}

insideexecutiveofficethroughvent()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 438.0, 6072.0, 3104.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 438.0, 6136.0, 3104.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 438.0, 6200.0, 3104.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 438.0, 6264.0, 3104.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 438.0, 6328.0, 3104.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 438.0, 6392.0, 3104.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 438.0, 6456.0, 3104.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 438.0, 6520.0, 3104.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 438.0, 6584.0, 3104.0 ), ( 0.0, 0.0, 0.0 ) );
}

outsideexecutiveofficeledgestuck()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -2810.0, 5136.0, 2999.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -2810.0, 5158.0, 2999.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -2778.0, 5136.0, 2999.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -2778.0, 5158.0, 2999.0 ), ( 0.0, 0.0, 0.0 ) );
}
