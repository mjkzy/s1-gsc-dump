// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

opticsthermal_think()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );

    if ( isagent( self ) )
        return;

    var_0 = 0.65;
    self._id_6540 = 0;
    self._id_6575 = 0;
    self.has_opticsthermal = 0;

    for (;;)
    {
        var_1 = !self.has_opticsthermal;
        var_1 |= ( self.has_opticsthermal && self playerads() < var_0 );
        var_1 |= self isusingturret();
        var_1 |= self._id_6575;

        if ( var_1 )
            _id_653E( self );
        else
            _id_653D( self, 0.05 );

        wait 0.05;
    }
}

_id_653D( var_0, var_1 )
{
    if ( var_0._id_6540 )
        return;

    var_0 _meth_84A9( 3 );
    var_0 _meth_84AB( 70, 0, 40, 80 );
    var_0._id_6540 = 1;
}

_id_653E( var_0 )
{
    if ( !var_0._id_6540 )
        return;

    var_0 _meth_84AA();
    var_0._id_6540 = 0;
}
