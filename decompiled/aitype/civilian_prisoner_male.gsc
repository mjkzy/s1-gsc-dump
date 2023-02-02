// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self.animtree = "";
    self.additionalassets = "";
    self.team = "team3";
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
            character\character_civ_pris_afr_dark_male_lite::main();
            break;
        case 1:
            character\character_civ_pris_mde_male_lite::main();
            break;
        case 2:
            character\character_civ_pris_cau_male_lite::main();
            break;
    }
}

spawner()
{
    self _meth_8040( "team3" );
}

precache()
{
    character\character_civ_pris_afr_dark_male_lite::precache();
    character\character_civ_pris_mde_male_lite::precache();
    character\character_civ_pris_cau_male_lite::precache();
}
