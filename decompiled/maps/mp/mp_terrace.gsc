// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_A77A::main();
    _id_A6E9::main();
    _id_A779::main();
    maps\mp\_load::main();
    maps\mp\mp_terrace_lighting::main();
    maps\mp\mp_terrace_aud::main();
    maps\mp\_compass::_id_831E( "compass_map_mp_terrace" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level._id_0A9D = 0;
    level thread _id_A75F::init();
    level._id_088A = 400;
    level._id_5985 = ::_id_9291;
    level thread _id_4D6B();
    level thread _id_4CB7();
    level thread _id_4CB6();
    level._id_6573 = ::_id_9292;
    level._id_65AB = "mp_terrace_osp";
    level._id_65A9 = "mp_terrace_osp";
    level._id_2F3B = "mp_terrace_drone";
    level._id_2F12 = "mp_terrace_drone";
    level._id_A197 = "mp_terrace_warbird";
    level._id_A18C = "mp_terrace_warbird";
}

_id_9292()
{
    level._id_6574._id_898B = 180;
    level._id_6574._id_898A = 270;

    if ( level.currentgen )
    {
        level._id_6574._id_0252 = 17.5;
        level._id_6574._id_0380 = 17.5;
        level._id_6574._id_04BD = -35;
        level._id_6574._id_0089 = 60;
    }
}

_id_9291()
{
    level thread _id_A7DA::init();
}

_id_4D6B()
{
    var_0 = getentarray( "turbine_blades", "targetname" );
    common_scripts\utility::array_thread( var_0, ::_id_98EE );
}

_id_98EE()
{
    var_0 = 1800;
    var_1 = randomfloatrange( 30, 60 );

    for (;;)
    {
        self rotatevelocity( ( 0, var_1, 0 ), var_0 );
        wait(var_0);
    }
}

_id_4CB7()
{
    var_0 = getentarray( "blimp", "targetname" );
    common_scripts\utility::array_thread( var_0, ::_id_14A9 );
}

_id_14A9()
{
    var_0 = 600;
    var_1 = self;

    while ( isdefined( var_1.target ) )
    {
        var_1 = common_scripts\utility::getstruct( var_1.target, "targetname" );

        if ( !isdefined( var_1 ) )
            return;

        self moveto( var_1.origin, var_0, var_0 * 0.1, var_0 * 0.1 );
        self _meth_82B5( var_1.angles, var_0, var_0 * 0.1, var_0 * 0.1 );
        wait(var_0);
    }
}

_id_4CB6()
{
    var_0 = getentarray( "bell_collision", "targetname" );
    common_scripts\utility::array_thread( var_0, ::_id_13AC );
}

_id_13AC()
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
