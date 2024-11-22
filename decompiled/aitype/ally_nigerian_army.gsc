// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    self.animtree = "";
    self.additionalassets = "";
    self.team = "allies";
    self.type = "human";
    self.subclass = "regular";
    self.accuracy = 0.2;
    self.health = 100;
    self.grenadeweapon = "fraggrenade";
    self.grenadeammo = 0;
    self.secondaryweapon = "";
    self.sidearm = "iw5_titan45_sp";

    if ( isai( self ) )
    {
        self setengagementmindist( 256.0, 0.0 );
        self setengagementmaxdist( 768.0, 1024.0 );
    }

    self.weapon = "iw5_ak12_sp";
    character\character_nigerian_army::main();
}

spawner()
{
    self setspawnerteam( "allies" );
}

precache()
{
    character\character_nigerian_army::precache();
    precacheitem( "iw5_ak12_sp" );
    precacheitem( "iw5_titan45_sp" );
    precacheitem( "fraggrenade" );
}
