// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self.animtree = "";
    self.additionalassets = "mech.csv";
    self.team = "allies";
    self.type = "mech";
    self.subclass = "mech";
    self.accuracy = 0.2;
    self.health = 3600;
    self.grenadeweapon = "fraggrenade";
    self.grenadeammo = 0;
    self.secondaryweapon = "iw5_titan45_sp";
    self.sidearm = "iw5_titan45_sp";

    if ( isai( self ) )
    {
        self setengagementmindist( 0.0, 0.0 );
        self setengagementmaxdist( 256.0, 1024.0 );
    }

    self.weapon = "exo_minigun";
    character\character_mech::main();
}

spawner()
{
    self setspawnerteam( "allies" );
}

precache()
{
    character\character_mech::precache();
    precacheshellshock( "exo_minigun" );
    precacheshellshock( "iw5_titan45_sp" );
    precacheshellshock( "iw5_titan45_sp" );
    precacheshellshock( "fraggrenade" );
    maps\_mech::main();
}
