// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

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
    maps\mp\_compass::setupminimap( "compass_map_mp_highrise2" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level.ospvisionset = "mp_highrise2_osp";
    level.osplightset = "mp_highrise2_osp";
    level.dronevisionset = "mp_highrise2_drone";
    level.dronelightset = "mp_highrise2_drone";
    level.warbirdvisionset = "mp_highrise2_warbird";
    level.warbirdlightset = "mp_highrise2_warbird";
    setdvar( "sm_minSpotLightScore", 0.0005 );
    level thread droneanims();
    level thread resetuplinkballoutofbounds();
    level thread customairstrikeheight();
    level.orbitalsupportoverridefunc = ::custompaladinoverrides;
    level.orbitallaseroverridefunc = ::customlaserstreakfunc;
    level.pipes_use_simple_normal = 1;
    thread scriptinvalidcarepackagearea();

    if ( level.nextgen )
        thread scriptpatchclip();

    thread scriptpatchkilltrigger();
}

scriptpatchkilltrigger()
{
    thread spawnkilltriggerthink( ( 346, 6398, 3097 ), 108, 128 );
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
    if ( !isdefined( level.airstrikeoverrides ) )
        level.airstrikeoverrides = spawnstruct();

    level.airstrikeoverrides.spawnheight = 4700;
}

custompaladinoverrides()
{
    var_0 = maps\mp\killstreaks\_aerial_utility::gethelianchor();
    level.orbitalsupportoverrides.spawnorigin = var_0.origin;
    level.orbitalsupportoverrides.spawnheight = 10000;
    level.orbitalsupportoverrides.bottomarc = 60;
    level.orbitalsupportoverrides.leftarc = 35;
    level.orbitalsupportoverrides.rightarc = 35;
    level.orbitalsupportoverrides.toparc = -30;
    level.orbitalsupportoverrides.spawnradius = 6000;
}

customlaserstreakfunc()
{
    var_0 = maps\mp\killstreaks\_aerial_utility::gethelianchor();
    level.orbitallaseroverrides.spawnpoint = var_0.origin;
    level.orbitallaseroverrides.spawnheight = var_0.origin[2] - 3550;
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
        thread spawmdroneandanimate( "hr2_drone_lift_nocable_rig_01", "hr_drone_flight_01", ( 364, 16624, 2000 ), ( 0, 0, 0 ) );
        thread spawmdroneandanimate( "hr2_drone_lift_nocable_rig_01", "hr_drone_flight_01", ( -3124, -12888, 4434 ), ( 0, 0, 0 ) );
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
            var_1 thread watchcarryobjects();
    }
}

watchcarryobjects()
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
        if ( isoutofbounds() )
        {
            thread maps\mp\gametypes\_gameobjects::returnhome();
            return;
        }

        wait 0.05;
    }
}

isoutofbounds()
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
        var_3 = getnodesintrigger( var_2 );

        if ( !isdefined( level.goliath_bad_landing_nodes ) )
            level.goliath_bad_landing_nodes = [];

        if ( var_3.size > 0 )
        {
            foreach ( var_5 in var_3 )
                level.goliath_bad_landing_nodes[level.goliath_bad_landing_nodes.size] = var_5;
        }
    }

    var_8 = [];
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -448, 6620, 2888 ), 250, 0, 22 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -964, 6620, 2888 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -964, 7140, 2888 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -448, 7140, 2888 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -1404, 7140, 2888 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -1404, 6620, 2888 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -1620, 6498, 2888 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -1984, 6620, 2888 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -2240, 6620, 2888 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -2240, 7140, 2888 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_combine( var_8, getnodesinradius( ( -1876, 7140, 2888 ), 250, 0, 45 ) );
    var_8 = common_scripts\utility::array_remove_duplicates( var_8 );
    level.goliath_bad_landing_nodes = common_scripts\utility::array_combine( var_8, level.goliath_bad_landing_nodes );

    if ( level.goliath_bad_landing_nodes.size > 0 )
    {
        foreach ( var_5 in level.goliath_bad_landing_nodes )
            nodesetremotemissilename( var_5, "none" );
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
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1427, 6198, 2776 ), ( 270, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1301, 6198, 2776 ), ( 270, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1427, 6132, 2776 ), ( 270, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1301, 6132, 2776 ), ( 270, 0, 0 ) );
}

insideexecutiveofficethroughvent()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 438, 6072, 3104 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 438, 6136, 3104 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 438, 6200, 3104 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 438, 6264, 3104 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 438, 6328, 3104 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 438, 6392, 3104 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 438, 6456, 3104 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 438, 6520, 3104 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 438, 6584, 3104 ), ( 0, 0, 0 ) );
}

outsideexecutiveofficeledgestuck()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -2810, 5136, 2999 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -2810, 5158, 2999 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -2778, 5136, 2999 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( -2778, 5158, 2999 ), ( 0, 0, 0 ) );
}
