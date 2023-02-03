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
        self rotatevelocity( ( 0, var_1, 0 ), var_0 );
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

        self moveto( var_1.origin, var_0, var_0 * 0.1, var_0 * 0.1 );
        self rotateto( var_1.angles, var_0, var_0 * 0.1, var_0 * 0.1 );
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
    self setcandamage( 1 );
    self ghost();

    for (;;)
    {
        self.health = 1000;
        self waittill( "damage" );
        self playsound( "physics_bell_default" );
    }
}
