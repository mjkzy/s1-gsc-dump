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
    self.grenadeweapon = "fraggrenade";
    self.grenadeammo = 0;
    self.secondaryweapon = "";
    self.sidearm = "iw5_titan45_sp";

    if ( isai( self ) )
    {
        self setengagementmindist( 256.0, 0.0 );
        self setengagementmaxdist( 768.0, 1024.0 );
    }

    self.weapon = "iw5_bal27_sp_variablereddot";
    character\character_hero_burke_b_atlas::main();
}

spawner()
{
    self setspawnerteam( "allies" );
}

precache()
{
    character\character_hero_burke_b_atlas::precache();
    precacheshellshock( "iw5_bal27_sp_variablereddot" );
    precacheshellshock( "iw5_titan45_sp" );
    precacheshellshock( "fraggrenade" );
}
