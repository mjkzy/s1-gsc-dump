// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

lasersight_think()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self._id_54D7 = undefined;
    self._id_A1BE = 0;
    self.has_laser = 0;

    for (;;)
    {
        while ( maps\mp\_utility::isemped() && self.has_laser )
        {
            wait 0.05;
            self laseroff();
            self._id_A1BE = 1;
            continue;
        }

        if ( self._id_A1BE && self.has_laser )
        {
            self._id_A1BE = 0;
            self laseron( get_laser_name() );
        }

        if ( issubstr( self getcurrentweapon(), "maaws" ) || issubstr( self getcurrentweapon(), "dlcgun11loot3" ) )
            self.has_laser = 1;

        if ( self.has_laser && self _meth_812C() )
        {
            if ( isdefined( self._id_54D7 ) && self._id_54D7 )
            {
                self laseroff();
                self._id_54D7 = 0;

                while ( !self _meth_84E0() && self _meth_812C() )
                    wait 0.05;

                while ( self _meth_84E0() && self _meth_812C() )
                    wait 0.05;

                while ( self _meth_812C() )
                    wait 0.05;

                self laseron( get_laser_name() );
                self._id_54D7 = 1;
            }
        }

        if ( !self.has_laser )
        {
            if ( isdefined( self._id_54D7 ) && self._id_54D7 )
            {
                self laseroff();
                self._id_54D7 = 0;
            }
        }
        else if ( !isdefined( self._id_54D7 ) || !self._id_54D7 )
        {
            self laseron( get_laser_name() );
            self._id_54D7 = 1;
        }

        wait 0.05;
    }
}

get_laser_name()
{
    var_0 = self getcurrentweapon();

    if ( issubstr( var_0, "_dlcgun10loot5" ) || maps\mp\gametypes\_class::isexoxmg( var_0 ) || maps\mp\gametypes\_class::issac3( var_0 ) )
        return "mp_attachment_lasersight_short";

    return "mp_attachment_lasersight";
}
