// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self.animtree = "";
    self.additionalassets = "";
    self.team = "neutral";
    self.type = "civilian";
    self.subclass = "regular";
    self.accuracy = 0.2;
    self.health = 100;
    self.grenadeweapon = "";
    self.grenadeammo = 0;
    self.secondaryweapon = "";
    self.sidearm = "";

    if ( isai( self ) )
    {
        self _meth_816C( 256.0, 0.0 );
        self _meth_816D( 768.0, 1024.0 );
    }

    self.weapon = "none";

    switch ( codescripts\character::get_random_character( 3 ) )
    {
        case 0:
            character\character_civ_mde_female_dress::main();
            break;
        case 1:
            character\character_civ_cau_fem_drs_sml::main();
            break;
        case 2:
            character\character_civ_afr_light_fem_drs_sml::main();
            break;
    }
}

spawner()
{
    self _meth_8040( "neutral" );
}

precache()
{
    character\character_civ_mde_female_dress::precache();
    character\character_civ_cau_fem_drs_sml::precache();
    character\character_civ_afr_light_fem_drs_sml::precache();
}
