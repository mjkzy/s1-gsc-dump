// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self.animtree = "";
    self.additionalassets = "sniper_glint.csv";
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
        self setengagementmindist( 1250.0, 1024.0 );
        self setengagementmaxdist( 1600.0, 2400.0 );
    }

    switch ( codescripts\character::get_random_weapon( 5 ) )
    {
        case 0:
            self.weapon = "iw5_m990_sp_m990scope";
            break;
        case 1:
            self.weapon = "iw5_m990_sp_m990scopevz";
            break;
        case 2:
            self.weapon = "iw5_m990_sp_m990stabilizer";
            break;
        case 3:
            self.weapon = "iw5_m990_sp_opticsacog2";
            break;
        case 4:
            self.weapon = "iw5_m990_sp_opticsthermal";
            break;
    }

    character\character_kva_ar::main();
}

spawner()
{
    self setspawnerteam( "axis" );
}

precache()
{
    character\character_kva_ar::precache();
    precacheshellshock( "iw5_m990_sp_m990scope" );
    precacheshellshock( "iw5_m990_sp_m990scopevz" );
    precacheshellshock( "iw5_m990_sp_m990stabilizer" );
    precacheshellshock( "iw5_m990_sp_opticsacog2" );
    precacheshellshock( "iw5_m990_sp_opticsthermal" );
    precacheshellshock( "iw5_vbr_sp" );
    precacheshellshock( "fraggrenade" );
    maps\_sniper_glint::main();
}
