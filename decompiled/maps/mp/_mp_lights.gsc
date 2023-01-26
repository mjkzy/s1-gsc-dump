// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    if ( !isdefined( level._id_8FC2 ) )
        level._id_8FC2 = getdvarint( "sm_sunenable", 1 );

    if ( !isdefined( level._id_8FD6 ) )
        level._id_8FD6 = getdvarfloat( "sm_sunshadowscale", 1.0 );

    if ( !isdefined( level._id_8A89 ) )
        level._id_8A89 = getdvarint( "sm_spotlimit", 4 );

    if ( !isdefined( level._id_8FD5 ) )
        level._id_8FD5 = getdvarfloat( "sm_sunsamplesizenear", 0.25 );

    if ( !isdefined( level._id_7080 ) )
        level._id_7080 = getdvarfloat( "sm_qualityspotshadow", 1.0 );

    thread _id_5EA7();

    if ( !isdefined( level._id_05E0 ) )
    {
        level._id_05E0 = spawnstruct();
        _id_570C();
        _id_5704();
    }

    var_0 = getentarray( "trigger_multiple_light_sunshadow", "classname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        level thread _id_8FB6( var_0[var_1] );
}

_id_7EB4( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_0 ) )
        level._id_8FC2 = var_0;

    if ( isdefined( var_1 ) )
        level._id_8FD6 = var_1;

    if ( isdefined( var_2 ) )
        level._id_8A89 = var_2;

    if ( isdefined( var_3 ) )
        level._id_8FD5 = var_3;

    if ( isdefined( var_4 ) )
        level._id_7080 = var_4;
}

_id_5EA7()
{
    if ( isdefined( level.players ) )
    {
        foreach ( var_1 in level.players )
            var_1 _id_4DF8();
    }

    for (;;)
    {
        level waittill( "connected", var_1 );
        var_1 _id_4DF8();
        var_1 thread _id_5E3F();
    }
}

_id_4DF8()
{
    self._id_8FC2 = level._id_8FC2;
    self._id_8FD6 = level._id_8FD6;
    self._id_8A89 = level._id_8A89;
    self._id_8FD5 = level._id_8FD5;
    self._id_7080 = level._id_7080;
    self setclientdvars( "sm_sunenable", self._id_8FC2, "sm_sunshadowscale", self._id_8FD6, "sm_spotlimit", self._id_8A89, "sm_qualityspotshadow", self._id_7080, "sm_sunSampleSizeNear", self._id_8FD5 );
}

_id_5E3F()
{
    self waittill( "spawned" );
    _id_4DF8();
}

_id_8FB6( var_0 )
{
    var_1 = 1;

    if ( isdefined( var_0._id_79AF ) )
        var_1 = var_0._id_79AF;

    for (;;)
    {
        var_0 waittill( "trigger", var_2 );
        var_0 _id_7EC5( var_1, var_2 );
    }
}

_id_7EC5( var_0, var_1 )
{
    var_2 = var_1._id_8FC2;
    var_3 = var_1._id_8FD6;
    var_4 = var_1._id_8A89;
    var_5 = var_1._id_8FD5;
    var_6 = var_1._id_7080;

    if ( isdefined( self._id_7AE1 ) )
        var_2 = self._id_7AE1;

    if ( isdefined( self._id_7AE3 ) )
        var_3 = self._id_7AE3;

    if ( isdefined( self._id_7ACF ) )
        var_4 = self._id_7ACF;

    if ( isdefined( self._id_7AE2 ) )
        var_5 = self._id_7AE2;

    var_5 = min( max( 0.016, var_5 ), 32 );

    if ( isdefined( self._id_7AAB ) )
        var_6 = self._id_7AAB;

    var_1 setclientdvars( "sm_sunenable", var_2, "sm_sunshadowscale", var_3, "sm_spotlimit", var_4, "sm_qualityspotshadow", var_6 );
    var_1._id_8FC2 = var_2;
    var_1._id_8FD6 = var_3;
    var_1._id_8A89 = var_4;
    var_7 = var_1._id_8FD5;
    var_1._id_8FD5 = var_5;
    var_1._id_7080 = var_6;
    thread _id_56A4( var_5, var_7, var_0, var_1 );
}

_id_56A4( var_0, var_1, var_2, var_3 )
{
    level notify( "changing_sunsamplesizenear" + var_3.name );
    level endon( "changing_sunsamplesizenear" + var_3.name );

    if ( var_0 == var_1 )
        return;

    var_4 = var_0 - var_1;
    var_5 = 0.1;
    var_6 = var_2 / var_5;

    if ( var_6 > 0 )
    {
        var_7 = var_4 / var_6;
        var_8 = var_1;

        for ( var_9 = 0; var_9 < var_6; var_9++ )
        {
            var_8 += var_7;
            var_3 setclientdvar( "sm_sunSampleSizeNear", var_8 );
            var_3._id_8FD5 = var_8;
            wait(var_5);
        }
    }

    var_3 setclientdvar( "sm_sunSampleSizeNear", var_0 );
    var_3._id_8FD5 = var_0;
}

_id_570C()
{
    _id_23B4( "fire", ( 0.972549, 0.62451, 0.345098 ), ( 0.2, 0.146275, 0.0878432 ), 0.005, 0.2, 8 );
    _id_23B4( "blue_fire", ( 0.445098, 0.62451, 0.972549 ), ( 0.05, 0.150451, 0.307843 ), 0.005, 0.2, 8 );
    _id_23B4( "white_fire", ( 0.972549, 0.972549, 0.972549 ), ( 0.2, 0.2, 0.2 ), 0.005, 0.2, 8 );
    _id_23B4( "pulse", ( 0.0, 0.0, 0.0 ), ( 255.0, 107.0, 107.0 ), 0.2, 1, 8 );
    _id_23B4( "lightbulb", ( 0.972549, 0.62451, 0.345098 ), ( 0.2, 0.146275, 0.0878432 ), 0.005, 0.2, 6 );
    _id_23B4( "fluorescent", ( 0.972549, 0.62451, 0.345098 ), ( 0.2, 0.146275, 0.0878432 ), 0.005, 0.2, 7 );
    _id_23B4( "static_screen", ( 0.63, 0.72, 0.92 ), ( 0.4, 0.43, 0.48 ), 0.005, 0.2, 7 );
}

_id_23B4( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( level._id_05E0._id_38D2 ) )
        level._id_05E0._id_38D2 = [];

    var_6 = spawnstruct();
    var_6._id_2044 = var_1;
    var_6._id_2046 = var_2;
    var_6._id_5C3F = var_3;
    var_6._id_5A29 = var_4;
    var_6._id_4E9B = var_5;
    level._id_05E0._id_38D2[var_0] = var_6;
}

_id_3D70( var_0 )
{
    if ( isdefined( level._id_05E0._id_38D2 ) && isdefined( level._id_05E0._id_38D2[var_0] ) )
        return level._id_05E0._id_38D2[var_0];

    return undefined;
}

_id_6948( var_0, var_1, var_2 )
{
    var_3 = getent( var_1, "targetname" );

    if ( !isdefined( var_3 ) )
        return;

    var_4 = _id_3D70( var_0 );

    if ( !isdefined( var_4 ) )
        return;

    if ( isdefined( var_2 ) )
    {
        if ( var_2 < 0 )
            var_2 = 0;

        var_4._id_4E9B = var_2;
    }

    var_3 _meth_81DF( var_4._id_4E9B );
    var_3._id_5144 = 1;
    var_3._id_5145 = 0;
    var_3 thread _id_2FD6( var_4._id_2044, var_4._id_2046, var_4._id_5C3F, var_4._id_5A29 );
    return var_3;
}

_id_8E85( var_0, var_1, var_2 )
{
    var_3 = getent( var_1, "targetname" );

    if ( !isdefined( var_3 ) )
        return;

    if ( !isdefined( var_3._id_5144 ) )
        return;

    if ( isdefined( var_2 ) )
    {
        if ( var_2 < 0 )
            var_2 = 0;
    }

    var_3 _meth_81DF( var_2 );
    var_3 notify( "kill_flicker" );
    var_3._id_5144 = undefined;
}

_id_6719( var_0, var_1 )
{
    var_2 = getent( var_1, "targetname" );

    if ( !isdefined( var_2 ) )
        return;

    if ( !isdefined( var_2._id_5144 ) )
        return;

    var_2._id_5145 = 1;
}

_id_9A4E( var_0, var_1 )
{
    var_2 = getent( var_1, "targetname" );

    if ( !isdefined( var_2 ) )
        return;

    if ( !isdefined( var_2._id_5144 ) )
        return;

    var_2._id_5145 = 0;
}

_id_2FD6( var_0, var_1, var_2, var_3 )
{
    self endon( "kill_flicker" );
    var_4 = var_0;
    var_5 = 0.0;

    for (;;)
    {
        if ( self._id_5145 )
        {
            wait 0.05;
            continue;
        }

        var_6 = var_4;
        var_4 = var_0 + ( var_1 - var_0 ) * randomfloat( 1.0 );

        if ( var_2 != var_3 )
            var_5 += randomfloatrange( var_2, var_3 );
        else
            var_5 += var_2;

        if ( var_5 == 0 )
            var_5 += 0.0000001;

        for ( var_7 = ( var_6 - var_4 ) * 1 / var_5; var_5 > 0 && !self._id_5145; var_5 -= 0.05 )
        {
            self _meth_8044( var_4 + var_7 * var_5 );
            wait 0.05;
        }
    }
}

_id_5D37( var_0, var_1, var_2, var_3 )
{
    var_4 = getentarray( var_0, "script_noteworthy" );

    if ( !isdefined( var_4 ) )
        return;

    self endon( "death" );
    var_5 = 0;
    var_6 = randomfloatrange( 0.1, 0.25 );

    if ( isdefined( var_2 ) )
        exploder( var_2 );

    while ( var_5 < var_1 )
    {
        if ( isdefined( var_3 ) )
            exploder( var_3 );

        foreach ( var_8 in var_4 )
            var_8 show();

        wait(var_6);

        if ( isdefined( var_3 ) )
            _id_8E78( var_3 );

        foreach ( var_8 in var_4 )
            var_8 hide();

        var_5++;
        wait(var_6);
    }
}

_id_5704()
{
    level._id_05E0._id_5BB6 = [];
}

_id_56FC()
{

}

_id_5707( var_0, var_1 )
{
    level._id_05E0._id_5BB6[var_0] = var_1;
}

_id_5703( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( level._id_05E0._id_5BB6[var_0] ) )
    {
        if ( isdefined( var_3 ) )
            thread [[ level._id_05E0._id_5BB6[var_0] ]]( var_1, var_2, var_3 );
        else if ( isdefined( var_2 ) )
            thread [[ level._id_05E0._id_5BB6[var_0] ]]( var_1, var_2 );
        else if ( isdefined( var_1 ) )
            thread [[ level._id_05E0._id_5BB6[var_0] ]]( var_1 );
        else
            thread [[ level._id_05E0._id_5BB6[var_0] ]]();
    }
}

_id_8E78( var_0 )
{
    var_0 += "";

    if ( isdefined( level._id_241A ) )
    {
        var_1 = level._id_241A[var_0];

        if ( isdefined( var_1 ) )
        {
            foreach ( var_3 in var_1 )
            {
                if ( !isdefined( var_3._id_5878 ) )
                    continue;

                var_3._id_5878 delete();
            }

            return;
        }
    }
    else
    {
        for ( var_5 = 0; var_5 < level._id_2417.size; var_5++ )
        {
            var_3 = level._id_2417[var_5];

            if ( !isdefined( var_3 ) )
                continue;

            if ( var_3.v["type"] != "exploder" )
                continue;

            if ( !isdefined( var_3.v["exploder"] ) )
                continue;

            if ( var_3.v["exploder"] + "" != var_0 )
                continue;

            if ( !isdefined( var_3._id_5878 ) )
                continue;

            var_3._id_5878 delete();
        }
    }
}

exploder( var_0 )
{
    [[ level._id_3537 ]]( var_0 );
}
