// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_A05C()
{
    while ( !isdefined( level._id_19D9 ) || !level._id_19D9 )
        wait 0.5;
}

_id_3CB0()
{
    if ( isdefined( level._id_088B ) )
        return ( 0, 0, level._id_088B );
    else
        return ( 0.0, 0.0, 500.0 );
}

_id_3D88()
{
    if ( isdefined( level._id_088A ) )
    {
        if ( level.nextgen )
        {

        }
        else
        {

        }

        return level._id_088A;
    }
    else
        return 250;
}

_id_6124( var_0 )
{
    return var_0.type == "Path" && _func_20C( var_0, 1 ) && !var_0 _meth_8386() || isdefined( var_0.forceenableaerialnode ) && var_0.forceenableaerialnode;
}

_id_19C5()
{
    if ( isdefined( level._id_19DA ) || isdefined( level._id_19D9 ) )
        return;

    var_0 = getdvar( "mapname" );

    if ( var_0 == getdvar( "virtualLobbyMap" ) || var_0 == "mp_character_room" || getdvarint( "virtualLobbyActive" ) == 1 )
        return;

    level._id_19DA = 1;
    level._id_19D9 = 0;
    wait 0.5;
    level._id_088C = [];
    var_1 = getallnodes();

    foreach ( var_3 in var_1 )
    {
        if ( _id_6124( var_3 ) )
        {
            level._id_088C[level._id_088C.size] = var_3;

            if ( !isdefined( var_3._id_0889 ) )
                var_3._id_0889 = [];

            var_4 = getlinkednodes( var_3 );

            foreach ( var_6 in var_4 )
            {
                if ( _id_6124( var_6 ) && !common_scripts\utility::array_contains( var_3._id_0889, var_6 ) )
                {
                    var_3._id_0889[var_3._id_0889.size] = var_6;

                    if ( !isdefined( var_6._id_0889 ) )
                        var_6._id_0889 = [];

                    if ( !common_scripts\utility::array_contains( var_6._id_0889, var_3 ) )
                        var_6._id_0889[var_6._id_0889.size] = var_3;
                }
            }
        }
    }

    var_1 = undefined;
    wait 0.05;
    var_9 = _id_2B9D( level._id_088C, 1 );
    var_10 = 3;

    if ( !0 )
    {
        var_11 = _id_3D88();
        var_12 = [];
        var_13 = 0;

        for ( var_14 = 0; var_14 < var_9.size; var_14++ )
        {
            if ( !isdefined( var_12[var_14] ) )
                var_12[var_14] = [];

            foreach ( var_3 in var_9[var_14] )
            {
                for ( var_16 = var_14 + 1; var_16 < var_9.size; var_16++ )
                {
                    if ( !isdefined( var_12[var_14][var_16] ) )
                        var_12[var_14][var_16] = [];

                    var_17 = [];

                    foreach ( var_19 in var_9[var_16] )
                    {
                        var_20 = distance( var_3.origin, var_19.origin );
                        var_21 = var_20 < var_11;
                        var_22 = 0;

                        if ( !var_21 )
                        {
                            if ( isdefined( level._id_088D ) )
                            {
                                foreach ( var_24 in level._id_088D )
                                {
                                    var_25 = squared( var_24.radius );

                                    if ( _func_220( var_24.origin, var_3.origin ) < var_25 && _func_220( var_24.origin, var_19.origin ) < var_25 )
                                    {
                                        var_22 = 1;
                                        break;
                                    }
                                }
                            }
                        }

                        var_27 = var_17.size < var_10 || var_20 < var_17[var_10 - 1][2];

                        if ( var_21 && var_27 )
                        {
                            if ( var_17.size == var_10 )
                                var_17[var_10 - 1] = undefined;

                            var_17[var_17.size] = [ var_3, var_19, var_20 ];
                            var_17 = common_scripts\utility::array_sort_with_func( var_17, ::_id_505A );
                            continue;
                        }

                        if ( var_22 )
                            var_12[var_14][var_16][var_12[var_14][var_16].size] = [ var_3, var_19, -1 ];
                    }

                    foreach ( var_30 in var_17 )
                        var_12[var_14][var_16][var_12[var_14][var_16].size] = var_30;
                }

                var_13++;

                if ( var_13 >= 50 )
                {
                    var_13 = 0;
                    wait 0.05;
                }
            }
        }

        wait 0.05;
        var_33 = 0;

        for ( var_14 = 0; var_14 < var_9.size; var_14++ )
        {
            for ( var_16 = var_14 + 1; var_16 < var_9.size; var_16++ )
            {
                var_33 += var_12[var_14][var_16].size;
                var_12[var_14][var_16] = common_scripts\utility::array_sort_with_func( var_12[var_14][var_16], ::_id_505A, 150 );

                if ( var_33 > 500 )
                {
                    wait 0.05;
                    var_33 = 0;
                }
            }
        }

        wait 0.05;
        var_34 = _id_3CB0();
        var_35 = 10;
        var_36 = 0;

        if ( 0 )
            level._id_07E0 = [];

        for ( var_14 = 0; var_14 < var_9.size; var_14++ )
        {
            for ( var_16 = var_14 + 1; var_16 < var_9.size; var_16++ )
            {
                foreach ( var_38 in var_12[var_14][var_16] )
                {
                    var_39 = var_38[0];
                    var_40 = var_38[1];

                    if ( !_id_612A( var_39, var_40 ) )
                    {
                        var_41 = _id_6284( var_39, var_40._id_0888 );
                        var_42 = _id_6284( var_40, var_39._id_0888 );

                        if ( var_41 < var_10 && var_42 < var_10 )
                        {
                            var_43 = playerphysicstrace( var_39.origin + var_34, var_40.origin + var_34 );
                            var_36++;
                            var_44 = distancesquared( var_43, var_40.origin + var_34 ) < 1;

                            if ( !var_44 && var_38[2] == -1 )
                                var_44 = bullettracepassed( var_39.origin + var_34, var_40.origin + var_34, 0, undefined );

                            if ( var_44 )
                            {
                                var_39._id_0889[var_39._id_0889.size] = var_40;
                                var_40._id_0889[var_40._id_0889.size] = var_39;

                                if ( 0 )
                                    level._id_07E0[level._id_07E0.size] = [ var_39, var_40 ];
                            }

                            if ( var_36 % var_35 == 0 )
                                wait 0.05;
                        }
                    }
                }
            }
        }

        var_12 = undefined;
        var_9 = _id_2B9D( level._id_088C );

        if ( 0 )
        {
            var_9 = common_scripts\utility::array_sort_with_func( var_9, ::_id_5031 );

            for ( var_14 = 0; var_14 < var_9.size; var_14++ )
            {
                foreach ( var_3 in var_9[var_14] )
                    var_3._id_0888 = var_14;
            }
        }
        else
        {
            foreach ( var_3 in level._id_088C )
                var_3._id_0888 = undefined;
        }

        var_50 = 0;

        for ( var_14 = 0; var_14 < var_9.size; var_14++ )
            var_50 = max( var_9[var_14].size, var_50 );

        for ( var_14 = 0; var_14 < var_9.size; var_14++ )
        {
            if ( var_9[var_14].size < 0.1 * var_50 )
            {
                foreach ( var_3 in var_9[var_14] )
                {
                    level._id_088C = common_scripts\utility::array_remove( level._id_088C, var_3 );

                    foreach ( var_6 in var_3._id_0889 )
                    {
                        for ( var_16 = 0; var_16 < var_6._id_0889.size; var_16++ )
                        {
                            var_53 = var_6._id_0889[var_16];

                            if ( var_53 == var_3 )
                            {
                                var_6._id_0889[var_16] = var_6._id_0889[var_6._id_0889.size - 1];
                                var_6._id_0889[var_6._id_0889.size - 1] = undefined;
                                var_16--;
                            }
                        }
                    }

                    var_3._id_0889 = undefined;
                }
            }
        }
    }

    level._id_19D9 = 1;
    level._id_19DA = 0;
}

_id_5031( var_0, var_1 )
{
    return var_0.size > var_1.size;
}

_id_505A( var_0, var_1 )
{
    return var_0[2] < var_1[2];
}

_id_6284( var_0, var_1 )
{
    var_2 = 0;

    foreach ( var_4 in var_0._id_0889 )
    {
        if ( var_4._id_0888 == var_1 )
            var_2++;
    }

    return var_2;
}

_id_612A( var_0, var_1 )
{
    foreach ( var_3 in var_0._id_0889 )
    {
        foreach ( var_5 in var_3._id_0889 )
        {
            if ( var_5 == var_1 )
                return 1;
        }
    }

    return 0;
}

_id_2B9D( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0;

    foreach ( var_3 in var_0 )
        var_3._id_0888 = undefined;

    var_5 = var_0;
    var_6 = [];

    while ( var_5.size > 0 )
    {
        var_7 = var_6.size;
        var_6[var_7] = [];
        var_5[0]._id_0888 = -1;
        var_8 = [ var_5[0] ];
        var_9 = 0;

        while ( var_8.size > 0 )
        {
            var_10 = var_8[0];
            var_6[var_7][var_6[var_7].size] = var_10;
            var_10._id_0888 = var_7;
            var_8[0] = var_8[var_8.size - 1];
            var_8[var_8.size - 1] = undefined;

            foreach ( var_12 in var_10._id_0889 )
            {
                if ( !isdefined( var_12._id_0888 ) )
                {
                    var_12._id_0888 = -1;
                    var_8[var_8.size] = var_12;
                }
            }

            for ( var_14 = 0; var_14 < var_5.size; var_14++ )
            {
                if ( var_5[var_14] == var_10 )
                {
                    var_5[var_14] = var_5[var_5.size - 1];
                    var_5[var_5.size - 1] = undefined;
                    break;
                }
            }

            var_9++;

            if ( var_9 > 100 )
            {
                wait 0.05;
                var_9 = 0;
            }
        }

        if ( var_6[var_7].size <= var_1 )
        {
            var_6[var_7] = undefined;
            continue;
        }

        wait 0.05;
    }

    wait 0.05;
    return var_6;
}

_id_6121( var_0 )
{
    return isdefined( var_0._id_0889 );
}

_id_3D52( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 1500;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    var_2 = getnodesinradiussorted( self.origin, var_0, var_1, _id_3CB0()[2] * 2, "path" );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        if ( _id_6121( var_2[var_3] ) )
            return var_2[var_3];
    }
}

_id_376A( var_0, var_1 )
{
    var_0._id_66CD = [];
    var_2 = [ var_0 ];
    var_3 = [ var_0 ];

    while ( !isdefined( var_1._id_66CD ) )
    {
        var_4 = var_2[0];
        var_2 = common_scripts\utility::array_remove( var_2, var_4 );

        foreach ( var_6 in var_4._id_0889 )
        {
            if ( !isdefined( var_6._id_66CD ) )
            {
                var_6._id_66CD = common_scripts\utility::array_add( var_4._id_66CD, var_4 );
                var_2[var_2.size] = var_6;
                var_3[var_3.size] = var_6;
            }
        }
    }

    var_8 = common_scripts\utility::array_add( var_1._id_66CD, var_1 );

    foreach ( var_10 in var_3 )
        var_10._id_66CD = undefined;

    return var_8;
}
