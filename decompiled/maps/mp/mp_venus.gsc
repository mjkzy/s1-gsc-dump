// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\mp_venus_precache::main();
    maps\createart\mp_venus_art::main();
    maps\mp\mp_venus_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_venus_lighting::main();
    maps\mp\mp_venus_aud::main();
    level.aerial_pathnode_offset = 600;
    level.aerial_pathnode_group_connect_dist = 300;
    level.aerial_pathnodes_force_connect[0] = spawnstruct();
    level.aerial_pathnodes_force_connect[0].origin = ( -618, -1166, 1123 );
    level.aerial_pathnodes_force_connect[0].radius = 250;
    level.aerial_pathnodes_force_connect[1] = spawnstruct();
    level.aerial_pathnodes_force_connect[1].origin = ( -944, 845, 1245 );
    level.aerial_pathnodes_force_connect[1].radius = 300;
    maps\mp\_compass::setupminimap( "compass_map_mp_venus" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    maps\mp\_water::init();
    level.ospvisionset = "mp_venus_osp";
    level.warbirdvisionset = "mp_venus_osp";
    level.vulcanvisionset = "mp_venus_osp";
    var_0 = getnodearray( "pool_nodes", "targetname" );

    foreach ( var_2 in var_0 )
        nodesetnotusable( var_2, 1 );

    level.orbitalsupportoverridefunc = ::venuscustomospfunc;
    thread venuscustomairstrike();
    thread handle_glass_pathing();
    level.goliath_bad_landing_volumes = getentarray( "goliath_bad_landing_volume", "targetname" );
}

venuscustomairstrike()
{
    if ( !isdefined( level.airstrikeoverrides ) )
        level.airstrikeoverrides = spawnstruct();

    level.airstrikeoverrides.spawnheight = 2100;
}

venuscustomospfunc()
{
    level.orbitalsupportoverrides.toparc = -39;
    level.orbitalsupportoverrides.spawnheight = 9563.06;

    if ( level.currentgen )
    {
        level.orbitalsupportoverrides.leftarc = 20;
        level.orbitalsupportoverrides.rightarc = 20;
        level.orbitalsupportoverrides.toparc = -35;
        level.orbitalsupportoverrides.bottomarc = 60;
    }
}

handle_glass_pathing()
{
    var_0 = getglassarray( "skylights" );
    var_1 = getentarray( "skylights", "targetname" );
    var_2 = getentarray( "glass_pathing", "targetname" );

    if ( !isdefined( var_1 ) )
        return 0;

    var_3 = 8;

    foreach ( var_5 in var_0 )
    {
        var_6 = getglassorigin( var_5 );

        foreach ( var_8 in var_1 )
        {
            if ( distance( var_6, var_8.origin ) <= var_3 )
            {
                var_8.glass_id = var_5;
                break;
            }
        }
    }

    common_scripts\utility::array_thread( var_1, ::handle_pathing_on_glass );
}

handle_pathing_on_glass()
{
    level endon( "game_ended" );
    var_0 = getent( self.target, "targetname" );

    if ( !isdefined( var_0 ) )
        return 0;

    var_0 common_scripts\utility::trigger_off();
    var_0 connectpaths();
    waittill_glass_break( self.glass_id );
    var_0 common_scripts\utility::trigger_on();
    var_0 disconnectpaths();
    var_0 common_scripts\utility::trigger_off();
}

waittill_glass_break( var_0 )
{
    level endon( "game_ended" );

    for (;;)
    {
        if ( isglassdestroyed( var_0 ) )
            return 1;

        wait 0.05;
    }
}
