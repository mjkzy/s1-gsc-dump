// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{

}

enable_boost_dash()
{
    if ( !isdefined( self.boost ) )
    {
        self.boost = [];
        self.boost["inboost"] = 0;
    }

    self allowsprint( 0 );
    thread track_player_movement();
    thread track_player_velocity();
    thread dash();
}

disable_boost_dash()
{
    self notify( "disable_boost_dash" );
    self.boost = undefined;
    self allowsprint( 1 );
}

track_player_movement()
{
    self endon( "death" );
    self endon( "disable_boost_dash" );

    if ( !isdefined( self.boost["stick_input"] ) )
        self.boost["stick_input"] = ( 0, 0, 0 );

    for (;;)
    {
        var_0 = self getnormalizedmovement();
        var_0 = ( var_0[0], var_0[1] * -1, 0 );
        var_1 = self.angles;
        var_2 = vectortoangles( var_0 );
        var_3 = common_scripts\utility::flat_angle( combineangles( var_1, var_2 ) );
        var_4 = anglestoforward( var_3 ) * length( var_0 );
        self.boost["stick_input"] = var_4;
        wait 0.05;
    }
}

track_player_velocity()
{
    self endon( "death" );
    self endon( "disable_boost_dash" );

    if ( !isdefined( self.boost["player_vel"] ) )
        self.boost["player_vel"] = ( 0, 0, 0 );

    for (;;)
    {
        self.boost["player_vel"] = self getvelocity();
        wait 0.05;
    }
}

dash()
{
    self endon( "death" );
    self endon( "disable_boost_dash" );

    for (;;)
    {
        waittill_dash_button_pressed();
        var_0 = 400;
        var_1 = ( 0, 0, 300 );
        var_2 = 0.5;
        var_3 = 1;
        var_4 = 700;

        if ( self isonground() && !self adsbuttonpressed() )
            thread boost_dash( var_0, var_1, var_2, var_3, var_4 );

        waittill_dash_button_released();
    }
}

boost_dash( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "mode_switch" );
    self endon( "death" );
    self.boost["inboost"] = 1;
    earthquake( 0.3, 1, self.origin, 300 );
    var_6 = self.boost["stick_input"];
    var_7 = self.boost["player_vel"] * var_2;

    if ( var_7[2] > 0 )
        var_7 = ( var_7[0], var_7[1], 0 );

    var_8 = var_7 + var_6 * var_0 + var_1;

    if ( isdefined( var_3 ) && var_3 )
    {
        if ( !isdefined( var_4 ) )
            var_9 = var_1[2];

        var_10 = var_8;
        var_8 = vectornormalize( var_8 ) * var_4;
        var_8 = ( var_8[0], var_8[1], var_10[2] );

        if ( var_6[2] == 0 )
        {
            var_11 = 0.7;
            var_8 = ( var_8[0], var_8[1], var_8[2] * var_11 );
        }
    }

    var_12 = 2;

    if ( isdefined( var_5 ) && var_5 )
    {
        var_13 = 0;
        var_14 = self.boost["player_vel"];
        var_15 = var_8;
        var_16 = var_15 - var_14;

        for ( var_17 = var_16 / var_12; var_13 <= var_12; var_13++ )
        {
            self setvelocity( var_14 + var_17 );
            wait 0.05;
        }
    }

    self setvelocity( var_8 );
}

waittill_dash_button_pressed()
{
    self endon( "death" );

    while ( !self sprintbuttonpressed() )
        wait 0.05;

    return 1;
}

waittill_dash_button_released()
{
    self endon( "death" );

    while ( self sprintbuttonpressed() )
        wait 0.05;

    return 1;
}
