// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_4DBC()
{
    if ( !isdefined( level.func ) )
        level.func = [];

    if ( !isdefined( level.func["create_triggerfx"] ) )
        level.func["create_triggerfx"] = ::_id_23DD;

    if ( !isdefined( level._id_05B2 ) )
        level._id_05B2 = spawnstruct();

    common_scripts\utility::create_lock( "createfx_looper", 20 );
    level._id_3BA4 = 1;
    level._id_05B2._id_3537 = common_scripts\_exploder::_id_3528;
    waittillframeend;
    waittillframeend;
    level._id_05B2._id_3537 = common_scripts\_exploder::_id_3527;
    level._id_05B2._id_7D98 = 0;

    if ( getdvarint( "serverCulledSounds" ) == 1 )
        level._id_05B2._id_7D98 = 1;

    if ( level.createfx_enabled )
        level._id_05B2._id_7D98 = 0;

    if ( level.createfx_enabled )
        level waittill( "createfx_common_done" );

    for ( var_0 = 0; var_0 < level._id_2417.size; var_0++ )
    {
        var_1 = level._id_2417[var_0];
        var_1 common_scripts\_createfx::_id_7E3A();

        switch ( var_1.v["type"] )
        {
            case "loopfx":
                var_1 thread _id_5880();
                continue;
            case "oneshotfx":
                var_1 thread _id_649D();
                continue;
            case "soundfx":
                var_1 thread _id_23CA();
                continue;
            case "soundfx_interval":
                var_1 thread _id_23C3();
                continue;
            case "reactive_fx":
                var_1 _id_078A();
                continue;
            case "soundfx_dynamic":
                var_1 thread _id_23AF();
                continue;
        }
    }

    _id_1CB4();
}

_id_7343()
{

}

_id_1CB4()
{

}

_id_1CD1( var_0, var_1 )
{

}

_id_6F96( var_0, var_1, var_2, var_3 )
{
    if ( getdvar( "debug" ) == "1" )
        return;
}

_id_688C()
{
    if ( isdefined( self.v["platform"] ) && isdefined( level.currentgen ) )
    {
        var_0 = self.v["platform"];

        if ( var_0 == "cg" && !level.currentgen || var_0 == "ng" && !level.nextgen || var_0 == "xenon" && !level.xenon || var_0 == "ps3" && !level.ps3 || var_0 == "pc" && !level._id_0300 || var_0 == "xb3" && !level.xb3 || var_0 == "ps4" && !level.ps4 || var_0 == "pccg" && !level._id_0301 || var_0 == "!cg" && level.currentgen || var_0 == "!ng" && level.nextgen || var_0 == "!xenon" && level.xenon || var_0 == "!ps3" && level.ps3 || var_0 == "!pc" && level._id_0300 || var_0 == "!xb3" && level.xb3 || var_0 == "!ps4" && level.ps4 || var_0 == "!pccg" && level._id_0301 )
            return 0;
    }

    return 1;
}

_id_649C( var_0, var_1, var_2, var_3 )
{

}

_id_3538( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17 )
{
    if ( 1 )
    {
        var_18 = common_scripts\utility::createexploder( var_1 );
        var_18.v["origin"] = var_2;
        var_18.v["angles"] = ( 0.0, 0.0, 0.0 );

        if ( isdefined( var_4 ) )
            var_18.v["angles"] = vectortoangles( var_4 - var_2 );

        var_18.v["delay"] = var_3;
        var_18.v["exploder"] = var_0;

        if ( isdefined( level._id_241A ) )
        {
            var_19 = level._id_241A[var_18.v["exploder"]];

            if ( !isdefined( var_19 ) )
                var_19 = [];

            var_19[var_19.size] = var_18;
            level._id_241A[var_18.v["exploder"]] = var_19;
        }

        return;
    }

    var_20 = spawn( "script_origin", ( 0.0, 0.0, 0.0 ) );
    var_20.origin = var_2;
    var_20.angles = vectortoangles( var_4 - var_2 );
    var_20.script_exploder = var_0;
    var_20._id_79EC = var_1;
    var_20.script_delay = var_3;
    var_20._id_79C6 = var_5;
    var_20._id_79C7 = var_6;
    var_20._id_79C8 = var_7;
    var_20.script_sound = var_8;
    var_20._id_79B0 = var_9;
    var_20._id_797C = var_10;
    var_20._id_7AAC = var_15;
    var_20._id_7AC5 = var_11;
    var_20._id_79C9 = var_16;
    var_20._id_7AB0 = var_12;
    var_20._id_7989 = var_13;
    var_20._id_7988 = var_14;
    var_20._id_79BC = var_17;
    var_21 = anglestoforward( var_20.angles );
    var_21 *= 150;
    var_20._id_91D1 = var_2 + var_21;

    if ( !isdefined( level._id_062E ) )
        level._id_062E = [];

    level._id_062E[level._id_062E.size] = var_20;
}

_id_5879( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = common_scripts\utility::createloopeffect( var_0 );
    var_7.v["origin"] = var_1;
    var_7.v["angles"] = ( 0.0, 0.0, 0.0 );

    if ( isdefined( var_3 ) )
        var_7.v["angles"] = vectortoangles( var_3 - var_1 );

    var_7.v["delay"] = var_2;
}

_id_23C9()
{
    self._id_5878 = playloopedfx( level._effect[self.v["fxid"]], self.v["delay"], self.v["origin"], 0, self.v["forward"], self.v["up"] );
    _id_23CA();
}

_id_23CA()
{
    if ( !_id_688C() )
        return;

    self notify( "stop_loop" );

    if ( !isdefined( self.v["soundalias"] ) )
        return;

    if ( self.v["soundalias"] == "nil" )
        return;

    var_0 = 0;
    var_1 = undefined;

    if ( isdefined( self.v["stopable"] ) && self.v["stopable"] )
    {
        if ( isdefined( self._id_5878 ) )
            var_1 = "death";
        else
            var_1 = "stop_loop";
    }
    else if ( level._id_05B2._id_7D98 && isdefined( self.v["server_culled"] ) )
        var_0 = self.v["server_culled"];

    var_2 = self;

    if ( isdefined( self._id_5878 ) )
        var_2 = self._id_5878;

    var_3 = undefined;

    if ( level.createfx_enabled )
        var_3 = self;

    var_2 common_scripts\utility::loop_fx_sound_with_angles( self.v["soundalias"], self.v["origin"], self.v["angles"], var_0, var_1, var_3 );
}

_id_23C3()
{
    if ( !_id_688C() )
        return;

    self notify( "stop_loop" );

    if ( !isdefined( self.v["soundalias"] ) )
        return;

    if ( self.v["soundalias"] == "nil" )
        return;

    var_0 = undefined;
    var_1 = self;

    if ( isdefined( self.v["stopable"] ) && self.v["stopable"] || level.createfx_enabled )
    {
        if ( isdefined( self._id_5878 ) )
        {
            var_1 = self._id_5878;
            var_0 = "death";
        }
        else
            var_0 = "stop_loop";
    }

    var_1 thread common_scripts\utility::loop_fx_sound_interval_with_angles( self.v["soundalias"], self.v["origin"], self.v["angles"], var_0, undefined, self.v["delay_min"], self.v["delay_max"] );
}

_id_23AF()
{
    if ( !_id_688C() )
        return;

    if ( !isdefined( self.v["ambiencename"] ) )
        return;

    if ( self.v["ambiencename"] == "nil" )
        return;

    if ( common_scripts\utility::issp() )
        return;

    if ( getdvar( "createfx" ) == "on" )
        common_scripts\utility::flag_wait( "createfx_started" );

    if ( isdefined( self._id_25CB ) )
        level.player _meth_847E( self._id_25CB.unique_id );

    self._id_25CB = spawnstruct();
    self._id_25CB common_scripts\utility::assign_unique_id();
    level.player _meth_847D( self.v["ambiencename"], self.v["origin"], self.v["dynamic_distance"], self._id_25CB.unique_id );
    return;
}

_id_5880()
{
    waitframe();

    if ( isdefined( self._id_3BB7 ) )
        level waittill( "start fx" + self._id_3BB7 );

    for (;;)
    {
        _id_23C9();

        if ( isdefined( self._id_9364 ) )
            thread _id_587F( self._id_9364 );

        if ( isdefined( self._id_3BB8 ) )
            level waittill( "stop fx" + self._id_3BB8 );
        else
            return;

        if ( isdefined( self._id_5878 ) )
            self._id_5878 delete();

        if ( isdefined( self._id_3BB7 ) )
        {
            level waittill( "start fx" + self._id_3BB7 );
            continue;
        }

        return;
    }
}

_id_587C( var_0 )
{
    self endon( "death" );
    var_0 waittill( "effect id changed", var_1 );
}

_id_587D( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        var_0 waittill( "effect org changed", var_1 );
        self.origin = var_1;
    }
}

_id_587B( var_0 )
{
    self endon( "death" );
    var_0 waittill( "effect delay changed", var_1 );
}

_id_587E( var_0 )
{
    self endon( "death" );
    var_0 waittill( "effect deleted" );
    self delete();
}

_id_587F( var_0 )
{
    self endon( "death" );
    wait(var_0);
    self._id_5878 delete();
}

_id_588D( var_0, var_1, var_2 )
{
    level thread _id_588F( var_0, var_1, var_2 );
}

_id_588F( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_origin", var_1 );
    var_3.origin = var_1;
    var_3 playloopsound( var_0 );
}

_id_4467( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    thread _id_4468( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 );
}

_id_4468( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    level endon( "stop all gunfireloopfx" );
    waitframe();

    if ( var_7 < var_6 )
    {
        var_8 = var_7;
        var_7 = var_6;
        var_6 = var_8;
    }

    var_9 = var_6;
    var_10 = var_7 - var_6;

    if ( var_5 < var_4 )
    {
        var_8 = var_5;
        var_5 = var_4;
        var_4 = var_8;
    }

    var_11 = var_4;
    var_12 = var_5 - var_4;

    if ( var_3 < var_2 )
    {
        var_8 = var_3;
        var_3 = var_2;
        var_2 = var_8;
    }

    var_13 = var_2;
    var_14 = var_3 - var_2;
    var_15 = spawnfx( level._effect[var_0], var_1 );

    if ( !level.createfx_enabled )
        var_15 willneverchange();

    for (;;)
    {
        var_16 = var_13 + randomint( var_14 );

        for ( var_17 = 0; var_17 < var_16; var_17++ )
        {
            triggerfx( var_15 );
            wait(var_11 + randomfloat( var_12 ));
        }

        wait(var_9 + randomfloat( var_10 ));
    }
}

_id_4469( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    thread _id_446A( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
}

_id_446A( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    level endon( "stop all gunfireloopfx" );
    waitframe();

    if ( var_8 < var_7 )
    {
        var_9 = var_8;
        var_8 = var_7;
        var_7 = var_9;
    }

    var_10 = var_7;
    var_11 = var_8 - var_7;

    if ( var_6 < var_5 )
    {
        var_9 = var_6;
        var_6 = var_5;
        var_5 = var_9;
    }

    var_12 = var_5;
    var_13 = var_6 - var_5;

    if ( var_4 < var_3 )
    {
        var_9 = var_4;
        var_4 = var_3;
        var_3 = var_9;
    }

    var_14 = var_3;
    var_15 = var_4 - var_3;
    var_2 = vectornormalize( var_2 - var_1 );
    var_16 = spawnfx( level._effect[var_0], var_1, var_2 );

    if ( !level.createfx_enabled )
        var_16 willneverchange();

    for (;;)
    {
        var_17 = var_14 + randomint( var_15 );

        for ( var_18 = 0; var_18 < int( var_17 / level._id_3BA4 ); var_18++ )
        {
            triggerfx( var_16 );
            var_19 = ( var_12 + randomfloat( var_13 ) ) * level._id_3BA4;

            if ( var_19 < 0.05 )
                var_19 = 0.05;

            wait(var_19);
        }

        wait(var_12 + randomfloat( var_13 ));
        wait(var_10 + randomfloat( var_11 ));
    }
}

_id_7F68( var_0 )
{
    level._id_3BA4 = 1 / var_0;
}

_id_8118()
{
    if ( !isdefined( self._id_79EC ) || !isdefined( self._id_79EB ) || !isdefined( self.script_delay ) )
        return;

    if ( isdefined( self.model ) )
    {
        if ( self.model == "toilet" )
        {
            thread _id_1929();
            return;
        }
    }

    var_0 = undefined;

    if ( isdefined( self.target ) )
    {
        var_1 = getent( self.target, "targetname" );

        if ( isdefined( var_1 ) )
            var_0 = var_1.origin;
    }

    var_2 = undefined;

    if ( isdefined( self._id_79ED ) )
        var_2 = self._id_79ED;

    var_3 = undefined;

    if ( isdefined( self._id_79EE ) )
        var_3 = self._id_79EE;

    if ( self._id_79EB == "OneShotfx" )
        _id_649C( self._id_79EC, self.origin, self.script_delay, var_0 );

    if ( self._id_79EB == "loopfx" )
        _id_5879( self._id_79EC, self.origin, self.script_delay, var_0, var_2, var_3 );

    if ( self._id_79EB == "loopsound" )
        _id_588D( self._id_79EC, self.origin, self.script_delay );

    self delete();
}

_id_1929()
{
    var_0 = ( 0, 0, self.angles[1] );
    var_1 = level._effect[self._id_79EC];
    var_2 = self.origin;
    wait 1;
    level thread _id_192A( var_0, var_2, var_1 );
    self delete();
}

_id_192A( var_0, var_1, var_2 )
{
    for (;;)
    {
        playfx( var_2, var_1 );
        wait(30 + randomfloat( 40 ));
    }
}

_id_23DD()
{
    if ( !_id_9D7E( self.v["fxid"] ) )
        return;

    self._id_5878 = spawnfx( level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"] );
    triggerfx( self._id_5878, self.v["delay"] );

    if ( !level.createfx_enabled )
        self._id_5878 willneverchange();

    _id_23CA();
}

_id_9D7E( var_0 )
{
    if ( isdefined( level._effect[var_0] ) )
        return 1;

    if ( !isdefined( level._id_05F3 ) )
        level._id_05F3 = [];

    level._id_05F3[self.v["fxid"]] = var_0;
    _id_9D7F( var_0 );
    return 0;
}

_id_9D7F( var_0 )
{
    level notify( "verify_effects_assignment_print" );
    level endon( "verify_effects_assignment_print" );
    wait 0.05;
    var_1 = getarraykeys( level._id_05F3 );

    foreach ( var_3 in var_1 )
    {

    }
}

_id_649D()
{
    wait 0.05;

    if ( !_id_688C() )
        return;

    if ( self.v["delay"] > 0 )
        wait(self.v["delay"]);

    [[ level.func["create_triggerfx"] ]]();
}

_id_078A()
{
    if ( !_id_688C() )
        return;

    if ( !common_scripts\utility::issp() && getdvar( "createfx" ) == "" )
        return;

    if ( !isdefined( level._id_05B2._id_718D ) )
    {
        level._id_05B2._id_718D = 1;
        level thread _id_718B();
    }

    if ( !isdefined( level._id_05B2._id_718A ) )
        level._id_05B2._id_718A = [];

    level._id_05B2._id_718A[level._id_05B2._id_718A.size] = self;
    self._id_60BD = 3000;
}

_id_718B()
{
    if ( !common_scripts\utility::issp() )
    {
        if ( getdvar( "createfx" ) == "on" )
            common_scripts\utility::flag_wait( "createfx_started" );
    }

    level._id_05B2._id_718C = [];
    var_0 = 256;

    for (;;)
    {
        level waittill( "code_damageradius", var_1, var_0, var_2, var_3 );
        var_4 = _id_888C( var_2, var_0 );

        foreach ( var_7, var_6 in var_4 )
            var_6 thread _id_6995( var_7 );
    }
}

_id_9C69( var_0 )
{
    return ( var_0[0], var_0[1], 0 );
}

_id_888C( var_0, var_1 )
{
    var_2 = [];
    var_3 = gettime();

    foreach ( var_5 in level._id_05B2._id_718A )
    {
        if ( var_5._id_60BD > var_3 )
            continue;

        var_6 = var_5.v["reactive_radius"] + var_1;
        var_6 *= var_6;

        if ( distancesquared( var_0, var_5.v["origin"] ) < var_6 )
            var_2[var_2.size] = var_5;
    }

    foreach ( var_5 in var_2 )
    {
        var_9 = _id_9C69( var_5.v["origin"] - level.player.origin );
        var_10 = _id_9C69( var_0 - level.player.origin );
        var_11 = vectornormalize( var_9 );
        var_12 = vectornormalize( var_10 );
        var_5.dot = vectordot( var_11, var_12 );
    }

    for ( var_14 = 0; var_14 < var_2.size - 1; var_14++ )
    {
        for ( var_15 = var_14 + 1; var_15 < var_2.size; var_15++ )
        {
            if ( var_2[var_14].dot > var_2[var_15].dot )
            {
                var_16 = var_2[var_14];
                var_2[var_14] = var_2[var_15];
                var_2[var_15] = var_16;
            }
        }
    }

    foreach ( var_5 in var_2 )
    {
        var_5.origin = undefined;
        var_5.dot = undefined;
    }

    for ( var_14 = 4; var_14 < var_2.size; var_14++ )
        var_2[var_14] = undefined;

    return var_2;
}

_id_6995( var_0 )
{
    var_1 = _id_3E4B();

    if ( !isdefined( var_1 ) )
        return;

    self._id_60BD = gettime() + 3000;
    var_1.origin = self.v["origin"];
    var_1._id_5069 = 1;
    wait(var_0 * randomfloatrange( 0.05, 0.1 ));

    if ( common_scripts\utility::issp() )
    {
        var_1 playsound( self.v["soundalias"], "sounddone" );
        var_1 waittill( "sounddone" );
    }
    else
    {
        var_1 playsound( self.v["soundalias"] );
        wait 2;
    }

    wait 0.1;
    var_1._id_5069 = 0;
}

_id_3E4B()
{
    foreach ( var_1 in level._id_05B2._id_718C )
    {
        if ( !var_1._id_5069 )
            return var_1;
    }

    if ( level._id_05B2._id_718C.size < 4 )
    {
        var_1 = spawn( "script_origin", ( 0.0, 0.0, 0.0 ) );
        var_1._id_5069 = 0;
        level._id_05B2._id_718C[level._id_05B2._id_718C.size] = var_1;
        return var_1;
    }

    return undefined;
}
