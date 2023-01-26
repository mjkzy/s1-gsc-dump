// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_186D()
{
    var_0 = spawnstruct();
    var_0._id_9310 = undefined;
    var_0._id_931E = 0;
    self._id_2EDD = var_0;
}

_id_67B3()
{
    self notify( "pdrone_update_threat_sensor" );
    self endon( "pdrone_update_threat_sensor" );
    self endon( "death" );
    self endon( "emp_death" );
    var_0 = "allies";

    if ( self._id_7AE9 == "allies" )
        var_0 = "axis";

    for (;;)
    {
        wait 0.05;

        if ( _id_A59A::_id_32D7( "fire_disabled" ) || isdefined( self._id_02EA ) && self._id_02EA || isdefined( self._id_01FC ) && self._id_01FC )
        {
            self._id_2EDD._id_9310 = undefined;
            continue;
        }

        if ( isdefined( self._id_017C ) )
        {
            self._id_2EDD._id_9310 = self._id_017C;
            continue;
        }

        var_1 = _func_0D6( var_0 );

        if ( self._id_7AE9 == "axis" )
            var_1 = common_scripts\utility::array_add( var_1, level.player );

        var_2 = undefined;
        var_3 = -1;

        foreach ( var_5 in var_1 )
        {
            wait 0.05;
            var_6 = _id_19D6( self._id_2EDD, var_5 );

            if ( var_6 > var_3 )
            {
                var_3 = var_6;
                var_2 = var_5;
            }
        }

        self._id_2EDD._id_9310 = var_2;
    }
}

_id_19D6( var_0, var_1 )
{
    var_2 = 0;
    var_3[0] = ::_id_33AE;
    var_3[1] = ::_id_33AD;
    var_3[2] = ::_id_33AC;
    var_3[3] = ::_id_33AA;
    var_3[4] = ::_id_33AB;

    for ( var_4 = 0; var_4 < var_3.size; var_4++ )
    {
        var_5 = self [[ var_3[var_4] ]]( var_1 );

        if ( var_5 < 0 )
            return -1;

        var_2 += var_5;
    }

    return var_2 / var_3.size;
}

_id_33AE( var_0 )
{
    if ( !isdefined( var_0 ) || !isalive( var_0 ) )
        return -1;

    if ( isdefined( var_0.ignoreme ) && var_0.ignoreme == 1 )
        return -1;

    return 1;
}

_id_33AB( var_0 )
{
    if ( self._id_7AE9 == "allies" )
        return 1;

    var_1 = self.origin;

    if ( self _meth_8442( "tag_flash" ) != -1 )
        var_1 = self gettagorigin( "tag_flash" );

    if ( _id_948D( var_1, var_0, undefined ) )
    {
        if ( var_0 == level.player )
            self._id_2EDD._id_931E += 0.05;

        return 1;
    }

    if ( var_0 == level.player )
        self._id_2EDD._id_931E = 0;

    return -1;
}

_id_33AD( var_0 )
{
    var_1 = length( var_0.origin - self.origin );
    var_2 = max( 1 - var_1 / 3000, 0 );
    return var_2;
}

_id_33AC( var_0 )
{
    if ( !isplayer( var_0 ) )
        return 0.8;

    return 1;
}

_id_33AA( var_0 )
{
    if ( self._id_7AE9 == "axis" )
        return 1;

    if ( _id_A59A::_id_8436( self.origin, var_0.origin ) )
        return -1;

    return 1;
}

_id_948D( var_0, var_1, var_2 )
{
    var_3 = bullettrace( var_0, var_1 geteye(), 0, var_2, 0, 0, 0, 0, 0 );

    if ( isdefined( var_3["entity"] ) && var_3["entity"] _id_A59E::_id_51FA() )
    {
        if ( isdefined( var_3["entity"].vehicletype ) && var_3["entity"].vehicletype == "pdrone" )
            return 1;

        var_4 = var_3["entity"] _meth_8257();

        if ( isdefined( var_4 ) && var_4 == var_1 )
            return 1;
    }

    return var_3["fraction"] == 1;
}
