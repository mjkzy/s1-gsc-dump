// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

trams()
{
    level.trams = getentarray( "ambient_tram", "targetname" );
    common_scripts\utility::array_thread( level.trams, ::tram_init );
    var_0 = [ "mp_detroit_train_01", "mp_detroit_train_02" ];

    foreach ( var_2 in var_0 )
        precachempanim( var_2 );

    foreach ( var_5 in level.trams )
        var_5 playloopsound( "mp_detroit_tram_close" );

    for (;;)
    {
        foreach ( var_5 in level.trams )
        {
            if ( !var_5.active )
            {
                var_8 = common_scripts\utility::random( var_0 );
                var_5 thread tram_animate( var_8 );
                break;
            }
        }

        wait(randomfloatrange( 10.0, 15.0 ));
    }
}

object_init_reset()
{
    self.reset_origin = self.origin;
    self.reset_angles = self.angles;
}

object_reset()
{
    self dontinterpolate();
    self.origin = self.reset_origin;
    self.angles = self.reset_angles;
}

tram_init()
{
    if ( isdefined( self.target ) )
    {
        var_0 = getentarray( self.target, "targetname" );

        foreach ( var_2 in var_0 )
            var_2 linkto( self );
    }

    self.active = 0;
    object_init_reset();
}

tram_reset()
{
    object_reset();
}

tram_spline_debug()
{
    for (;;)
    {
        while ( self.active || !getdvarint( "detroit_tram_spline_debug", 0 ) )
            waitframe();

        tram_reset();
        self.active = 1;
        var_0 = tram_spline_vehicle_spawn();
        var_0 waittill( "playSpaceStart" );
        var_0 thread tram_spline_stay_in_playspace();

        while ( getdvarint( "detroit_tram_spline_debug", 0 ) )
            waitframe();

        thread tram_spline_leave( var_0, 40 );
    }
}

tram_spline_vehicle_spawn()
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

    thread tram_node_notify( var_0, var_2, "playSpaceStart" );
    thread tram_node_notify( var_0, var_3, "playSpaceEnd" );
    thread tram_node_notify( var_0, var_4, "trackEnd" );
    var_0 attachpath( var_1 );
    var_0 startpath( var_1 );
    var_0.spline_speed = 25;
    var_0.spline_accel = 15;
    var_0.spline_decel = 20;
    var_0.spline_fast_decel = var_0.spline_decel * 2;
    self linkto( var_0 );
    return var_0;
}

tram_spline_move( var_0 )
{
    self.active = 1;
    var_1 = tram_spline_vehicle_spawn();
    self.endtime = gettime() + var_0 * 1000;
    self.owner setclientomnvar( "ui_warbird_countdown", self.endtime );
    waitframe();
    var_2 = 40;
    var_1 tram_set_forward();
    var_1 vehicle_setspeedimmediate( var_2, var_1.spline_accel, var_1.spline_decel );
    var_1 tram_stop_player_control();
    var_3 = common_scripts\utility::waittill_any_return( "playSpaceStart", "player_exit" );

    if ( var_3 != "player_exit" )
    {
        var_1 tram_start_player_control();
        var_1 thread tram_spline_stay_in_playspace( ::tram_start_player_control, ::tram_stop_player_control );
        common_scripts\utility::waittill_notify_or_timeout( "player_exit", ( self.endtime - gettime() ) / 1000 );
    }

    var_1 tram_stop_player_control();
    thread tram_spline_leave( var_1, var_2 );
}

tram_spline_leave( var_0, var_1 )
{
    var_0 notify( "stop_stay_in_playspace" );
    var_0 tram_set_forward();
    var_0 vehicle_setspeed( var_1, var_0.spline_accel, var_0.spline_decel );
    var_0 waittill( "trackEnd" );
    self unlink();
    var_0 delete();
    maps\mp\_utility::decrementfauxvehiclecount();
    self.active = 0;
}

tram_spline_stay_in_playspace( var_0, var_1 )
{
    self endon( "stop_stay_in_playspace" );

    for (;;)
    {
        var_2 = common_scripts\utility::waittill_any_return( "playSpaceStart", "playSpaceEnd" );

        if ( isdefined( var_1 ) )
            self [[ var_1 ]]();

        self vehicle_setspeed( 0, self.spline_accel, self.spline_fast_decel );

        while ( self.veh_speed != 0 )
            waitframe();

        if ( var_2 == "playSpaceStart" )
            tram_set_forward();
        else
            tram_set_reverse();

        self vehicle_setspeed( self.spline_speed, self.spline_accel, self.spline_decel );
        self waittill( var_2 );

        if ( isdefined( var_0 ) )
            self [[ var_0 ]]();
    }
}

tram_node_notify( var_0, var_1, var_2 )
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

tram_set_forward()
{
    self.current_dir = "forward";
    self.veh_transmission = self.current_dir;
    self.veh_pathdir = self.current_dir;
}

tram_set_reverse()
{
    self.current_dir = "reverse";
    self.veh_transmission = self.current_dir;
    self.veh_pathdir = self.current_dir;
}

tram_start_player_control()
{
    thread tram_update_player_spline_control();
}

tram_stop_player_control()
{
    self notify( "stop_player_control" );
}

tram_update_player_spline_control()
{
    self endon( "death" );
    self endon( "player_exit" );
    self endon( "stop_player_control" );
    var_0 = self.owner;
    var_0 endon( "disconnect" );
    self setacceleration( self.spline_accel );
    self setdeceleration( self.spline_decel );

    for (;;)
    {
        [var_2, var_3] = var_0 getnormalizedmovement();
        var_4 = var_0 getnormalizedmovement();
        var_5 = length( var_4 );

        if ( var_5 < 0.1 )
            self vehicle_setspeed( 0 );
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
                if ( self.current_dir != "forward" && self.veh_speed != 0 )
                    self vehicle_setspeed( 0, self.spline_accel, self.spline_fast_decel );
                else if ( self.current_dir != "forward" )
                    tram_set_forward();
                else
                    self vehicle_setspeed( self.spline_speed, self.spline_accel, self.spline_decel );
            }
            else if ( self.current_dir != "reverse" && self.veh_speed != 0 )
                self vehicle_setspeed( 0, self.spline_accel, self.spline_fast_decel );
            else if ( self.current_dir != "reverse" )
                tram_set_reverse();
            else
                self vehicle_setspeed( self.spline_speed, self.spline_accel, self.spline_decel );
        }

        waitframe();
    }
}

tram_animate( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "tram_node", "targetname" );

    if ( !isdefined( var_1 ) )
        return;

    self.active = 1;
    self scriptmodelplayanimdeltamotionfrompos( var_0, var_1.origin, var_1.angles, "tram_anim" );
    self waittillmatch( "tram_anim", "end" );
    self.active = 0;
}

tram_move( var_0, var_1 )
{
    self endon( "dropped" );
    var_2 = 3.14159;

    if ( !isdefined( var_1 ) )
        var_1 = var_0;

    self.active = 1;

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
            self vehicle_jetbikesethoverforcescale( var_7 );
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

    self.active = 0;
}
