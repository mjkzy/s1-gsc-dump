// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self.animtree = "";
    self.additionalassets = "";
    self.team = "allies";
    self.type = "human";
    self.subclass = "regular";
    self.accuracy = 0.2;
    self.health = 100;
    self.grenadeweapon = "";
    self.grenadeammo = 0;
    self.secondaryweapon = "";
    self.sidearm = "";

    if ( isai( self ) )
    {
        self setengagementmindist( 256.0, 0.0 );
        self setengagementmaxdist( 768.0, 1024.0 );
    }

    self.weapon = "iw5_kf5singleshot_sp";
    character\character_sentinel_ie_land::main();
}

spawner()
{
    self setspawnerteam( "allies" );
}

precache()
{
    character\character_sentinel_ie_land::precache();
    precacheshellshock( "iw5_kf5singleshot_sp" );
}
