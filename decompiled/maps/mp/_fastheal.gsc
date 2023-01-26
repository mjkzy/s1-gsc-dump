// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_A213()
{
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "faux_spawn" );

    if ( !isdefined( level._id_367B ) )
        _id_367A();

    for (;;)
    {
        self waittill( "grenade_fire", var_0, var_1 );

        if ( var_1 == "fast_heal_mp" )
        {
            if ( !isalive( self ) )
            {
                var_0 delete();
                return;
            }

            thread _id_98AA();
        }
    }
}

_id_367A()
{
    self._id_367B = spawnstruct();
}

_id_98AA()
{
    if ( !isdefined( self._id_367B ) )
        _id_367A();

    _id_7446();
    thread _id_8D10();
    thread monitorplayerdeath();
    return 1;
}

_id_8D10()
{
    self endon( "ClearFastHeal" );
    self endon( "death" );
    self playlocalsound( "earn_superbonus" );
    self._id_367B.overlay = newclienthudelem( self );
    self._id_367B.overlay.x = 0;
    self._id_367B.overlay.y = 0;
    self._id_367B.overlay.horzalign = "fullscreen";
    self._id_367B.overlay.vertalign = "fullscreen";
    self._id_367B.overlay setshader( "exo_hud_cloak_overlay", 640, 480 );
    self._id_367B.overlay._id_0CCB = 1;
    self._id_367B.overlay.alpha = 1.0;
    self._id_5101 = 1;
    self.ignoreregendelay = 1;
    self.healthregenlevel = 0.99;
    self notify( "damage" );
    wait 10;
    self.healthregenlevel = undefined;
    self._id_5101 = 0;

    if ( isdefined( self._id_367B.overlay ) )
        self._id_367B.overlay destroy();

    self notify( "EndFastHeal" );
}

_id_7446()
{
    if ( isdefined( self._id_5101 ) && self._id_5101 == 1 )
    {
        if ( isdefined( self._id_367B.overlay ) )
            self._id_367B.overlay destroy();

        self.healthregenlevel = undefined;
        self notify( "ClearFastHeal" );
    }
}

monitorplayerdeath()
{
    self endon( "EndFastHeal" );
    self waittill( "death" );
    self.healthregenlevel = undefined;
    self._id_5101 = 0;

    if ( isdefined( self._id_367B.overlay ) )
        self._id_367B.overlay destroy();
}

_id_6FAF()
{
    self endon( "EndFastHeal" );
    self endon( "death" );

    for (;;)
    {
        iprintlnbold( self.health );
        wait 1;
    }
}
