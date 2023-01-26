// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_A77C::main();
    _id_A6EC::main();
    _id_A77B::main();
    maps\mp\_load::main();
    maps\mp\mp_venus_lighting::main();
    maps\mp\mp_venus_aud::main();
    level._id_088B = 600;
    level._id_088A = 300;
    level._id_088D[0] = spawnstruct();
    level._id_088D[0].origin = ( -618.0, -1166.0, 1123.0 );
    level._id_088D[0].radius = 250;
    level._id_088D[1] = spawnstruct();
    level._id_088D[1].origin = ( -944.0, 845.0, 1245.0 );
    level._id_088D[1].radius = 300;
    maps\mp\_compass::_id_831E( "compass_map_mp_venus" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    _id_A75F::init();
    level._id_65AB = "mp_venus_osp";
    level._id_A197 = "mp_venus_osp";
    level._id_9F74 = "mp_venus_osp";
    var_0 = getnodearray( "pool_nodes", "targetname" );

    foreach ( var_2 in var_0 )
        _func_2C0( var_2, 1 );

    level._id_6573 = ::_id_9D7D;
    thread venuscustomairstrike();
    thread _id_458C();
    level.goliath_bad_landing_volumes = getentarray( "goliath_bad_landing_volume", "targetname" );
}

venuscustomairstrike()
{
    if ( !isdefined( level._id_099D ) )
        level._id_099D = spawnstruct();

    level._id_099D._id_89DC = 2100;
}

_id_9D7D()
{
    level._id_6574._id_04BD = -39;
    level._id_6574._id_89DC = 9563.06;

    if ( level.currentgen )
    {
        level._id_6574._id_0252 = 20;
        level._id_6574._id_0380 = 20;
        level._id_6574._id_04BD = -35;
        level._id_6574._id_0089 = 60;
    }
}

_id_458C()
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
                var_8._id_421A = var_5;
                break;
            }
        }
    }

    common_scripts\utility::array_thread( var_1, ::_id_45D4 );
}

_id_45D4()
{
    level endon( "game_ended" );
    var_0 = getent( self.target, "targetname" );

    if ( !isdefined( var_0 ) )
        return 0;

    var_0 common_scripts\utility::trigger_off();
    var_0 connectpaths();
    _id_A089( self._id_421A );
    var_0 common_scripts\utility::trigger_on();
    var_0 disconnectpaths();
    var_0 common_scripts\utility::trigger_off();
}

_id_A089( var_0 )
{
    level endon( "game_ended" );

    for (;;)
    {
        if ( isglassdestroyed( var_0 ) )
            return 1;

        wait 0.05;
    }
}
