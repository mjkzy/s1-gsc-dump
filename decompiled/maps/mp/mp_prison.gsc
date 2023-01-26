// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_A770::main();
    _id_A6DA::main();
    _id_A76F::main();
    maps\mp\mp_prison_lighting::main();
    maps\mp\_load::main();
    maps\mp\_compass::_id_831E( "compass_map_mp_prison" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level._id_5985 = ::_id_6FC6;
    level._id_6573 = ::_id_6FC9;
    thread goliathvolumes();
    level._id_2F3B = "mp_instinct_osp";
    level._id_2F12 = "mp_prison_drone";
    thread _id_0B4C();
}

goliathvolumes()
{
    level.goliath_bad_landing_volumes = getentarray( "goliath_bad_landing_volume", "targetname" );
}

_id_6FC6()
{
    level thread _id_A7D6::init();
}

_id_7E66()
{
    if ( _func_235() )
    {
        for (;;)
        {
            level waittill( "connected", var_0 );
            var_0 setclientdvars( "r_tonemap", "1", "r_tonemapLockAutoExposureAdjust", "0", "r_tonemapAutoExposureAdjust", "0" );
        }
    }
}

_id_6FC9()
{
    level._id_6574._id_89DC = 7500;
    level._id_6574._id_8A00 = 4500;
    level._id_6574._id_0252 = 40;
    level._id_6574._id_0380 = 40;
    level._id_6574._id_04BD = -38;
    level._id_6574._id_0089 = 78;
}

_id_0B4C()
{
    var_0 = getentarray( "guard_tower_radar", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread _id_7601();
}

_id_7601()
{
    if ( !isdefined( level._id_7604 ) )
        level._id_7604 = 20;

    for (;;)
    {
        self rotatevelocity( ( 0.0, -100.0, 0.0 ), level._id_7604 );
        wait(level._id_7604);
    }
}

_id_8330()
{
    precachelocationselector( "map_artillery_selector" );
    precachestring( &"KILLSTREAKS_MP_PRISON" );
    precacheitem( "mp_prison_gas" );
    level._id_3C1A = "mp_prison_gas";
    level._id_3C14 = "mp_prison_gas_on_siren";
    level._id_3C48 = "gate_sparks";
    level._effect[level._id_3C48] = loadfx( "vfx/sparks/electrical_sparks_oneshot" );
    var_0 = getentarray( "gas_trigger", "targetname" );
    thread _id_3C1C();

    if ( var_0.size > 0 )
    {
        precacheshellshock( "mp_prison_gas" );

        foreach ( var_2 in var_0 )
            var_2 thread common_scripts\_dynamic_world::triggertouchthink( ::_id_6C99, ::_id_6CDB );

        thread onplayerconnect();
    }

    thread _id_3C2F();
    thread _id_8314();
    thread _id_5EB5();
}

_id_5EB5()
{
    level endon( "debug_mp_prison_gas" );
    level._id_2FE9 = 3;
    var_0 = 2;
    var_1 = maps\mp\_utility::gettimelimit();
    var_2 = gettime() + var_0 * 1000;
    var_3 = var_1 / level._id_2FE9 * 60 * 1000;

    for ( var_4 = 1; var_4 < level._id_2FE9; var_4++ )
    {
        if ( var_1 > 0 )
            var_2 = gettime() + var_3;
        else
            var_2 = gettime() + var_0 * 1000;

        while ( gettime() < var_2 )
            wait 1;

        _id_8D35();
    }
}

_id_8D35()
{
    var_0 = 20;
    thread _id_3C31();
    thread _id_5F4F();
    thread _id_75FA();
    thread _id_75FB();
    thread _id_3C13();
    wait 5;
    thread _id_3C30();
    thread _id_0F2C();
    _id_3C1D();
    wait(var_0);
    level notify( "stop_gas_sfx" );
    thread _id_7447();
    thread _id_7457();
    thread _id_7456();
    thread _id_3C12();
    _id_3C1C();
}

_id_0F2C()
{
    var_0 = ( -2666.0, 1305.0, 828.0 );
    var_1 = ( -2282.0, 1305.0, 840.0 );
    var_2 = ( -2026.0, 1305.0, 840.0 );
    var_3 = ( -1557.0, 1305.0, 840.0 );
    var_4 = ( -1512.0, 903.0, 840.0 );
    var_5 = ( -2024.0, 903.0, 840.0 );
    var_6 = ( -2411.0, 903.0, 840.0 );
    var_7 = ( -2666.0, 903.0, 840.0 );
    var_8 = [ var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 ];

    foreach ( var_10 in var_8 )
    {
        thread maps\mp\_audio::_id_8730( "mp_prison_gas_valve_start", var_10 );
        thread maps\mp\_audio::_id_873B( "mp_prison_gas_lp", var_10, "stop_gas_sfx", 2.2 );
    }
}

_id_3C13()
{
    var_0 = spawn( "script_origin", ( -2143.0, 1108.0, 946.0 ) );
    var_0 playsound( "mp_prison_gas_on" );
}

_id_3C12()
{
    var_0 = spawn( "script_origin", ( -2143.0, 1108.0, 946.0 ) );
    var_0 playsound( "mp_prison_gas_off_02" );
}

_id_3C2F()
{
    if ( !isdefined( level._id_5FC4 ) )
        level._id_5FC4 = spawnstruct();

    if ( !isdefined( level._id_5FC4._id_3C17 ) )
    {
        var_0 = common_scripts\utility::getstructarray( "gas_org", "targetname" );
        level._id_5FC4._id_3C17 = [];

        foreach ( var_2 in var_0 )
        {
            var_3 = var_2 common_scripts\utility::spawn_tag_origin();
            var_3 show();
            level._id_5FC4._id_3C17[level._id_5FC4._id_3C17.size] = var_3;
        }
    }

    if ( !isdefined( level._id_5FC4._id_3C18 ) )
    {
        var_0 = common_scripts\utility::getstructarray( "flashing_red_light", "targetname" );
        level._id_5FC4._id_3C18 = [];

        foreach ( var_2 in var_0 )
        {
            var_3 = var_2 common_scripts\utility::spawn_tag_origin();
            var_3 show();
            level._id_5FC4._id_3C18[level._id_5FC4._id_3C18.size] = var_3;
        }
    }
}

_id_3C31()
{
    foreach ( var_1 in level._id_5FC4._id_3C18 )
        var_1 thread _id_6DC1();

    _func_222( 10 );
}

_id_8314()
{
    var_0 = getentarray( "moving_gate", "targetname" );
    level._id_5FC4._id_3C5A = [];

    foreach ( var_2 in var_0 )
    {
        var_3 = spawnstruct();
        var_2._id_65A1 = var_2.origin;
        var_3._id_3C32 = var_2;
        var_4 = common_scripts\utility::getstruct( var_2.target, "targetname" );
        var_3._id_28BA = var_4;
        var_5 = getent( var_4.target, "targetname" );
        var_5._id_65A1 = var_5.origin;
        var_3._id_202E = var_5;
        var_6 = common_scripts\utility::getstruct( var_5.target, "targetname" );
        var_7 = var_6 common_scripts\utility::spawn_tag_origin();
        var_7 show();
        var_7 linkto( var_2 );
        var_8 = common_scripts\utility::getstruct( var_6.target, "targetname" );
        var_9 = var_8 common_scripts\utility::spawn_tag_origin();
        var_9 show();
        var_9 linkto( var_2 );
        var_3._id_88B5 = [ var_7, var_9 ];
        level._id_5FC4._id_3C5A[level._id_5FC4._id_3C5A.size] = var_3;
    }

    var_0 = getentarray( "rotating_gate", "targetname" );
    level._id_5FC4._id_7608 = [];

    foreach ( var_2 in var_0 )
    {
        var_3 = spawnstruct();
        var_2._id_65A1 = var_2.origin;
        var_2._id_65A2 = var_2.angles;
        var_3._id_3C32 = var_2;
        var_4 = common_scripts\utility::getstruct( var_2.target, "targetname" );
        var_3._id_28BA = var_4;
        var_5 = getent( var_4.target, "targetname" );
        var_5._id_65A1 = var_5.origin;
        var_5.angles = var_2.angles + ( 0.0, -90.0, 0.0 );
        var_5._id_65A2 = var_5.angles;
        var_3._id_202E = var_5;
        var_6 = common_scripts\utility::getstruct( var_5.target, "targetname" );
        var_7 = var_6 common_scripts\utility::spawn_tag_origin();
        var_7 show();
        var_7 linkto( var_2 );
        var_8 = common_scripts\utility::getstruct( var_6.target, "targetname" );
        var_9 = var_8 common_scripts\utility::spawn_tag_origin();
        var_9 show();
        var_9 linkto( var_2 );
        var_3._id_88B5 = [ var_7, var_9 ];

        if ( isdefined( var_8.target ) )
        {
            var_12 = getent( var_8.target, "targetname" );
            var_3._id_533E = var_12;
            var_3._id_533E common_scripts\utility::trigger_off_proc();
        }

        level._id_5FC4._id_7608[level._id_5FC4._id_7608.size] = var_3;
    }

    var_0 = getentarray( "rotating_gate_constant", "targetname" );
    level._id_5FC4._id_7607 = [];

    foreach ( var_2 in var_0 )
    {
        var_3 = spawnstruct();
        var_2._id_65A1 = var_2.origin;
        var_2._id_65A2 = var_2.angles;
        var_3._id_3C32 = var_2;
        var_4 = common_scripts\utility::getstruct( var_2.target, "targetname" );
        var_3._id_28BA = var_4;
        var_6 = common_scripts\utility::getstruct( var_4.target, "targetname" );

        if ( !isdefined( var_6 ) )
            continue;

        var_7 = var_6 common_scripts\utility::spawn_tag_origin();
        var_7 show();
        var_7 linkto( var_2 );
        var_8 = common_scripts\utility::getstruct( var_6.target, "targetname" );

        if ( !isdefined( var_8 ) )
        {
            var_7 delete();
            continue;
        }

        var_9 = var_8 common_scripts\utility::spawn_tag_origin();
        var_9 show();
        var_9 linkto( var_2 );
        var_3._id_88B5 = [ var_7, var_9 ];
        level._id_5FC4._id_7607[level._id_5FC4._id_7607.size] = var_3;
    }
}

_id_5F4F()
{
    var_0 = 0.5;

    foreach ( var_2 in level._id_5FC4._id_3C5A )
    {
        var_2._id_3C32 moveto( var_2._id_28BA.origin, var_0, 0.1, 0.2 );
        var_2._id_202E moveto( var_2._id_28BA.origin, var_0, 0.1, 0.2 );
        var_2 thread _id_1753( var_0 );
    }
}

_id_75FA()
{
    var_0 = 0.5;

    foreach ( var_2 in level._id_5FC4._id_7608 )
    {
        var_2 thread _id_3C56();
        var_2._id_3C32 moveto( var_2._id_28BA.origin, var_0, 0.1, 0.2 );
        var_2._id_3C32 _meth_82B5( var_2._id_28BA.angles, var_0, 0.1, 0.2 );
        var_2._id_202E _meth_82B5( var_2._id_28BA.angles - ( 0.0, 90.0, 0.0 ), var_0, 0.1, 0.2 );
        var_2._id_202E moveto( var_2._id_28BA.origin, var_0, 0.1, 0.2 );
    }

    wait(var_0);

    foreach ( var_2 in level._id_5FC4._id_7608 )
        var_2 thread _id_3C55();
}

_id_75FB()
{
    foreach ( var_1 in level._id_5FC4._id_7607 )
        var_1 thread _id_75F9();
}

_id_75F9()
{
    self endon( "stop_bounce" );

    for (;;)
    {
        var_0 = randomfloatrange( 0.1, 0.5 );
        thread _id_3C56();
        self._id_3C32 moveto( self._id_28BA.origin, var_0, 0.05, 0.05 );
        self._id_3C32 _meth_82B5( self._id_28BA.angles, var_0, 0.05, 0.05 );
        wait(var_0);
        self._id_3C32 moveto( self._id_3C32._id_65A1, var_0, 0.05, 0.05 );
        self._id_3C32 _meth_82B5( self._id_3C32._id_65A2, var_0, 0.05, 0.05 );
        thread _id_3C55();
        wait(randomfloatrange( 0.1, 1 ));
    }
}

_id_7456()
{
    var_0 = 0.5;

    foreach ( var_2 in level._id_5FC4._id_7607 )
        var_2 notify( "stop_bounce" );

    wait 0.5;

    foreach ( var_2 in level._id_5FC4._id_7607 )
    {
        var_2 thread _id_3C56();
        var_2._id_3C32 moveto( var_2._id_3C32._id_65A1, var_0, 0.05, 0.05 );
        var_2._id_3C32 _meth_82B5( var_2._id_3C32._id_65A2, var_0, 0.05, 0.05 );
    }

    wait(var_0);

    foreach ( var_2 in level._id_5FC4._id_7607 )
        var_2 thread _id_3C55();
}

_id_7457()
{
    var_0 = 0.5;

    foreach ( var_2 in level._id_5FC4._id_7608 )
    {
        var_2 thread _id_3C56();

        if ( isdefined( var_2._id_533E ) )
            var_2._id_533E common_scripts\utility::trigger_on_proc();

        var_2._id_3C32 moveto( var_2._id_3C32._id_65A1, var_0, 0.1, 0.2 );
        var_2._id_3C32 _meth_82B5( var_2._id_3C32._id_65A2, var_0, 0.1, 0.2 );
        var_2._id_202E _meth_82B5( var_2._id_202E._id_65A2, var_0, 0.1, 0.2 );
        var_2._id_202E moveto( var_2._id_202E._id_65A1, var_0, 0.1, 0.2 );
    }

    wait(var_0);

    foreach ( var_2 in level._id_5FC4._id_7608 )
    {
        if ( isdefined( var_2._id_533E ) )
            var_2._id_533E common_scripts\utility::trigger_off_proc();

        var_2 thread _id_3C55();
    }
}

_id_7447()
{
    var_0 = 0.5;

    foreach ( var_2 in level._id_5FC4._id_3C5A )
        var_2 notify( "stop_bounce" );

    wait 0.5;

    foreach ( var_2 in level._id_5FC4._id_3C5A )
    {
        var_2 thread _id_3C56();
        var_2._id_3C32 moveto( var_2._id_3C32._id_65A1, var_0, 0.1, 0.2 );
        var_2._id_202E moveto( var_2._id_202E._id_65A1, var_0, 0.1, 0.2 );
    }

    wait(var_0);

    foreach ( var_2 in level._id_5FC4._id_3C5A )
        var_2 thread _id_3C55();
}

_id_1753( var_0 )
{
    self endon( "stop_bounce" );
    thread _id_3C56();
    wait(var_0);
    thread _id_3C55();
    var_1 = anglestoforward( vectortoangles( self._id_28BA.origin - self._id_3C32._id_65A1 ) );
    var_2 = var_1 * 2;

    for (;;)
    {
        var_3 = randomfloatrange( 0.1, 0.5 );
        var_4 = randomfloatrange( 0.1, 0.5 );
        thread _id_3C56();
        self._id_3C32 moveto( self._id_3C32.origin + var_2, var_3, 0.05, 0.05 );
        wait(var_3);
        self._id_3C32 moveto( self._id_28BA.origin, var_4, 0.05, 0.05 );
        wait(var_4);
        thread _id_3C55();
        wait(randomfloat( 2 ));
    }
}

_id_3C56()
{
    self endon( "stop_sparks" );

    for (;;)
    {
        foreach ( var_1 in self._id_88B5 )
            playfxontag( common_scripts\utility::getfx( level._id_3C48 ), var_1, "tag_origin" );

        wait(randomfloatrange( 0.5, 1.0 ));
    }
}

_id_3C55()
{
    self notify( "stop_sparks" );

    foreach ( var_1 in self._id_88B5 )
        stopfxontag( common_scripts\utility::getfx( level._id_3C48 ), var_1, "tag_origin" );
}

_id_3C30()
{
    _func_222( 20 );
}

_id_3C2E()
{

}

_id_6DC1()
{
    wait 3.5;
    thread maps\mp\_utility::playsoundinspace( level._id_3C14, self.origin );
}

onplayerconnect()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0._id_628C = 0;
    }
}

_id_6C99( var_0 )
{
    self._id_628C++;

    if ( self._id_628C == 1 )
        _id_3C1B();
}

_id_6CDB( var_0 )
{
    self._id_628C--;

    if ( self._id_628C != 0 )
        return;

    self.poison = 0;
    self notify( "leftTrigger" );

    if ( isdefined( self._id_3C29 ) )
        self._id_3C29 _id_35F4( 0.1, 0 );
}

_id_3C1D()
{
    var_0 = getentarray( "gas_trigger", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 common_scripts\utility::trigger_on();
}

_id_3C1C()
{
    var_0 = getentarray( "gas_trigger", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 common_scripts\utility::trigger_off();
}

_id_88AB( var_0 )
{
    common_scripts\utility::waittill_any( "death", "leftTrigger" );
    self stoploopsound();
}

_id_3C1B()
{
    self endon( "disconnect" );
    self endon( "game_ended" );
    self endon( "death" );
    self endon( "leftTrigger" );
    self.poison = 0;
    thread _id_88AB( self );

    for (;;)
    {
        self.poison++;

        switch ( self.poison )
        {
            case 1:
                self _meth_81AF( 1, self.origin );
                break;
            case 3:
                self shellshock( "mp_prison_gas", 4 );
                self _meth_81AF( 3, self.origin );
                _id_2CBF( 25 );
                break;
            case 4:
                self shellshock( "mp_prison_gas", 5 );
                self _meth_81AF( 15, self.origin );
                thread _id_148C();
                _id_2CBF( 45 );
                break;
            case 6:
                self shellshock( "mp_prison_gas", 5 );
                self _meth_81AF( 75, self.origin );
                _id_2CBF( 80 );
                break;
            case 8:
                self shellshock( "mp_prison_gas", 5 );
                self _meth_81AF( 127, self.origin );
                _id_2CBF( 175 );
                break;
        }

        wait 1;
    }

    wait 5;
}

_id_148C()
{
    self endon( "disconnect" );
    self endon( "game_ended" );
    self endon( "death" );
    self endon( "leftTrigger" );

    if ( !isdefined( self._id_3C29 ) )
    {
        self._id_3C29 = newclienthudelem( self );
        self._id_3C29.x = 0;
        self._id_3C29.y = 0;
        self._id_3C29 setshader( "black", 640, 480 );
        self._id_3C29.alignx = "left";
        self._id_3C29.aligny = "top";
        self._id_3C29.horzalign = "fullscreen";
        self._id_3C29.vertalign = "fullscreen";
        self._id_3C29.alpha = 0;
    }

    var_0 = 1;
    var_1 = 2;
    var_2 = 0.25;
    var_3 = 1;
    var_4 = 5;
    var_5 = 100;
    var_6 = 0;

    for (;;)
    {
        while ( self.poison > 1 )
        {
            var_7 = var_5 - var_4;
            var_6 = ( self.poison - var_4 ) / var_7;

            if ( var_6 < 0 )
                var_6 = 0;
            else if ( var_6 > 1 )
                var_6 = 1;

            var_8 = var_1 - var_0;
            var_9 = var_0 + var_8 * ( 1 - var_6 );
            var_10 = var_3 - var_2;
            var_11 = var_2 + var_10 * var_6;
            var_12 = var_6 * 0.5;

            if ( var_6 == 1 )
                break;

            var_13 = var_9 / 2;
            self._id_3C29 _id_35EF( var_13, var_11 );
            self._id_3C29 _id_35F4( var_13, var_12 );
            wait(var_6 * 0.5);
        }

        if ( var_6 == 1 )
            break;

        if ( self._id_3C29.alpha != 0 )
            self._id_3C29 _id_35F4( 1, 0 );

        wait 0.05;
    }

    self._id_3C29 _id_35EF( 2, 0 );
}

_id_2CBF( var_0 )
{
    self thread [[ level.callbackplayerdamage ]]( self, self, var_0, 0, "MOD_SUICIDE", "mp_prison_gas", self.origin, ( 0.0, 0.0, 0.0 ) - self.origin, "none", 0 );
}

_id_35EF( var_0, var_1 )
{
    self fadeovertime( var_0 );
    self.alpha = var_1;
    wait(var_0);
}

_id_35F4( var_0, var_1 )
{
    self fadeovertime( var_0 );
    self.alpha = var_1;
    wait(var_0);
}
