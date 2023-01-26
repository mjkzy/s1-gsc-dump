// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    level._effect["primer_light"] = loadfx( "vfx/lights/light_beacon_m990_spike" );
    level._effect["na45_explosion"] = loadfx( "vfx/explosion/frag_grenade_default" );
    level._effect["na45_explosion_body"] = loadfx( "vfx/explosion/frag_grenade_default_nodecal" );
    thread _id_5DCA();
}

is_na45( var_0 )
{
    if ( issubstr( var_0, "m990" ) || issubstr( var_0, "dlcgun10loot0" ) )
        return 1;

    return 0;
}

_id_5DCA()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    childthread _id_7433();

    for (;;)
    {
        var_0 = self getcurrentweapon();

        if ( is_na45( var_0 ) )
            self.bullethitcallback = ::_id_58C0;
        else
            self.bullethitcallback = undefined;

        self waittill( "weapon_change" );
    }
}

_id_96E7( var_0, var_1 )
{
    self endon( "primer_deleted" );
    var_0 waittill( "death" );
    var_2 = var_0 _meth_842C();

    if ( isdefined( var_2 ) )
    {
        if ( isdefined( var_1 ) )
            self._id_6F8F linkto( var_2, var_1 );
        else
            self._id_6F8F linkto( var_2 );

        self._id_6F8F thread _id_84E4( self );
    }
}

_id_58C0( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !is_na45( var_0 ) )
        return;

    if ( self getcurrentweapon() != var_0 )
        return;

    var_6 = _id_3D1E();

    if ( var_6 == "primer" )
    {
        if ( isdefined( self._id_6F8F ) )
            _id_282F();

        self._id_6F8F = common_scripts\utility::spawn_tag_origin();

        if ( isdefined( var_3 ) && ( isplayer( var_3 ) || isagent( var_3 ) ) )
        {
            self._id_6F8F.origin = var_1 + var_4;
            self._id_6F8F.angles = vectortoangles( var_4 * -1 );
        }
        else
        {
            self._id_6F8F.origin = var_1;
            self._id_6F8F.angles = vectortoangles( var_2 );
        }

        self._id_6F8F show();
        self._id_6F8F thread _id_84E4( self );

        if ( isdefined( var_3 ) )
        {
            var_7 = var_3;

            if ( isplayer( var_3 ) || isagent( var_3 ) )
            {
                if ( isalive( var_3 ) )
                    thread _id_96E7( var_3, var_5 );
                else
                {
                    var_8 = var_3 _meth_842C();

                    if ( isdefined( var_8 ) )
                        var_7 = var_8;
                }

                self._id_6F8F._id_6453 = 1;
            }

            if ( isdefined( var_5 ) )
                self._id_6F8F linkto( var_7, var_5 );
            else
                self._id_6F8F linkto( var_7 );
        }

        thread _id_1E7B();
    }
    else if ( isdefined( self._id_6F8F ) )
    {
        if ( distance( var_1, self._id_6F8F.origin ) <= 64 )
        {
            if ( isdefined( self._id_6F8F._id_6453 ) )
                playfx( common_scripts\utility::getfx( "na45_explosion_body" ), self._id_6F8F.origin, anglestoforward( self._id_6F8F.angles ) );
            else
                playfx( common_scripts\utility::getfx( "na45_explosion" ), self._id_6F8F.origin, anglestoforward( self._id_6F8F.angles ) );

            playsoundatpos( self.origin, "wpn_na45_exp" );
            var_0 = self getcurrentweapon();
            var_9 = 256;
            var_10 = 130;
            var_11 = 15;

            if ( issubstr( var_0, "m990loot2" ) )
                var_11 = 30;

            if ( issubstr( var_0, "m990loot5" ) )
            {
                var_10 = 100;
                var_9 = 196;
            }

            if ( issubstr( var_0, "m990loot8" ) )
                var_10 = 100;

            if ( issubstr( var_0, "m990loot9" ) || issubstr( var_0, "dlcgun10loot0" ) )
            {
                var_11 = 30;
                var_10 = 150;
                var_9 = 300;
            }

            physicsexplosionsphere( self._id_6F8F.origin, 256, 32, 1.0 );
            radiusdamage( self._id_6F8F.origin, var_9, var_10, var_11, self, "MOD_EXPLOSIVE", var_0 );
        }

        _id_282F();
    }
}

_id_7433()
{
    for (;;)
    {
        self waittill( "reload_start" );
        var_0 = self getcurrentweapon();

        if ( !is_na45( var_0 ) )
        {
            self waittill( "weapon_change" );
            continue;
        }

        _id_1E7C();
    }
}

_id_1E7B()
{
    self endon( "primer_deleted" );
    common_scripts\utility::waittill_any( "death", "disconnect", "faux_spawn" );

    if ( isdefined( self ) && isdefined( self._id_6F8F ) )
        thread _id_282F();
}

_id_1E7C()
{
    self endon( "primer_deleted" );

    if ( isdefined( self ) && isdefined( self._id_6F8F ) )
        thread _id_282F();
}

_id_3D1E()
{
    var_0 = self _meth_82F0();

    if ( var_0 % 2 == 1 )
        return "primer";
    else
        return "catalyst";
}

_id_84E4( var_0 )
{
    self endon( "death" );
    wait 0.1;
    playfxontagforclients( common_scripts\utility::getfx( "primer_light" ), self, "TAG_ORIGIN", var_0 );
}

_id_282F()
{
    self notify( "primer_deleted" );
    stopfxontag( common_scripts\utility::getfx( "primer_light" ), self._id_6F8F, "TAG_ORIGIN" );
    self._id_6F8F delete();
    self._id_6F8F = undefined;
}

_id_2DAF( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = ( 1.0, 0.0, 0.0 );

    while ( var_2 > 0 )
    {
        var_2 -= 0.05;
        wait 0.05;
    }
}
