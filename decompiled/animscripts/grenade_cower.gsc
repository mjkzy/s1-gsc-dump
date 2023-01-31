// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

main()
{
    self endon( "killanimscript" );
    animscripts\utility::initialize( "grenadecower" );

    if ( isdefined( self.grenadecowerfunction ) )
    {
        self [[ self.grenadecowerfunction ]]();
        return;
    }

    if ( isdefined( self.team ) )
        maps\_dds::dds_notify( "react_grenade", self.team == "allies" );

    if ( self.a.pose == "prone" )
    {
        animscripts\stop::main();
        return;
    }

    self _meth_818E( "zonly_physics" );
    self _meth_818F( "face angle", self.angles[1] );
    var_0 = 0;

    if ( isdefined( self.grenade ) )
        var_0 = angleclamp180( vectortoangles( self.grenade.origin - self.origin )[1] - self.angles[1] );
    else
        var_0 = self.angles[1];

    if ( self.a.pose == "stand" )
    {
        if ( isdefined( self.grenade ) && trydive( var_0 ) )
            return;

        self _meth_8110( "cowerstart", animscripts\utility::lookupanim( "grenade", "cower_squat" ), %body, 1, 0.2 );
        animscripts\shared::donotetracks( "cowerstart" );
    }

    self.a.pose = "crouch";
    self.a.movement = "stop";
    self _meth_8110( "cower", animscripts\utility::lookupanim( "grenade", "cower_squat_idle" ), %body, 1, 0.2 );
    animscripts\shared::donotetracks( "cower" );
    self waittill( "never" );
}

end_script()
{
    self.safetochangescript = 1;
}

trydive( var_0 )
{
    if ( randomint( 2 ) == 0 )
        return 0;

    if ( self.stairsstate != "none" )
        return 0;

    var_1 = undefined;

    if ( abs( var_0 ) > 90 )
        var_1 = animscripts\utility::lookupanim( "grenade", "cower_dive_back" );
    else
        var_1 = animscripts\utility::lookupanim( "grenade", "cower_dive_front" );

    var_2 = getmovedelta( var_1, 0, 0.5 );
    var_3 = self _meth_81B0( var_2 );

    if ( !self _meth_81C3( var_3 ) )
        return 0;

    self.safetochangescript = 0;
    self _meth_8110( "cowerstart", var_1, %body, 1, 0.2 );
    animscripts\shared::donotetracks( "cowerstart" );
    self.safetochangescript = 1;
    return 1;
}
