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

    switch ( codescripts\character::get_random_weapon( 6 ) )
    {
        case 0:
            self.weapon = "iw5_rhino_sp";
            break;
        case 1:
            self.weapon = "iw5_rhino_sp_opticsreddot";
            break;
        case 2:
            self.weapon = "iw5_rhino_sp_opticstargetenhancer";
            break;
        case 3:
            self.weapon = "iw5_rhino_sp";
            break;
        case 4:
            self.weapon = "iw5_rhino_sp_opticsreddot";
            break;
        case 5:
            self.weapon = "iw5_rhino_sp_opticstargetenhancer";
            break;
    }

    character\character_kva_shotgun::main();
}

spawner()
{
    self setspawnerteam( "axis" );
}

precache()
{
    character\character_kva_shotgun::precache();
    precacheshellshock( "iw5_rhino_sp" );
    precacheshellshock( "iw5_rhino_sp_opticsreddot" );
    precacheshellshock( "iw5_rhino_sp_opticstargetenhancer" );
    precacheshellshock( "iw5_rhino_sp" );
    precacheshellshock( "iw5_rhino_sp_opticsreddot" );
    precacheshellshock( "iw5_rhino_sp_opticstargetenhancer" );
    precacheshellshock( "iw5_vbr_sp" );
    precacheshellshock( "fraggrenade" );
}
