// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self.animtree = "";
    self.additionalassets = "mech.csv";
    self.team = "axis";
    self.type = "mech";
    self.subclass = "mech";
    self.accuracy = 0.2;
    self.health = 4500;
    self.grenadeweapon = "fraggrenade";
    self.grenadeammo = 0;
    self.secondaryweapon = "";
    self.sidearm = "";

    if ( isai( self ) )
    {
        self setengagementmindist( 512.0, 0.0 );
        self setengagementmaxdist( 1024.0, 1024.0 );
    }

    self.weapon = "exo_minigun_scaled";
    character\character_mech_scaled::main();
}

spawner()
{
    self setspawnerteam( "axis" );
}

precache()
{
    character\character_mech_scaled::precache();
    precacheshellshock( "exo_minigun_scaled" );
    precacheshellshock( "fraggrenade" );
    maps\_mech::main();
}
