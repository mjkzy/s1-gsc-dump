// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_7AA2()
{
    if ( !isdefined( self._id_79EC ) || !isdefined( self._id_79EB ) || !isdefined( self.script_delay ) )
    {
        self delete();
        return;
    }

    if ( isdefined( self.target ) )
        var_0 = getent( self.target ).origin;
    else
        var_0 = "undefined";

    if ( self._id_79EB == "OneShotfx" )
    {

    }

    if ( self._id_79EB == "loopfx" )
    {

    }

    if ( self._id_79EB == "loopsound" )
        return;
}

_id_43FC( var_0 )
{
    playfx( level._effect["mechanical explosion"], var_0 );
    earthquake( 0.15, 0.5, var_0, 250 );
}

_id_88A6( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_origin", ( 0.0, 0.0, 0.0 ) );
    var_3.origin = var_1;
    var_3 playloopsound( var_0 );

    if ( isdefined( var_2 ) )
        var_3 thread _id_88A7( var_2 );
}

_id_88A7( var_0 )
{
    level waittill( var_0 );
    self delete();
}

_id_14A1( var_0 )
{
    self waittill( "death" );
    var_0 delete();
}
