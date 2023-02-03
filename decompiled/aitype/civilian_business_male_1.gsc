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
        self setengagementmindist( 256.0, 0.0 );
        self setengagementmaxdist( 768.0, 1024.0 );
    }

    self.weapon = "none";

    switch ( codescripts\character::get_random_character( 5 ) )
    {
        case 0:
            character\character_civ_afr_dark_male_dress::main();
            break;
        case 1:
            character\character_civ_asi_male_dress::main();
            break;
        case 2:
            character\character_civ_cau_male_dress::main();
            break;
        case 3:
            character\character_civ_mde_male_dress::main();
            break;
        case 4:
            character\character_civ_afr_light_male_dress::main();
            break;
    }
}

spawner()
{
    self setspawnerteam( "neutral" );
}

precache()
{
    character\character_civ_afr_dark_male_dress::precache();
    character\character_civ_asi_male_dress::precache();
    character\character_civ_cau_male_dress::precache();
    character\character_civ_mde_male_dress::precache();
    character\character_civ_afr_light_male_dress::precache();
}
