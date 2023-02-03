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

    switch ( codescripts\character::get_random_weapon( 4 ) )
    {
        case 0:
            self.weapon = "iw5_mors_sp_morsscope";
            break;
        case 1:
            self.weapon = "iw5_mors_sp_morsscopevz";
            break;
        case 2:
            self.weapon = "iw5_mors_sp_opticsacog2";
            break;
        case 3:
            self.weapon = "iw5_mors_sp_opticsthermal";
            break;
    }

    character\character_sentinel::main();
}

spawner()
{
    self setspawnerteam( "allies" );
}

precache()
{
    character\character_sentinel::precache();
    precacheshellshock( "iw5_mors_sp_morsscope" );
    precacheshellshock( "iw5_mors_sp_morsscopevz" );
    precacheshellshock( "iw5_mors_sp_opticsacog2" );
    precacheshellshock( "iw5_mors_sp_opticsthermal" );
    precacheshellshock( "iw5_titan45_sp" );
    precacheshellshock( "fraggrenade" );
}
