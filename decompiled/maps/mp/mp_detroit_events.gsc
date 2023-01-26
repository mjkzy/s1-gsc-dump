// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_96C4()
{
    level._id_96C4 = getentarray( "ambient_tram", "targetname" );
    common_scripts\utility::array_thread( level._id_96C4, ::_id_96AA );
    var_0 = [ "mp_detroit_train_01", "mp_detroit_train_02" ];

    foreach ( var_2 in var_0 )
        map_restart( var_2 );

    foreach ( var_5 in level._id_96C4 )
        var_5 playloopsound( "mp_detroit_tram_close" );

    for (;;)
    {
        foreach ( var_5 in level._id_96C4 )
        {
            if ( !var_5._id_0014 )
            {
                var_8 = common_scripts\utility::random( var_0 );
                var_5 thread _id_96A8( var_8 );
                break;
            }
        }

        wait(randomfloatrange( 10.0, 15.0 ));
    }
}

_id_62E0()
{
    self._id_7430 = self.origin;
    self._id_741E = self.angles;
}

_id_62E1()
{
    self dontinterpolate();
    self.origin = self._id_7430;
    self.angles = self._id_741E;
}

_id_96AA()
{
    if ( isdefined( self.target ) )
    {
        var_0 = getentarray( self.target, "targetname" );

        foreach ( var_2 in var_0 )
            var_2 linkto( self );
    }

    self._id_0014 = 0;
    _id_62E0();
}

_id_96B3()
{
    _id_62E1();
}

_id_96B7()
{
    for (;;)
    {
        while ( self._id_0014 || !getdvarint( "detroit_tram_spline_debug", 0 ) )
            waitframe();

        _id_96B3();
        self._id_0014 = 1;
        var_0 = _id_96BB();
        var_0 waittill( "playSpaceStart" );
        var_0 thread _id_96BA();

        while ( getdvarint( "detroit_tram_spline_debug", 0 ) )
            waitframe();

        thread _id_96B8( var_0, 40 );
    }
}

_id_96BB()
{
    var_0 = spawnvehicle( "tag_origin", "detroit_tram", "detroit_tram_mp", self.origin, self.angles );
    var_0.owner = self.owner;
    var_1 = getvehiclenode( self.target, "targetname" );
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = var_1;

    while ( isdefined( var_5.target ) )
    {
        var_5 = getvehiclenode( var_5.target, "targetname" );

        if ( common_scripts\utility::string_starts_with( var_5.targetname, "play_space_edge" ) )
        {
            if ( !isdefined( var_2 ) )
                var_2 = var_5;
            else
                var_3 = var_5;
        }

        if ( common_scripts\utility::string_starts_with( var_5.targetname, "track_end" ) )
            var_4 = var_5;
    }

    thread _id_96B2( var_0, var_2, "playSpaceStart" );
    thread _id_96B2( var_0, var_3, "playSpaceEnd" );
    thread _id_96B2( var_0, var_4, "trackEnd" );
    var_0 _meth_827D( var_1 );
    var_0 _meth_827F( var_1 );
    var_0._id_8A6C = 25;
    var_0._id_8A69 = 15;
    var_0._id_8A6A = 20;
    var_0._id_8A6B = var_0._id_8A6A * 2;
    self linkto( var_0 );
    return var_0;
}

_id_96B9( var_0 )
{
    self._id_0014 = 1;
    var_1 = _id_96BB();
    self.endtime = gettime() + var_0 * 1000;
    self.owner setclientomnvar( "ui_warbird_countdown", self.endtime );
    waitframe();
    var_2 = 40;
    var_1 _id_96B4();
    var_1 _meth_8284( var_2, var_1._id_8A69, var_1._id_8A6A );
    var_1 _id_96BE();
    var_3 = common_scripts\utility::waittill_any_return( "playSpaceStart", "player_exit" );

    if ( var_3 != "player_exit" )
    {
        var_1 _id_96BC();
        var_1 thread _id_96BA( ::_id_96BC, ::_id_96BE );
        common_scripts\utility::waittill_notify_or_timeout( "player_exit", ( self.endtime - gettime() ) / 1000 );
    }

    var_1 _id_96BE();
    thread _id_96B8( var_1, var_2 );
}

_id_96B8( var_0, var_1 )
{
    var_0 notify( "stop_stay_in_playspace" );
    var_0 _id_96B4();
    var_0 _meth_8283( var_1, var_0._id_8A69, var_0._id_8A6A );
    var_0 waittill( "trackEnd" );
    self unlink();
    var_0 delete();
    maps\mp\_utility::decrementfauxvehiclecount();
    self._id_0014 = 0;
}

_id_96BA( var_0, var_1 )
{
    self endon( "stop_stay_in_playspace" );

    for (;;)
    {
        var_2 = common_scripts\utility::waittill_any_return( "playSpaceStart", "playSpaceEnd" );

        if ( isdefined( var_1 ) )
            self [[ var_1 ]]();

        self _meth_8283( 0, self._id_8A69, self._id_8A6B );

        while ( self._id_04F8 != 0 )
            waitframe();

        if ( var_2 == "playSpaceStart" )
            _id_96B4();
        else
            _id_96B5();

        self _meth_8283( self._id_8A6C, self._id_8A69, self._id_8A6A );
        self waittill( var_2 );

        if ( isdefined( var_0 ) )
            self [[ var_0 ]]();
    }
}

_id_96B2( var_0, var_1, var_2 )
{
    var_0 endon( "death" );

    for (;;)
    {
        var_1 waittill( "trigger", var_3 );

        if ( var_3 == var_0 )
        {
            var_0 notify( var_2 );
            self notify( var_2 );
        }
    }
}

_id_96B4()
{
    self._id_24DD = "forward";
    self._id_04FB = self._id_24DD;
    self._id_04F4 = self._id_24DD;
}

_id_96B5()
{
    self._id_24DD = "reverse";
    self._id_04FB = self._id_24DD;
    self._id_04F4 = self._id_24DD;
}

_id_96BC()
{
    thread _id_96BF();
}

_id_96BE()
{
    self notify( "stop_player_control" );
}

_id_96BF()
{
    self endon( "death" );
    self endon( "player_exit" );
    self endon( "stop_player_control" );
    var_0 = self.owner;
    var_0 endon( "disconnect" );
    self _meth_828F( self._id_8A69 );
    self _meth_8290( self._id_8A6A );

    for (;;)
    {
        [ var_2, var_3 ] = var_0 _meth_82F3();
        var_4 = var_0 _meth_82F3();
        var_5 = length( var_4 );

        if ( var_5 < 0.1 )
            self _meth_8283( 0 );
        else
        {
            var_6 = var_0 getangles();
            var_4 = ( var_4[0], var_4[1] * -1, 0 );
            var_7 = vectortoangles( var_4 );
            var_7 = common_scripts\utility::flat_angle( combineangles( var_7, var_6 ) );
            var_4 = anglestoforward( var_7 );
            var_8 = anglestoforward( self.angles );
            var_9 = vectordot( var_4, var_8 );

            if ( var_9 > 0 )
            {
                if ( self._id_24DD != "forward" && self._id_04F8 != 0 )
                    self _meth_8283( 0, self._id_8A69, self._id_8A6B );
                else if ( self._id_24DD != "forward" )
                    _id_96B4();
                else
                    self _meth_8283( self._id_8A6C, self._id_8A69, self._id_8A6A );
            }
            else if ( self._id_24DD != "reverse" && self._id_04F8 != 0 )
                self _meth_8283( 0, self._id_8A69, self._id_8A6B );
            else if ( self._id_24DD != "reverse" )
                _id_96B5();
            else
                self _meth_8283( self._id_8A6C, self._id_8A69, self._id_8A6A );
        }

        waitframe();
    }
}

_id_96A8( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "tram_node", "targetname" );

    if ( !isdefined( var_1 ) )
        return;

    self._id_0014 = 1;
    self _meth_848B( var_0, var_1.origin, var_1.angles, "tram_anim" );
    self waittillmatch( "tram_anim", "end" );
    self._id_0014 = 0;
}

_id_96B1( var_0, var_1 )
{
    self endon( "dropped" );
    var_2 = 3.14159;

    if ( !isdefined( var_1 ) )
        var_1 = var_0;

    self._id_0014 = 1;

    for ( var_3 = self; isdefined( var_3.target ); var_3 = var_4 )
    {
        var_4 = common_scripts\utility::getstruct( var_3.target, "targetname" );
        var_5 = var_0;
        var_6 = undefined;

        if ( isdefined( var_4.script_noteworthy ) )
        {
            switch ( var_4.script_noteworthy )
            {
                case "fast":
                    var_5 = var_1;
                    break;
                case "clockwise_fast":
                    var_5 = var_1;
                    var_6 = -90;
                    break;
                case "clockwise":
                    var_6 = -90;
                    break;
                case "counterclockwise_fast":
                    var_5 = var_1;
                    var_6 = 90;
                    break;
                case "counterclockwise":
                    var_6 = 90;
                    break;
                default:
                    break;
            }
        }

        if ( isdefined( var_6 ) )
        {
            var_7 = spawn( "script_origin", var_4.origin );
            self linktosynchronizedparent( var_7 );
            var_8 = distance( var_7.origin, self.origin );
            var_9 = var_8 * 2 * var_2;
            var_10 = var_9 * abs( var_6 ) / 360;
            var_11 = var_10 / var_5;
            var_7 rotateyaw( var_6, var_11 );
            var_7 waittill( "rotatedone" );
            self unlink();
            var_7 delete();
            continue;
        }

        var_10 = distance( self.origin, var_4.origin );
        var_11 = var_10 / var_5;
        self moveto( var_4.origin, var_11 );
        self waittill( "movedone" );
    }

    self._id_0014 = 0;
}
