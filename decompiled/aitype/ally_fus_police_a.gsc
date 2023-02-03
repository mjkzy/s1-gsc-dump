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

    switch ( codescripts\character::get_random_weapon( 3 ) )
    {
        case 0:
            self.weapon = "iw5_maul_sp";
            break;
        case 1:
            self.weapon = "iw5_maul_sp_opticsreddot";
            break;
        case 2:
            self.weapon = "iw5_maul_sp_opticstargetenhancer";
            break;
    }

    character\character_sf_police_a::main();
}

spawner()
{
    self setspawnerteam( "allies" );
}

precache()
{
    character\character_sf_police_a::precache();
    precacheshellshock( "iw5_maul_sp" );
    precacheshellshock( "iw5_maul_sp_opticsreddot" );
    precacheshellshock( "iw5_maul_sp_opticstargetenhancer" );
    precacheshellshock( "iw5_titan45_sp" );
    precacheshellshock( "fraggrenade" );
}
