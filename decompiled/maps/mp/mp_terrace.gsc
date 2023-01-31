// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\mp_terrace_precache::main();
    maps\createart\mp_terrace_art::main();
    maps\mp\mp_terrace_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_terrace_lighting::main();
    maps\mp\mp_terrace_aud::main();
    maps\mp\_compass::setupminimap( "compass_map_mp_terrace" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level.allow_swimming = 0;
    level thread maps\mp\_water::init();
    level.aerial_pathnode_group_connect_dist = 400;
    level.mapcustomkillstreakfunc = ::terracecustomkillstreakfunc;
    level thread init_turbines();
    level thread init_blimps();
    level thread init_bells();
    level.orbitalsupportoverridefunc = ::terracecustomospfunc;
    level.ospvisionset = "mp_terrace_osp";
    level.osplightset = "mp_terrace_osp";
    level.dronevisionset = "mp_terrace_drone";
    level.dronelightset = "mp_terrace_drone";
    level.warbirdvisionset = "mp_terrace_warbird";
    level.warbirdlightset = "mp_terrace_warbird";
    terracefixup();
    level thread terracedisconnectnodes();
}

terracefixup()
{
    var_0 = spawn( "trigger_radius", ( -1016, 3232, -416 ), 0, 300, 128 );
    var_0.targetname = "out_of_bounds";
    var_0 = spawn( "trigger_radius", ( -1224, 3136, -488 ), 0, 300, 128 );
    var_0.targetname = "out_of_bounds";
    var_0 = spawn( "trigger_radius", ( -1360, 3000, -536 ), 0, 300, 128 );
    var_0.targetname = "out_of_bounds";
    var_0 = spawn( "trigger_radius", ( -1472, 2848, -800 ), 0, 300, 328 );
    var_0.targetname = "out_of_bounds";
    var_0 = spawn( "trigger_radius", ( -1672, 2624, -824 ), 0, 300, 328 );
    var_0.targetname = "out_of_bounds";
    var_0 = spawn( "trigger_radius", ( -1736, 2296, -696 ), 0, 300, 128 );
    var_0.targetname = "out_of_bounds";
    var_0 = spawn( "trigger_radius", ( -1944, 2032, -712 ), 0, 300, 128 );
    var_0.targetname = "out_of_bounds";
}

terracedisconnectnodes()
{
    var_0 = getnodesinradiussorted( ( -899.981, 2463.71, -40 ), 256, 0 )[0];
    var_1 = getnodesinradiussorted( ( -914.081, 2867.46, -288 ), 256, 0 )[0];
    disconnectnodepair( var_0, var_1 );
}

terracecustomospfunc()
{
    level.orbitalsupportoverrides.spawnanglemin = 180;
    level.orbitalsupportoverrides.spawnanglemax = 270;

    if ( level.currentgen )
    {
        level.orbitalsupportoverrides.leftarc = 17.5;
        level.orbitalsupportoverrides.rightarc = 17.5;
        level.orbitalsupportoverrides.toparc = -35;
        level.orbitalsupportoverrides.bottomarc = 60;
    }
}

terracecustomkillstreakfunc()
{
    level thread maps\mp\killstreaks\streak_mp_terrace::init();
}

init_turbines()
{
    var_0 = getentarray( "turbine_blades", "targetname" );
    common_scripts\utility::array_thread( var_0, ::turbine_spin );
}

turbine_spin()
{
    var_0 = 1800;
    var_1 = randomfloatrange( 30, 60 );

    for (;;)
    {
        self _meth_82BD( ( 0, var_1, 0 ), var_0 );
        wait(var_0);
    }
}

init_blimps()
{
    var_0 = getentarray( "blimp", "targetname" );
    common_scripts\utility::array_thread( var_0, ::blimp_run );
}

blimp_run()
{
    var_0 = 600;
    var_1 = self;

    while ( isdefined( var_1.target ) )
    {
        var_1 = common_scripts\utility::getstruct( var_1.target, "targetname" );

        if ( !isdefined( var_1 ) )
            return;

        self _meth_82AE( var_1.origin, var_0, var_0 * 0.1, var_0 * 0.1 );
        self _meth_82B5( var_1.angles, var_0, var_0 * 0.1, var_0 * 0.1 );
        wait(var_0);
    }
}

init_bells()
{
    var_0 = getentarray( "bell_collision", "targetname" );
    common_scripts\utility::array_thread( var_0, ::bell_run );
}

bell_run()
{
    self _meth_82C0( 1 );
    self _meth_8510();

    for (;;)
    {
        self.health = 1000;
        self waittill( "damage" );
        self playsound( "physics_bell_default" );
    }
}
