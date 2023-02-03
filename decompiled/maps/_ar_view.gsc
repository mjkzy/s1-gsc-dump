// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

display_ar_box( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "stop_AR_box" );
    var_6 = gettime();
    var_7 = var_3 / 2;
    var_8 = ( 0, 0, var_1 );
    var_9 = ( 0, 0, var_1 + var_4 );
    var_10 = ( var_3 - 10 ) / 2;
    var_11 = ( 0, 0, var_1 + 5 );
    var_12 = ( 0, 0, var_1 + 5 + var_4 - 10 );

    while ( gettime() - var_6 < var_5 * 1000 )
    {
        var_13 = var_0.origin;
        var_14 = vectornormalize( var_13 - level.player.origin );
        var_15 = anglestoup( level.player getangles() );
        var_16 = vectorcross( var_14, var_15 );
        var_17 = [];
        var_17[0] = var_13 + var_8 + -1 * var_7 * var_16 + var_2 * var_16;
        var_17[1] = var_13 + var_9 + -1 * var_7 * var_16 + var_2 * var_16;
        var_17[2] = var_13 + var_9 + var_7 * var_16 + var_2 * var_16;
        var_17[3] = var_13 + var_8 + var_7 * var_16 + var_2 * var_16;
        var_18 = [];

        for ( var_19 = 0; var_19 < var_17.size; var_19++ )
        {
            var_20 = vectornormalize( var_17[( var_19 + 1 ) % var_17.size] - var_17[var_19] );
            var_18[var_18.size] = var_17[var_19];
            var_18[var_18.size] = var_17[var_19] + 20 * var_20;
            var_18[var_18.size] = var_17[( var_19 + 1 ) % var_17.size];
            var_18[var_18.size] = var_17[( var_19 + 1 ) % var_17.size] - 20 * var_20;
        }

        for ( var_19 = 0; var_19 < var_18.size; var_19++ )
            var_19++;

        var_21 = [];
        var_21[0] = var_13 + var_11 + -1 * var_10 * var_16 + var_2 * var_16;
        var_21[1] = var_13 + var_12 + -1 * var_10 * var_16 + var_2 * var_16;
        var_21[2] = var_13 + var_12 + var_10 * var_16 + var_2 * var_16;
        var_21[3] = var_13 + var_11 + var_10 * var_16 + var_2 * var_16;
        var_22 = [];

        for ( var_19 = 0; var_19 < var_21.size; var_19++ )
        {
            var_20 = vectornormalize( var_21[( var_19 + 1 ) % var_21.size] - var_21[var_19] );
            var_22[var_22.size] = var_21[var_19];
            var_22[var_22.size] = var_21[var_19] + 20 * var_20;
            var_22[var_22.size] = var_21[( var_19 + 1 ) % var_21.size];
            var_22[var_22.size] = var_21[( var_19 + 1 ) % var_21.size] - 20 * var_20;
        }

        for ( var_19 = 0; var_19 < var_22.size; var_19++ )
            var_19++;

        wait 0.05;
    }
}

display_ar_line( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "stop_AR_line" );
    var_6 = gettime();
    var_7 = var_3 / 2;
    var_8 = ( 0, 0, var_1 );
    var_9 = ( 0, 0, var_1 + var_4 );
    var_10 = ( var_3 - 10 ) / 2;
    var_11 = ( 0, 0, var_1 - 5 );
    var_12 = ( 0, 0, var_1 + var_4 - 5 );

    while ( gettime() - var_6 < var_5 * 1000 )
    {
        var_13 = var_0.origin;
        var_14 = vectornormalize( var_13 - level.player.origin );
        var_15 = anglestoup( level.player getangles() );
        var_16 = vectorcross( var_14, var_15 );
        var_17 = [];
        var_17[0] = var_13 + var_8 + -1 * var_7 * var_16 + var_2 * var_16;
        var_17[1] = var_13 + var_9 + var_7 * var_16 + var_2 * var_16;

        for ( var_18 = 0; var_18 < var_17.size; var_18++ )
        {

        }

        var_19 = [];
        var_19[0] = var_13 + var_11 + -1 * var_10 * var_16 + var_2 * var_16;
        var_19[1] = var_13 + var_12 + var_10 * var_16 + var_2 * var_16;

        for ( var_18 = 0; var_18 < var_19.size; var_18++ )
        {

        }

        wait 0.05;
    }
}

display_ar_text( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "stop_AR_text" );
    var_6 = gettime();

    while ( gettime() - var_6 < var_5 * 1000 )
    {
        var_7 = var_0.origin;
        var_8 = vectornormalize( var_7 - level.player.origin );
        var_9 = anglestoup( level.player getangles() );
        var_10 = vectorcross( var_8, var_9 );
        var_11 = var_7 + ( 0, 0, var_1 ) + var_2 * var_10;
        wait 0.05;
    }
}
