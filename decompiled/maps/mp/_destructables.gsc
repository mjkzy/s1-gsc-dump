// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    var_0 = getentarray( "destructable", "targetname" );

    if ( getdvar( "scr_destructables" ) == "0" )
    {
        for ( var_1 = 0; var_1 < var_0.size; var_1++ )
            var_0[var_1] delete();
    }
    else
    {
        for ( var_1 = 0; var_1 < var_0.size; var_1++ )
            var_0[var_1] thread _id_28F7();
    }
}

_id_28F7()
{
    var_0 = 40;
    var_1 = 0;

    if ( isdefined( self._id_7928 ) )
        var_0 = self._id_7928;

    if ( isdefined( self._id_7AEE ) )
        var_1 = self._id_7AEE;

    if ( isdefined( self._id_7996 ) )
    {
        var_2 = strtok( self._id_7996, " " );

        for ( var_3 = 0; var_3 < var_2.size; var_3++ )
            _id_14B1( var_2[var_3] );
    }

    if ( isdefined( self._id_79EC ) )
        self._id_3B21 = loadfx( self._id_79EC );

    var_4 = 0;
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage", var_5, var_6 );

        if ( var_5 >= var_1 )
        {
            var_4 += var_5;

            if ( var_4 >= var_0 )
            {
                thread _id_28F6();
                return;
            }
        }
    }
}

_id_28F6()
{
    var_0 = self;

    if ( isdefined( self._id_7996 ) )
    {
        var_1 = strtok( self._id_7996, " " );

        for ( var_2 = 0; var_2 < var_1.size; var_2++ )
            _id_99F4( var_1[var_2] );
    }

    if ( isdefined( var_0._id_3B21 ) )
        playfx( var_0._id_3B21, var_0.origin + ( 0.0, 0.0, 6.0 ) );

    var_0 delete();
}

_id_14B1( var_0 )
{

}

_id_14B2( var_0, var_1 )
{

}

_id_99F4( var_0 )
{

}

_id_99F5( var_0, var_1 )
{

}
