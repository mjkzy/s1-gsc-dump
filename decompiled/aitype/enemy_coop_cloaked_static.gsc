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
    self.health = 500;
    self.grenadeweapon = "fraggrenade";
    self.grenadeammo = 1;
    self.secondaryweapon = "";
    self.sidearm = "";

    if ( isai( self ) )
    {
        self setengagementmindist( 256.0, 0.0 );
        self setengagementmaxdist( 768.0, 1024.0 );
    }

    self.weapon = "none";
    character\character_coop_cloaked_static::main();
}

spawner()
{
    self setspawnerteam( "axis" );
}

precache()
{
    character\character_coop_cloaked_static::precache();
    precacheshellshock( "fraggrenade" );
}
