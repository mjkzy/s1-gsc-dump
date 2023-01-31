// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0 )
{
    self endon( "killanimscript" );
    animscripts\utility::initialize( "saw" );

    if ( !isdefined( var_0 ) )
        return;

    self.a.special = "saw";

    if ( isdefined( var_0.script_delay_min ) )
        var_1 = var_0.script_delay_min;
    else
        var_1 = maps\_mgturret::burst_fire_settings( "delay" );

    if ( isdefined( var_0.script_delay_max ) )
        var_2 = var_0.script_delay_max - var_1;
    else
        var_2 = maps\_mgturret::burst_fire_settings( "delay_range" );

    if ( isdefined( var_0.script_burst_min ) )
        var_3 = var_0.script_burst_min;
    else
        var_3 = maps\_mgturret::burst_fire_settings( "burst" );

    if ( isdefined( var_0.script_burst_max ) )
        var_4 = var_0.script_burst_max - var_3;
    else
        var_4 = maps\_mgturret::burst_fire_settings( "burst_range" );

    var_5 = gettime();
    var_6 = "start";
    animscripts\shared::placeweaponon( self.weapon, "none" );
    var_0 show();

    if ( isdefined( var_0.aiowner ) )
    {
        self.a.postscriptfunc = ::postscriptfunc;
        self.a.usingturret = var_0;
        var_0 notify( "being_used" );
        thread stopusingturretwhennodelost();
    }
    else
        self.a.postscriptfunc = ::preplacedpostscriptfunc;

    var_0.dofiring = 0;
    thread firecontroller( var_0 );
    self _meth_8193( self.primaryturretanim );
    self _meth_8145( self.primaryturretanim, 1, 0.2, 1 );
    self _meth_8146( self.additiveturretidle );
    self _meth_8146( self.additiveturretfire );
    var_0 _meth_8146( var_0.additiveturretidle );
    var_0 _meth_8146( var_0.additiveturretfire );
    var_0 endon( "death" );

    for (;;)
    {
        if ( var_0.dofiring )
        {
            thread doshoot( var_0 );
            waittimeoruntilturretstatechange( randomfloatrange( var_3, var_3 + var_4 ), var_0 );
            var_0 notify( "turretstatechange" );

            if ( var_0.dofiring )
            {
                thread doaim( var_0 );
                wait(randomfloatrange( var_1, var_1 + var_2 ));
            }

            continue;
        }

        thread doaim( var_0 );
        var_0 waittill( "turretstatechange" );
    }
}

waittimeoruntilturretstatechange( var_0, var_1 )
{
    var_1 endon( "turretstatechange" );
    wait(var_0);
}

firecontroller( var_0 )
{
    self endon( "killanimscript" );
    var_1 = cos( 15 );

    for (;;)
    {
        while ( isdefined( self.enemy ) )
        {
            var_2 = self.enemy.origin;
            var_3 = var_0 gettagangles( "tag_aim" );

            if ( common_scripts\utility::within_fov( var_0.origin, var_3, var_2, var_1 ) || distancesquared( var_0.origin, var_2 ) < 40000 )
            {
                if ( !var_0.dofiring )
                {
                    var_0.dofiring = 1;
                    var_0 notify( "turretstatechange" );
                }
            }
            else if ( var_0.dofiring )
            {
                var_0.dofiring = 0;
                var_0 notify( "turretstatechange" );
            }

            wait 0.05;
        }

        if ( var_0.dofiring )
        {
            var_0.dofiring = 0;
            var_0 notify( "turretstatechange" );
        }

        wait 0.05;
    }
}

turrettimer( var_0, var_1 )
{
    if ( var_0 <= 0 )
        return;

    self endon( "killanimscript" );
    var_1 endon( "turretstatechange" );
    wait(var_0);
    var_1 notify( "turretstatechange" );
}

stopusingturretwhennodelost()
{
    self endon( "killanimscript" );

    for (;;)
    {
        if ( !isdefined( self.node ) || distancesquared( self.origin, self.node.origin ) > 4096 )
            self _meth_818B();

        wait 0.25;
    }
}

postscriptfunc( var_0 )
{
    if ( var_0 == "pain" )
    {
        if ( isdefined( self.node ) && distancesquared( self.origin, self.node.origin ) < 4096 )
        {
            self.a.usingturret hide();
            animscripts\shared::placeweaponon( self.weapon, "right" );
            self.a.postscriptfunc = ::postpainfunc;
            return;
        }
        else
            self _meth_818B();
    }

    if ( var_0 == "saw" )
    {
        var_1 = self _meth_8194();
        return;
    }

    self.a.usingturret delete();
    self.a.usingturret = undefined;
    animscripts\shared::placeweaponon( self.weapon, "right" );
}

postpainfunc( var_0 )
{
    if ( !isdefined( self.node ) || distancesquared( self.origin, self.node.origin ) > 4096 )
    {
        self _meth_818B();
        self.a.usingturret delete();
        self.a.usingturret = undefined;

        if ( isdefined( self.weapon ) && self.weapon != "none" )
            animscripts\shared::placeweaponon( self.weapon, "right" );
    }
    else if ( var_0 != "saw" )
        self.a.usingturret delete();
}

preplacedpostscriptfunc( var_0 )
{
    animscripts\shared::placeweaponon( self.weapon, "right" );
}

#using_animtree("generic_human");

doshoot( var_0 )
{
    self _meth_814B( %additive_saw_idle, 0, 0.1 );
    self _meth_814B( %additive_saw_fire, 1, 0.1 );
    var_0 turretdoshootanims();
    turretdoshoot( var_0 );
}

doaim( var_0 )
{
    self _meth_814B( %additive_saw_idle, 1, 0.1 );
    self _meth_814B( %additive_saw_fire, 0, 0.1 );
    var_0 turretdoaimanims();
}

turretdoshoot( var_0 )
{
    self endon( "killanimscript" );
    var_0 endon( "turretstatechange" );

    for (;;)
    {
        var_0 _meth_80EA();
        wait 0.1;
    }
}

#using_animtree("mg42");

turretdoshootanims()
{
    self _meth_814B( %additive_saw_idle, 0, 0.1 );
    self _meth_814B( %additive_saw_fire, 1, 0.1 );
}

turretdoaimanims()
{
    self _meth_814B( %additive_saw_idle, 1, 0.1 );
    self _meth_814B( %additive_saw_fire, 0, 0.1 );
}
