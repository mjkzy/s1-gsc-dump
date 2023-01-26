// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_7468()
{
    var_0 = _id_4053();
    var_1 = [];

    for ( var_2 = 0; var_2 < var_0; var_2++ )
        var_1[var_2] = [];

    foreach ( var_4 in level.players )
    {
        if ( isalive( var_4 ) )
        {
            var_5 = var_4 _meth_83B7();

            if ( var_5 < var_0 )
            {
                var_6 = var_1[var_5].size;
                var_1[var_5][var_6] = var_4;
            }
        }
    }

    foreach ( var_2, var_5 in var_1 )
    {
        if ( var_5.size > 1 )
        {
            var_9 = tablelookupbyrow( "mp/braggingrights.csv", var_2, 2 );
            var_10 = undefined;
            var_11 = undefined;

            foreach ( var_13 in var_5 )
            {
                var_14 = var_13 maps\mp\_utility::getplayerstat( var_9 );

                if ( !isdefined( var_10 ) || var_14 > var_10 )
                {
                    var_11 = var_13;
                    var_10 = var_14;
                }
            }

            foreach ( var_13 in var_5 )
            {
                if ( var_13 == var_11 )
                {
                    if ( !isdefined( var_13.matchbonus ) )
                        var_13.matchbonus = 0;

                    var_17 = 0;

                    foreach ( var_4 in var_5 )
                    {
                        if ( isdefined( var_4.matchbonus ) )
                            var_17 += var_4.matchbonus;
                    }

                    var_13.matchbonus += var_17;
                    continue;
                }

                var_13._id_1763 = 1;
            }
        }
    }

    foreach ( var_4 in level.players )
    {
        if ( isdefined( var_4._id_1763 ) && var_4._id_1763 )
            var_4.matchbonus = 0;
    }
}

_id_4053()
{
    var_0 = -1;

    for ( var_1 = "temp"; var_1 != ""; var_1 = tablelookupbyrow( "mp/braggingrights.csv", var_0, 0 ) )
        var_0++;

    return var_0;
}
