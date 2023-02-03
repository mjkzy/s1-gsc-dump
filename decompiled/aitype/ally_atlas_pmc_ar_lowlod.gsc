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

    switch ( codescripts\character::get_random_weapon( 13 ) )
    {
        case 0:
            self.weapon = "iw5_bal27_sp";
            break;
        case 1:
            self.weapon = "iw5_bal27_sp_opticsacog2";
            break;
        case 2:
            self.weapon = "iw5_bal27_sp_opticsreddot";
            break;
        case 3:
            self.weapon = "iw5_bal27_sp_opticsthermal";
            break;
        case 4:
            self.weapon = "iw5_bal27_sp_variablereddot";
            break;
        case 5:
            self.weapon = "iw5_bal27_sp_opticstargetenhancer";
            break;
        case 6:
            self.weapon = "iw5_ak12_sp";
            break;
        case 7:
            self.weapon = "iw5_ak12_sp_opticsacog2";
            break;
        case 8:
            self.weapon = "iw5_ak12_sp_opticsreddot";
            break;
        case 9:
            self.weapon = "iw5_ak12_sp_opticsthermal";
            break;
        case 10:
            self.weapon = "iw5_ak12_sp_opticstargetenhancer";
            break;
        case 11:
            self.weapon = "iw5_lsat_sp";
            break;
        case 12:
            self.weapon = "iw5_lsat_sp_opticsacog2";
            break;
    }

    character\character_pmc_ar_lowlod::main();
}

spawner()
{
    self setspawnerteam( "allies" );
}

precache()
{
    character\character_pmc_ar_lowlod::precache();
    precacheshellshock( "iw5_bal27_sp" );
    precacheshellshock( "iw5_bal27_sp_opticsacog2" );
    precacheshellshock( "iw5_bal27_sp_opticsreddot" );
    precacheshellshock( "iw5_bal27_sp_opticsthermal" );
    precacheshellshock( "iw5_bal27_sp_variablereddot" );
    precacheshellshock( "iw5_bal27_sp_opticstargetenhancer" );
    precacheshellshock( "iw5_ak12_sp" );
    precacheshellshock( "iw5_ak12_sp_opticsacog2" );
    precacheshellshock( "iw5_ak12_sp_opticsreddot" );
    precacheshellshock( "iw5_ak12_sp_opticsthermal" );
    precacheshellshock( "iw5_ak12_sp_opticstargetenhancer" );
    precacheshellshock( "iw5_lsat_sp" );
    precacheshellshock( "iw5_lsat_sp_opticsacog2" );
    precacheshellshock( "iw5_titan45_sp" );
    precacheshellshock( "fraggrenade" );
}
