// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_A776::main();
    _id_A6E3::main();
    maps\mp\mp_refraction_lighting::main();
    _id_A775::main();
    level._id_088B = 600;
    level._id_088A = 300;
    level._id_65AB = "mp_refraction_osp";
    level._id_65A9 = "mp_refraction_osp";
    level._id_A197 = "mp_refraction_osp";
    level._id_A18C = "mp_refraction_osp";
    level._id_9F74 = "mp_refraction_osp";
    level._id_9F73 = "mp_refraction_osp";
    maps\mp\_load::main();
    level._id_09BE = loadfx( "vfx/lights/light_red_pulse_fast" );
    level._id_70EF = loadfx( "vfx/rain/rain_volume_windy" );
    level thread common_scripts\_exploder::_id_06F5( 10 );
    _id_A75F::init();
    maps\mp\_compass::_id_831E( "compass_map_mp_refraction" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    thread _id_7E66();
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level._id_5985 = ::_id_72B8;
    level._id_6573 = ::_id_72B9;
    level._id_731E = 16000;
    level._id_655B = ::_id_72BB;
    thread scriptpatchclip();
    thread scriptpatchdisconnectnodes();
    common_scripts\utility::array_thread( getentarray( "com_radar_dish", "targetname" ), ::_id_70AB );
}

scriptpatchclip()
{
    thread lockingpiececlip();
}

scriptpatchdisconnectnodes()
{
    thread whitneybuildingnodes();
    thread overgapcenternodes01();
}

whitneybuildingnodes()
{
    findpairnodeanddisconnect( ( 2554.5, -700.0, 2286.0 ) );
    findpairnodeanddisconnect( ( 2778.0, -886.0, 2204.0 ) );
}

overgapcenternodes01()
{
    findpairnodeanddisconnect( ( -289.1, -1157.1, 2000.0 ) );
}

findpairnodeanddisconnect( var_0 )
{
    var_1 = getnodesinradius( var_0, 64, 0, 72, "Begin" );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3.target ) )
        {
            var_4 = getnode( var_3.target, "targetname" );

            if ( isdefined( var_4 ) && isdefined( var_3 ) )
                disconnectnodepair( var_3, var_4 );
        }
    }
}

lockingpiececlip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( 110.0, -180.0, 2565.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( 110.0, -180.0, 2693.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( 110.0, -180.0, 2821.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( 110.0, -180.0, 2874.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( 38.0, -180.0, 2930.0 ), ( 90.0, 0.0, 180.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( -38.0, -180.0, 2930.0 ), ( 90.0, 0.0, 180.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( -110.0, -180.0, 2874.0 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( -110.0, -180.0, 2821.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( -110.0, -180.0, 2693.5 ), ( 0.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( -110.0, -180.0, 2565.5 ), ( 0.0, 0.0, 0.0 ) );
}

_id_72B8()
{
    level._id_53AB["refraction_turret_mp"] = 1;
    level thread _id_A7D8::init();
}

_id_72B9()
{
    level._id_6574._id_898B = 260;
    level._id_6574._id_898A = 350;
    level._id_6574._id_99B1 = 50;
    level._id_6574._id_04BD = -38;
    level._id_6574._id_89DC = 10426;
}

_id_72BB()
{
    level._id_655C.spawnpoint = ( 20.0, -500.0, 0.0 );
}

_id_70AB()
{
    var_0 = 0;
    var_1 = 40000;
    var_2 = 1.0;

    if ( isdefined( self._id_03E3 ) )
        var_2 = self._id_03E3;

    var_0 = 70;

    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "lockedspeed" )
        wait 0;
    else
        wait(randomfloatrange( 0, 1 ));

    for (;;)
    {
        self rotatevelocity( ( 0, var_0, 0 ), var_1 );
        wait(var_1);
    }
}

_id_7E66()
{
    if ( _func_235() )
    {
        for (;;)
        {
            level waittill( "connected", var_0 );
            var_0 setclientdvars( "r_tonemap", "1" );
        }
    }
}
