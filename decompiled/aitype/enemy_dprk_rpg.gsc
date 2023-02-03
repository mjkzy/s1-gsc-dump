// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self.animtree = "";
    self.additionalassets = "";
    self.team = "axis";
    self.type = "human";
    self.subclass = "regular";
    self.accuracy = 0.2;
    self.health = 200;
    self.grenadeweapon = "fraggrenade";
    self.grenadeammo = 0;
    self.secondaryweapon = "";
    self.sidearm = "iw5_vbr_sp";

    if ( isai( self ) )
    {
        self setengagementmindist( 256.0, 0.0 );
        self setengagementmaxdist( 768.0, 1024.0 );
    }

    self.weapon = "iw5_mahem_sp";
    character\character_dprk_ar::main();
}

spawner()
{
    self setspawnerteam( "axis" );
}

precache()
{
    character\character_dprk_ar::precache();
    precacheshellshock( "iw5_mahem_sp" );
    precacheshellshock( "iw5_vbr_sp" );
    precacheshellshock( "fraggrenade" );
}
