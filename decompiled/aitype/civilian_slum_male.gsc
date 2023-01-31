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
    self.health = 30;
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

    switch ( codescripts\character::get_random_character( 8 ) )
    {
        case 0:
            character\character_civilian_slum_male_aa::main();
            break;
        case 1:
            character\character_civilian_slum_male_aa_wht::main();
            break;
        case 2:
            character\character_civilian_slum_male_ab::main();
            break;
        case 3:
            character\character_civilian_slum_male_ab_wht::main();
            break;
        case 4:
            character\character_civilian_slum_male_ba::main();
            break;
        case 5:
            character\character_civilian_slum_male_ba_wht::main();
            break;
        case 6:
            character\character_civilian_slum_male_bb::main();
            break;
        case 7:
            character\character_civilian_slum_male_bb_wht::main();
            break;
    }
}

spawner()
{
    self _meth_8040( "neutral" );
}

precache()
{
    character\character_civilian_slum_male_aa::precache();
    character\character_civilian_slum_male_aa_wht::precache();
    character\character_civilian_slum_male_ab::precache();
    character\character_civilian_slum_male_ab_wht::precache();
    character\character_civilian_slum_male_ba::precache();
    character\character_civilian_slum_male_ba_wht::precache();
    character\character_civilian_slum_male_bb::precache();
    character\character_civilian_slum_male_bb_wht::precache();
}
