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
        self setengagementmindist( 256.0, 0.0 );
        self setengagementmaxdist( 768.0, 1024.0 );
    }

    self.weapon = "none";

    switch ( codescripts\character::get_random_character( 4 ) )
    {
        case 0:
            character\character_civ_cau_male_casual_grk::main();
            break;
        case 1:
            character\character_civ_cau_male_dress_grk::main();
            break;
        case 2:
            character\character_civ_afr_male_cas_grk::main();
            break;
        case 3:
            character\character_civ_afr_male_drs_grk::main();
            break;
    }
}

spawner()
{
    self setspawnerteam( "neutral" );
}

precache()
{
    character\character_civ_cau_male_casual_grk::precache();
    character\character_civ_cau_male_dress_grk::precache();
    character\character_civ_afr_male_cas_grk::precache();
    character\character_civ_afr_male_drs_grk::precache();
}
