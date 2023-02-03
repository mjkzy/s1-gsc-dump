// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

missile_defense_precache()
{
    level._effect["flare"] = loadfx( "vfx/lensflare/flares_warbird" );
    level.stinger_no_ai = 1;
}

heli_flares_monitor( var_0 )
{
    self.numflares = 2;

    if ( isdefined( var_0 ) )
        self.numflares += var_0;

    thread handleincomingstinger();
}

handleincomingstinger( var_0 )
{
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    self endon( "helicopter_done" );
    var_1 = level.player;

    for (;;)
    {
        level waittill( "stinger_fired", var_1, var_2 );

        if ( !maps\_stingerm7::anystingermissilelockedon( var_2, self ) )
            continue;

        if ( !isdefined( var_2 ) )
            continue;

        if ( isdefined( var_0 ) )
        {
            level thread [[ var_0 ]]( var_2, var_1, var_1.team );
            continue;
        }

        level thread watchmissileproximity( var_2, var_1, var_1.team );
    }
}

watchmissileproximity( var_0, var_1, var_2 )
{
    foreach ( var_4 in var_0 )
    {
        if ( isdefined( var_4.lockedstingertarget ) )
            var_4 thread missilewatchproximity( var_1, var_2, var_4.lockedstingertarget );
    }
}

missilewatchproximity( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_2 endon( "death" );
    var_3 = 5.0;
    var_4 = 3500;

    for (;;)
    {
        if ( !isdefined( var_2 ) )
            break;

        var_5 = var_2 getpointinbounds( 0, 0, 0 );
        var_6 = distance( self.origin, var_5 );

        if ( var_6 < var_4 )
        {
            if ( isdefined( var_2.numflares ) && var_2.numflares > 0 )
            {
                var_2.numflares--;
                var_7 = var_2 deployflares( var_3 );
                playfxontag( level._effect["flare"], var_7, "tag_origin" );

                if ( isdefined( self.delayedlocktargetent ) )
                {
                    self.delayedlocktargetent = var_7;
                    self.delayedlocktargettag = "tag_origin";
                }
                else
                    self missile_settargetent( var_7 );

                return;
            }

            self missile_settargetent( var_2, ( 0, 0, 50 ) );
        }

        wait 0.05;
    }
}

deployflares( var_0 )
{
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1.origin = self gettagorigin( "tag_origin" ) + ( 0, 0, 200 );
    var_1.angles = self.angles;
    var_2 = common_scripts\utility::randomvector( 1 ) + ( 0, 0, 1 );
    var_2 = vectornormalize( var_2 );
    var_3 = var_2 * randomfloatrange( 500, 800 );
    var_1 movegravity( var_3, var_0 );
    var_1 thread deleteaftertime( var_0 );
    return var_1;
}

deleteaftertime( var_0 )
{
    wait(var_0);
    self delete();
}
