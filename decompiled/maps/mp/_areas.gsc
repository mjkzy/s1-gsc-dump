// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level._id_885A = getentarray( "trigger_multiple_softlanding", "classname" );
    var_0 = getentarray( "destructible_vehicle", "targetname" );

    foreach ( var_2 in level._id_885A )
    {
        if ( var_2._id_7AFF != "car" )
            continue;

        foreach ( var_4 in var_0 )
        {
            if ( distance( var_2.origin, var_4.origin ) > 64.0 )
                continue;

            var_2._id_28F8 = var_4;
        }
    }

    thread onplayerconnect();
}

onplayerconnect()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0._id_8859 = undefined;
        var_0 thread _id_885B();
    }
}

_id_6C9A( var_0 )
{
    self._id_8859 = var_0;
}

_id_6CDC( var_0 )
{
    self._id_8859 = undefined;
}

_id_885B()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "soft_landing", var_0, var_1 );

        if ( !isdefined( var_0._id_28F8 ) )
            continue;
    }
}
