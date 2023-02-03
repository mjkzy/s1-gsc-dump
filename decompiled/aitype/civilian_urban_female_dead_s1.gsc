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

    switch ( codescripts\character::get_random_character( 2 ) )
    {
        case 0:
            character\character_civ_s1_female_dead_a::main();
            break;
        case 1:
            character\character_civ_s1_female_dead_b::main();
            break;
    }
}

spawner()
{
    self setspawnerteam( "neutral" );
}

precache()
{
    character\character_civ_s1_female_dead_a::precache();
    character\character_civ_s1_female_dead_b::precache();
}
