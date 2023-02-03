// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

createdefaultbobsettings()
{
    var_0 = spawnstruct();
    var_0.max_pitch = 3;
    var_0.min_pitch_period = 3;
    var_0.max_pitch_period = 6;
    var_0.max_yaw = 0;
    var_0.min_yaw_period = 3;
    var_0.max_yaw_period = 6;
    var_0.max_roll = 6;
    var_0.min_roll_period = 3;
    var_0.max_roll_period = 6;
    var_0.max_sink = 36;
    var_0.max_float = 24;
    var_0.min_bob_period = 3;
    var_0.max_bob_period = 6;
    return var_0;
}

createdefaultsmallbobsettings()
{
    var_0 = spawnstruct();
    var_0.max_pitch = 10;
    var_0.min_pitch_period = 1;
    var_0.max_pitch_period = 3;
    var_0.max_yaw = 0;
    var_0.min_yaw_period = 3;
    var_0.max_yaw_period = 6;
    var_0.max_roll = 10;
    var_0.min_roll_period = 1;
    var_0.max_roll_period = 3;
    var_0.max_sink = 12;
    var_0.max_float = 12;
    var_0.min_bob_period = 1;
    var_0.max_bob_period = 3;
    var_0.isbuoy = 1;
    return var_0;
}

no_bobbing()
{
    self.nobob = 1;
    self notify( "stop_bobbing" );
}

cleanup_bobbing()
{
    self.org_angles = self.angles;
    self.org_origin = self.origin;
    self waittill( "stop_bobbing" );
    waittillframeend;
    self rotateto( self.org_angles, 1, 0, 0 );
    self moveto( self.org_origin, 1, 0, 0 );
}

start_bobbing_single( var_0 )
{
    self notify( "stop_bobbing" );
    self endon( "stop_bobbing" );
    self endon( "death" );
    thread cleanup_bobbing();
    wait(var_0);

    if ( isdefined( self.nobob ) && self.nobob )
        return;

    self [[ self.bobbing_fnc ]]( self.bobbing_settings );
}

start_bobbing( var_0 )
{
    var_1 = 1.0;
    var_2 = 0.0;

    foreach ( var_4 in var_0 )
    {
        var_4 thread start_bobbing_single( var_2 );
        var_2 += 0.05;

        if ( var_2 > var_1 )
            var_2 -= var_1;
    }
}

stop_bobbing( var_0 )
{
    foreach ( var_2 in var_0 )
        var_2 notify( "stop_bobbing" );
}

prep_bobbing( var_0, var_1, var_2, var_3 )
{
    foreach ( var_5 in var_0 )
    {
        var_5.bobbing_fnc = var_1;
        var_5.bobbing_settings = var_2;
        var_5.bobbing_underwater = var_3;
    }
}

bobbingobject( var_0 )
{
    var_1 = self.origin;
    var_2 = self.angles;
    var_3 = 5;
    var_4 = 3;
    var_5 = 6;
    var_6 = 0;
    var_7 = 3;
    var_8 = 6;
    var_9 = 0;
    var_10 = 3;
    var_11 = 6;
    var_12 = 36;
    var_13 = 24;
    var_14 = 3;
    var_15 = 6;
    var_16 = 0;
    var_17 = 3;
    var_18 = 6;
    var_19 = 0;
    var_20 = 3;
    var_21 = 6;
    var_22 = 1;

    if ( isdefined( var_0 ) )
    {
        if ( isdefined( var_0.max_pitch ) )
            var_3 = var_0.max_pitch;

        if ( isdefined( var_0.min_pitch_period ) )
            var_4 = var_0.min_pitch_period;

        if ( isdefined( var_0.max_pitch_period ) )
            var_5 = var_0.max_pitch_period;

        if ( isdefined( var_0.max_yaw ) )
            var_6 = var_0.max_yaw;

        if ( isdefined( var_0.min_yaw_period ) )
            var_7 = var_0.min_yaw_period;

        if ( isdefined( var_0.max_yaw_period ) )
            var_8 = var_0.max_yaw_period;

        if ( isdefined( var_0.max_roll ) )
            var_9 = var_0.max_roll;

        if ( isdefined( var_0.min_roll_period ) )
            var_10 = var_0.min_roll_period;

        if ( isdefined( var_0.max_roll_period ) )
            var_11 = var_0.max_roll_period;

        if ( isdefined( var_0.max_sink ) )
            var_12 = var_0.max_sink;

        if ( isdefined( var_0.max_float ) )
            var_13 = var_0.max_float;

        if ( isdefined( var_0.min_bob_period ) )
            var_14 = var_0.min_bob_period;

        if ( isdefined( var_0.max_bob_period ) )
            var_15 = var_0.max_bob_period;

        if ( isdefined( var_0.max_dx ) )
            var_16 = var_0.max_dx;

        if ( isdefined( var_0.min_dx_period ) )
            var_17 = var_0.min_dx_period;

        if ( isdefined( var_0.max_dx_period ) )
            var_18 = var_0.max_dx_period;

        if ( isdefined( var_0.max_dy ) )
            var_19 = var_0.max_dy;

        if ( isdefined( var_0.min_dy_period ) )
            var_20 = var_0.min_dy_period;

        if ( isdefined( var_0.max_dy_period ) )
            var_21 = var_0.max_dy_period;

        if ( isdefined( var_0.oldstyle ) )
            var_22 = var_0.oldstyle;
    }

    self.tgt_values[0] = var_2[0];
    self.tgt_values[1] = var_2[1];
    self.tgt_values[2] = var_2[2];
    self.tgt_values[3] = var_1[0];
    self.tgt_values[4] = var_1[1];
    self.tgt_values[5] = var_1[2];

    if ( !var_22 )
        thread bobobjectto( isdefined( var_0.isbuoy ) );

    if ( isdefined( var_0.isbuoy ) )
        thread bobbingbuoyangles();
    else
    {
        if ( var_3 > 0 )
            thread bobobjectparam( 0, var_2[0], 0 - var_3, var_3, var_4, var_5, var_22 );

        if ( var_6 > 0 )
            thread bobobjectparam( 1, var_2[1], 0 - var_6, var_6, var_7, var_8, var_22 );

        if ( var_9 > 0 )
            thread bobobjectparam( 2, var_2[2], 0 - var_9, var_9, var_10, var_11, var_22 );
    }

    if ( var_16 > 0 )
        thread bobobjectparam( 3, var_1[0], 0 - var_16, var_16, var_17, var_18, var_22 );

    if ( var_19 > 0 )
        thread bobobjectparam( 4, var_1[1], 0 - var_19, var_19, var_20, var_21, var_22 );

    if ( var_13 > 0 )
        thread bobobjectparam( 5, var_1[2], 0 - var_12, var_13, var_14, var_15, var_22 );
}

bobobjectparam( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    self endon( "stop_bobbing" );
    self endon( "death" );
    var_7 = randomint( 2 );
    self.tgt_values[var_0] = var_1;

    for (;;)
    {
        var_8 = var_1;
        var_9 = var_4;

        switch ( var_7 )
        {
            case 0:
                var_8 = var_1 + randomfloat( var_3 );
                break;
            case 1:
                if ( var_2 < 0 )
                    var_8 = var_1 - randomfloat( -1 * var_2 );
                else
                    var_8 = var_1 + randomfloat( var_2 );

                break;
        }

        var_9 = randomfloatrange( var_4, var_5 );
        var_10 = var_9 / 3.0;
        var_11 = var_9 / 3.0;

        if ( var_6 )
        {
            var_12 = 0;

            if ( var_0 < 3 )
            {
                var_12 = var_8 - self.angles[var_0];
                var_12 = angleclamp180( var_12 );
            }

            switch ( var_0 )
            {
                case 0:
                    self rotatepitch( var_12, var_9, var_10, var_11 );
                    break;
                case 1:
                    self rotateyaw( var_12, var_9, var_10, var_11 );
                    break;
                case 2:
                    self rotateroll( var_12, var_9, var_10, var_11 );
                    break;
                case 3:
                    self movex( var_8 - self.origin[0], var_9, var_10, var_11 );
                    break;
                case 4:
                    self movey( var_8 - self.origin[1], var_9, var_10, var_11 );
                    break;
                case 5:
                    self movez( var_8 - self.origin[2], var_9, var_10, var_11 );
                    break;
            }

            wait(var_9);
        }
        else
        {
            while ( 0 < var_9 )
            {
                var_13 = self.tgt_values[var_0];
                var_12 = var_8 - var_13;
                self.tgt_values[var_0] += 0.05 / var_9 * var_12;
                wait 0.05;
                var_9 -= 0.05;
            }
        }

        var_7 = 1 - var_7;
    }
}

bobbingbuoyangles()
{
    self endon( "stop_bobbing" );
    self endon( "death" );
    var_0 = 0.3;
    var_1 = 1.5;
    var_2 = 60.0;
    var_3 = 3.0;
    var_4 = 4.0;
    var_5 = var_0 * var_4;
    var_6 = 0;
    self.org_angles = self.angles;

    if ( self.org_angles[0] == 0 && self.org_angles[2] == 0 )
        var_7 = 1;
    else
        var_7 = 0;

    var_8 = ( 0, 0, 0 );
    var_9 = 18.0 / var_2;
    var_10 = 0.36 / var_3;

    for (;;)
    {
        var_11 = calcrockingangles( self.org_angles, var_6, 4.0, 3.0, 60.0 );
        var_12 = var_11["angles"];
        var_6 = var_11["result"];
        self rotateto( var_12, 0.4, 0, 0 );
        wait 0.2;
    }
}

bobobjectto( var_0 )
{
    self endon( "stop_bobbing" );
    self endon( "death" );

    for (;;)
    {
        var_1 = ( self.tgt_values[3], self.tgt_values[4], self.tgt_values[5] );
        var_2 = ( self.tgt_values[0], self.tgt_values[1], self.tgt_values[2] );
        self moveto( var_1, 0.1, 0.0, 0.0 );

        if ( !var_0 )
            self rotateto( var_2, 0.1, 0.0, 0.0 );

        wait 0.05;
    }
}
