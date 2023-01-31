// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setdvarifuninitialized( "stealth_display", 1 );
    setdvarifuninitialized( "stealth_display_radius", 140 );
    setdvarifuninitialized( "stealth_display_width", 8 );
    setdvarifuninitialized( "stealth_display_height", 64 );
    setdvarifuninitialized( "stealth_display_count", 90 );
    setdvarifuninitialized( "stealth_display_frames", 8 );
    setdvarifuninitialized( "stealth_display_spread", 0.75 );

    foreach ( var_1 in level.players )
        var_1 thread stealth_display_thread();
}

stealth_display_off()
{
    setdvar( "stealth_display", 0 );
}

stealth_display_on()
{
    setdvar( "stealth_display", 1 );
}

stealth_display_thread()
{
    self notify( "stealth_display_thread" );
    self endon( "stealth_display_thread" );

    if ( !isdefined( self.stealth_display ) )
        self.stealth_display = [];

    for (;;)
    {
        level.stealth_display_count = 0;
        var_0 = ( 0, -1, 0 ) * getdvarfloat( "stealth_display_radius" );
        var_1 = getdvarint( "stealth_display_width" );
        var_2 = getdvarint( "stealth_display_height" );
        var_3 = getdvarint( "stealth_display_count" );
        var_4 = getdvarint( "stealth_display_frames" );
        var_5 = 360.0 / var_3;
        var_6 = int( float( gettime() ) / 100.0 );
        self.stealth_display_active = 0;
        self.stealth_display_max = 0.0;

        if ( !getdvarint( "stealth_display" ) )
        {
            for ( var_7 = 0; var_7 < self.stealth_display.size; var_7++ )
            {
                var_8 = self.stealth_display[var_7];

                if ( isdefined( var_8.hud_elem ) )
                {
                    var_8.hud_elem destroy();
                    var_8.hud_elem = undefined;
                }
            }

            wait 0.05;
            continue;
        }

        for ( var_7 = 0; var_7 < var_3; var_7++ )
        {
            if ( !isdefined( self.stealth_display[var_7] ) )
            {
                var_8 = spawnstruct();
                var_8.value = 0;
                var_8.value_last = 0;
                var_8.state = 0;
                var_8.state_last = 0;
                var_8.hold_frames = 0;
                var_8.see_frames = 0;
                self.stealth_display[var_7] = var_8;
            }

            var_8 = self.stealth_display[var_7];
            var_8.screenangle = var_5 * var_7;

            if ( var_8.value > 0 && var_8.hold_frames <= 0 )
                var_8.value -= 0.1;

            if ( var_8.hold_frames > 0 )
                var_8.hold_frames -= 1;

            if ( var_8.see_frames > 0 )
                var_8.see_frames -= 1;

            var_8.state = floor( var_8.value * var_4 );

            if ( var_8.state == 0 )
                var_8.state = 1;

            if ( var_8.value > 0 && var_8.value_last <= 0 )
            {
                var_9 = maps\_hud_util::createicon( "stealth_eq_0" + var_8.state, var_1, var_2 );
                level.stealth_display_count++;
                var_9.sort = 1000;
                var_9.alignx = "center";
                var_9.aligny = "middle";
                var_9.horzalign = "center";
                var_9.vertalign = "middle";
                var_8.offset = rotatevector( var_0, ( 0, var_8.screenangle, 0 ) );
                var_9.x = var_8.offset[0];
                var_9.y = var_8.offset[1];
                var_9.rotation = var_8.screenangle;
                var_8.hud_elem = var_9;
            }
            else if ( var_8.value <= 0 && var_8.value_last > 0 && isdefined( var_8.hud_elem ) )
            {
                var_8.hud_elem destroy();
                var_8.hud_elem = undefined;
            }
            else if ( isdefined( var_8.hud_elem ) && var_8.state != var_8.state_last )
            {
                var_8.hud_elem _meth_80CC( "stealth_eq_0" + var_8.state, var_1, var_2 );
                level.stealth_display_count++;
            }

            if ( isdefined( var_8.hud_elem ) )
            {
                self.stealth_display_active = 1;
                self.stealth_display_max = max( self.stealth_display_max, var_8.value );

                if ( var_8.see_frames > 0 )
                {
                    var_10 = 0.5 + sin( float( gettime() * 2.0 ) ) * 0.5;
                    var_8.hud_elem.alpha = 0.5 + var_10 * 0.5;
                }
                else
                    var_8.hud_elem.alpha = 1.0;
            }

            var_8.value_last = var_8.value;
            var_8.state_last = var_8.state;
        }

        for ( var_7 = var_3; var_7 < self.stealth_display.size; var_7++ )
        {
            var_8 = self.stealth_display[var_7];

            if ( isdefined( var_8.hud_elem ) )
            {
                var_8.hud_elem destroy();
                var_8.hud_elem = undefined;
            }
        }

        wait 0.05;
    }
}

stealth_display_seed_angle( var_0, var_1, var_2 )
{
    if ( !getdvarint( "stealth_display" ) )
        return;

    if ( var_1 <= 0 )
        return;

    if ( !var_2 )
        var_1 = min( var_1, 0.99 );

    var_3 = getdvarint( "stealth_display_count" );

    if ( var_3 == 0 )
        return;

    var_4 = getdvarint( "stealth_display_frames" );
    var_5 = getdvarfloat( "stealth_display_spread" );
    var_6 = 1.0 / float( var_4 );
    var_7 = 360.0 / var_3;
    var_8 = int( floor( var_0 / var_7 ) );

    if ( self.stealth_display.size < var_3 )
        return;

    var_9 = 0;

    if ( var_1 >= 1.0 )
        var_9 = 2;

    for ( var_10 = 0; var_10 < var_3; var_10++ )
    {
        var_11 = var_8 - var_10;

        if ( var_11 < 0 )
            var_11 += var_3;

        var_12 = var_1;

        if ( var_10 > 0 && var_12 < 1.0 - var_6 && randomint( 100 ) > 80 )
            var_12 += var_6;

        self.stealth_display[var_11].value = max( self.stealth_display[var_11].value, var_12 );
        self.stealth_display[var_11].hold_frames = max( self.stealth_display[var_11].hold_frames, var_9 );

        if ( var_2 )
            self.stealth_display[var_11].see_frames = max( self.stealth_display[var_11].see_frames, var_9 );

        if ( var_1 < 1.0 / var_4 )
            self.stealth_display[var_11].hold_frames = max( self.stealth_display[var_11].hold_frames, 2 );

        if ( var_10 > 0 )
        {
            var_11 = var_8 + var_10;

            if ( var_11 >= var_3 )
                var_11 -= var_3;

            self.stealth_display[var_11].value = max( self.stealth_display[var_11].value, var_12 );
            self.stealth_display[var_11].hold_frames = max( self.stealth_display[var_11].hold_frames, var_9 );

            if ( var_2 )
                self.stealth_display[var_11].see_frames = max( self.stealth_display[var_11].see_frames, var_9 );

            if ( var_1 < 1.0 / var_4 )
                self.stealth_display[var_11].hold_frames = max( self.stealth_display[var_11].hold_frames, 2 );
        }
        else
            var_9 = min( var_9, 1 );

        if ( var_1 < 1.0 / var_4 )
            break;

        var_1 *= var_5;
        var_5 *= var_5;
    }
}

stealth_display_seed( var_0, var_1, var_2 )
{
    var_3 = angleclamp( self getangles()[1] - vectortoyaw( var_0.origin - self.origin ) );
    stealth_display_seed_angle( var_3, var_1, var_2 );
}
