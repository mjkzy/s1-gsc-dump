// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

watchfasthealusage()
{
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "faux_spawn" );

    if ( !isdefined( level.fasthealsettings ) )
        fasthealinit();

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

            thread tryusefastheal();
        }
    }
}

fasthealinit()
{
    self.fasthealsettings = spawnstruct();
}

tryusefastheal()
{
    if ( !isdefined( self.fasthealsettings ) )
        fasthealinit();

    resetfastheal();
    thread startfastheal();
    thread monitorplayerdeath();
    return 1;
}

startfastheal()
{
    self endon( "ClearFastHeal" );
    self endon( "death" );
    self playlocalsound( "earn_superbonus" );
    self.fasthealsettings.overlay = newclienthudelem( self );
    self.fasthealsettings.overlay.x = 0;
    self.fasthealsettings.overlay.y = 0;
    self.fasthealsettings.overlay.horzalign = "fullscreen";
    self.fasthealsettings.overlay.vertalign = "fullscreen";
    self.fasthealsettings.overlay setshader( "exo_hud_cloak_overlay", 640, 480 );
    self.fasthealsettings.overlay.archive = 1;
    self.fasthealsettings.overlay.alpha = 1.0;
    self.isfastheal = 1;
    self.ignoreregendelay = 1;
    self.healthregenlevel = 0.99;
    self notify( "damage" );
    wait 10;
    self.healthregenlevel = undefined;
    self.isfastheal = 0;

    if ( isdefined( self.fasthealsettings.overlay ) )
        self.fasthealsettings.overlay destroy();

    self notify( "EndFastHeal" );
}

resetfastheal()
{
    if ( isdefined( self.isfastheal ) && self.isfastheal == 1 )
    {
        if ( isdefined( self.fasthealsettings.overlay ) )
            self.fasthealsettings.overlay destroy();

        self.healthregenlevel = undefined;
        self notify( "ClearFastHeal" );
    }
}

monitorplayerdeath()
{
    self endon( "EndFastHeal" );
    self waittill( "death" );
    self.healthregenlevel = undefined;
    self.isfastheal = 0;

    if ( isdefined( self.fasthealsettings.overlay ) )
        self.fasthealsettings.overlay destroy();
}

printhealthtoscreen()
{
    self endon( "EndFastHeal" );
    self endon( "death" );

    for (;;)
    {
        iprintlnbold( self.health );
        wait 1;
    }
}
