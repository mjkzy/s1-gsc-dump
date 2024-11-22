// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

script_print_fx()
{
    if ( !isdefined( self.script_fxid ) || !isdefined( self.script_fxcommand ) || !isdefined( self.script_delay ) )
    {
        self delete();
        return;
    }

    if ( isdefined( self.target ) )
        var_0 = getent( self.target ).origin;
    else
        var_0 = "undefined";

    if ( self.script_fxcommand == "OneShotfx" )
    {

    }

    if ( self.script_fxcommand == "loopfx" )
    {

    }

    if ( self.script_fxcommand == "loopsound" )
        return;
}

grenadeexplosionfx( var_0 )
{
    playfx( level._effect["mechanical explosion"], var_0 );
    earthquake( 0.15, 0.5, var_0, 250 );
}

soundfx( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_3.origin = var_1;
    var_3 playloopsound( var_0 );

    if ( isdefined( var_2 ) )
        var_3 thread soundfxdelete( var_2 );
}

soundfxdelete( var_0 )
{
    level waittill( var_0 );
    self delete();
}

blenddelete( var_0 )
{
    self waittill( "death" );
    var_0 delete();
}
