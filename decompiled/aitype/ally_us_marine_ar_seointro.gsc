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
        self _meth_816C( 256.0, 0.0 );
        self _meth_816D( 768.0, 1024.0 );
    }

    switch ( codescripts\character::get_random_weapon( 5 ) )
    {
        case 0:
            self.weapon = "iw5_hbra3_sp";
            break;
        case 1:
            self.weapon = "iw5_hbra3_sp_opticstargetenhancer";
            break;
        case 2:
            self.weapon = "iw5_hbra3_sp_variablereddot";
            break;
        case 3:
            self.weapon = "iw5_hbra3_sp_opticsacog2";
            break;
        case 4:
            self.weapon = "iw5_hbra3_sp_opticsreddot";
            break;
    }

    character\character_us_marine_smg_seointro::main();
}

spawner()
{
    self _meth_8040( "allies" );
}

precache()
{
    character\character_us_marine_smg_seointro::precache();
    precacheitem( "iw5_hbra3_sp" );
    precacheitem( "iw5_hbra3_sp_opticstargetenhancer" );
    precacheitem( "iw5_hbra3_sp_variablereddot" );
    precacheitem( "iw5_hbra3_sp_opticsacog2" );
    precacheitem( "iw5_hbra3_sp_opticsreddot" );
    precacheitem( "iw5_titan45_sp" );
    precacheitem( "fraggrenade" );
}
