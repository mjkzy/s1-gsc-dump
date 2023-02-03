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
    self.sidearm = "iw5_titan45_sp";

    if ( isai( self ) )
    {
        self setengagementmindist( 768.0, 700.0 );
        self setengagementmaxdist( 1450.0, 2100.0 );
    }

    switch ( codescripts\character::get_random_weapon( 3 ) )
    {
        case 0:
            self.weapon = "iw5_thor_sp_thorscope";
            break;
        case 1:
            self.weapon = "iw5_thor_sp_thorscopevz";
            break;
        case 2:
            self.weapon = "iw5_thor_sp_thorstabilizer";
            break;
    }

    character\character_atlas_smg::main();
}

spawner()
{
    self setspawnerteam( "axis" );
}

precache()
{
    character\character_atlas_smg::precache();
    precacheshellshock( "iw5_thor_sp_thorscope" );
    precacheshellshock( "iw5_thor_sp_thorscopevz" );
    precacheshellshock( "iw5_thor_sp_thorstabilizer" );
    precacheshellshock( "iw5_titan45_sp" );
    precacheshellshock( "fraggrenade" );
    maps\_sniper_glint::main();
}
