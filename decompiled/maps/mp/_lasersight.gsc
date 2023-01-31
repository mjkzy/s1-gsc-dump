// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

lasersight_think()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self.laser_on = undefined;
    self.wasemp = 0;
    self.has_laser = 0;

    for (;;)
    {
        while ( maps\mp\_utility::isemped() && self.has_laser )
        {
            wait 0.05;
            self _meth_80B3();
            self.wasemp = 1;
            continue;
        }

        if ( self.wasemp && self.has_laser )
        {
            self.wasemp = 0;
            self _meth_80B2( get_laser_name() );
        }

        if ( issubstr( self _meth_8311(), "maaws" ) || issubstr( self _meth_8311(), "dlcgun11loot3" ) )
            self.has_laser = 1;

        if ( self.has_laser && self _meth_812C() )
        {
            if ( isdefined( self.laser_on ) && self.laser_on )
            {
                self _meth_80B3();
                self.laser_on = 0;

                while ( !self _meth_84E0() && self _meth_812C() )
                    wait 0.05;

                while ( self _meth_84E0() && self _meth_812C() )
                    wait 0.05;

                while ( self _meth_812C() )
                    wait 0.05;

                self _meth_80B2( get_laser_name() );
                self.laser_on = 1;
            }
        }

        if ( !self.has_laser )
        {
            if ( isdefined( self.laser_on ) && self.laser_on )
            {
                self _meth_80B3();
                self.laser_on = 0;
            }
        }
        else if ( !isdefined( self.laser_on ) || !self.laser_on )
        {
            self _meth_80B2( get_laser_name() );
            self.laser_on = 1;
        }

        wait 0.05;
    }
}

get_laser_name()
{
    var_0 = self _meth_8311();

    if ( issubstr( var_0, "_dlcgun10loot5" ) || maps\mp\gametypes\_class::isexoxmg( var_0 ) || maps\mp\gametypes\_class::issac3( var_0 ) )
        return "mp_attachment_lasersight_short";

    return "mp_attachment_lasersight";
}
