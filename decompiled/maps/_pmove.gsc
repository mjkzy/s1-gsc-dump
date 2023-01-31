// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

pm_projectvelocity( var_0, var_1 )
{
    var_2 = lengthsquared( ( var_0[0], var_0[1], 0 ) );

    if ( abs( var_1[2] ) < 0.001 || var_2 <= 0.0001 )
    {

    }
    else
    {
        var_3 = -1 * ( var_0[0] * var_1[0] + var_0[1] * var_1[1] ) / var_1[2];
        var_4 = ( var_0[0], var_0[1], var_3 );
        var_5 = var_2 + var_0[2] * var_0[2];
        var_6 = var_2 + var_3 * var_3;
        var_7 = sqrt( var_5 / var_6 );

        if ( var_7 < 1 || var_3 < 0 || var_0[2] > 0 )
            var_0 = var_7 * var_0;
    }

    return var_0;
}

pm_clipvelocity( var_0, var_1 )
{
    var_2 = vectordot( var_0, var_1 );
    var_2 -= 0.001 * abs( var_2 );
    var_0 -= var_2 * var_1;
    return var_0;
}

pm_permuterestrictiveclipplanes( var_0, var_1, var_2 )
{
    var_3 = [];

    for ( var_4 = 0; var_4 < var_1.size; var_4++ )
    {
        var_3[var_4] = vectordot( var_0, var_1[var_4] );

        for ( var_5 = var_4; var_5 > 0; var_5-- )
        {
            if ( var_3[var_2[var_5 - 1]] < var_3[var_4] )
                break;

            var_2[var_5] = var_2[var_5 - 1];
        }

        var_2[var_5] = var_4;
    }

    var_6["parallel"] = var_3[var_2[0]];
    var_6["permutation"] = var_2;
    return var_6;
}

pm_slidemove( var_0, var_1, var_2 )
{
    var_3 = 4;
    var_4 = var_0.vel;
    var_5 = var_0.vel;
    var_6 = 0.05;
    var_7[0] = var_1;
    var_7[1] = vectornormalize( var_0.vel );
    var_8 = [];

    for ( var_9 = 0; var_9 < var_3; var_9++ )
    {
        var_10 = var_0.origin + var_6 * var_0.vel;
        var_11 = _func_238( var_0.origin, var_10, self );
        var_12 = var_11["position"];

        if ( var_11["fraction"] < 1 )
            var_1 = var_11["normal"];
        else
            var_1 = ( 0, 0, 0 );

        var_13 = var_11["fraction"];

        if ( var_13 > 0 )
            var_0.origin = var_12;

        var_6 -= var_6 * var_13;

        if ( var_7.size >= 8 )
        {
            var_0.vel = ( 0, 0, 0 );
            return 1;
        }

        for ( var_14 = 0; var_14 < var_7.size; var_14++ )
        {
            if ( vectordot( var_1, var_7[var_14] ) > 0.999 )
            {
                var_0.vel = pm_clipvelocity( var_0.vel, var_1 );
                var_0.vel += var_1;
                break;
            }
        }

        if ( var_14 < var_7.size )
            continue;

        var_7[var_7.size] = var_1;
        var_15 = pm_permuterestrictiveclipplanes( var_0.vel, var_7, var_8 );
        var_16 = var_15["parallel"];
        var_8 = var_15["permutation"];

        if ( var_16 >= 0.1 )
            continue;

        var_17 = pm_clipvelocity( var_0.vel, var_7[var_8[0]] );
        var_18 = pm_clipvelocity( var_5, var_7[var_8[0]] );

        for ( var_19 = 1; var_19 < var_7.size; var_19++ )
        {
            if ( vectordot( var_17, var_7[var_8[var_19]] ) >= 0.1 )
                continue;

            var_17 = pm_clipvelocity( var_17, var_7[var_8[var_19]] );
            var_18 = pm_clipvelocity( var_18, var_7[var_8[var_19]] );

            if ( vectordot( var_17, var_7[var_8[0]] ) >= 0 )
                continue;

            var_20 = vectorcross( var_7[var_8[0]], var_7[var_8[var_19]] );
            var_20 = vectornormalize( var_20 );
            var_21 = vectordot( var_20, var_0.vel );
            var_17 = var_21 * var_20;
            var_21 = vectordot( var_20, var_5 );
            var_5 = var_21 * var_20;

            for ( var_22 = 1; var_22 < var_7.size; var_22++ )
            {
                if ( var_22 == var_19 )
                    continue;

                if ( vectordot( var_17, var_7[var_8[var_22]] ) >= 0.1 )
                    continue;

                var_0.vel = ( 0, 0, 0 );
                return 1;
            }
        }

        var_0.velocity = var_17;
        var_5 = var_18;
    }

    if ( var_2 )
        var_0.vel = var_5;

    return var_9 != 0;
}

vec2dot( var_0, var_1 )
{
    return var_0[0] * var_1[0] + var_0[1] * var_1[1];
}

pm_stepslidemove( var_0, var_1, var_2 )
{
    var_3 = var_0.origin;
    var_4 = var_0.vel;
    var_5 = pm_slidemove( var_0, var_1, var_2 );
    var_6 = 18;
    var_7 = 18;
    var_8 = 1;
    var_9 = var_0.origin;
    var_10 = var_0.vel;
    var_11 = var_9 - var_3;
    var_12 = 0;

    if ( var_5 || var_1[2] < 0.9 )
    {
        var_13 = var_3 + ( 0, 0, var_6 + 1 );
        var_14 = _func_238( var_3, var_13, self );
        var_12 = var_14["fraction"] * ( var_6 + 1 ) - 1;

        if ( var_12 < 1.0 )
            var_12 = 0;
        else
        {
            var_0.origin = ( var_13[0], var_13[1], var_3[2] + var_12 );
            var_0.vel = var_4;
            pm_slidemove( var_0, var_1, var_2 );
        }
    }

    if ( var_8 || var_12 )
    {
        var_15 = var_0.origin - ( 0, 0, var_12 );

        if ( var_8 )
            var_15 -= ( 0, 0, var_7 * 0.5 );

        var_14 = _func_238( var_0.origin, var_15, self );

        if ( var_14["fraction"] < 1 )
        {
            var_0.origin = var_14["position"];

            if ( var_12 && var_0.origin[2] - max( var_9[2], var_3[2] ) > 2.0 * var_6 * var_14["normal"][2] )
            {
                var_0.origin = var_9;
                var_0.vel = var_10;
                return;
            }

            var_0.vel = pm_projectvelocity( var_0.vel, var_14["normal"] );
        }
        else if ( var_12 )
            var_0.origin -= ( 0, 0, var_12 );
    }

    var_16 = var_0.origin - var_3;
    var_16 = ( var_16[0], var_16[1], 0 );
    var_17 = vec2dot( var_16, var_4 ) <= vec2dot( var_11, var_4 ) + 0.001;

    if ( var_17 )
    {
        var_9 = var_0.origin;
        var_10 = var_0.vel;
        var_12 = 0;

        if ( var_8 )
        {
            var_15 = var_0.origin - ( 0, 0, var_7 * 0.5 );
            var_14 = _func_238( var_0.origin, var_15, self );

            if ( var_14["fraction"] < 1.0 )
            {
                var_12 = var_14["position"][2] - var_0.origin[2];
                var_0.origin = var_14["position"];
                var_0.vel = pm_clipvelocity( var_0.vel, var_14["normal"] );
            }
        }
    }
}
