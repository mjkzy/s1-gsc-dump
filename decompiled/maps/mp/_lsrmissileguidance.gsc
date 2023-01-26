// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

monitor_lsr_missile_launch()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );

    for (;;)
    {
        self waittill( "missile_fire", var_0, var_1 );

        if ( issubstr( var_1, "maaws" ) || issubstr( var_1, "dlcgun11loot3" ) )
        {
            if ( !isdefined( self._id_58AF ) )
            {
                self._id_58AF = spawn( "script_origin", self.origin );
                self._id_58AF.targetname = "lsr_missile";
            }

            self._id_58AF thread _id_58B0( var_0 );
            var_0 thread _id_58AE( self );
        }
    }
}

_id_58AE( var_0 )
{
    self endon( "death" );
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    var_0 endon( "faux_spawn" );

    for (;;)
    {
        if ( var_0 playerads() > 0.3 )
        {
            var_1 = anglestoforward( var_0 getangles() );
            var_2 = var_0 geteye();
            var_3 = var_2 + var_1 * 15000;
            var_4 = bullettrace( var_2, var_3, 1, var_0, 1, 0, 0, 0, 0 );
            var_0._id_58AF.origin = var_4["position"];
            self missile_settargetent( var_0._id_58AF );
        }

        wait 0.05;
    }
}

_id_58B0( var_0 )
{
    if ( !isdefined( self._id_58AD ) )
        self._id_58AD = 1;
    else
        self._id_58AD++;

    var_0 waittill( "death" );
    self._id_58AD--;

    if ( self._id_58AD == 0 )
        self delete();
}
