// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

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

    switch ( codescripts\character::get_random_weapon( 3 ) )
    {
        case 0:
            self.weapon = "iw5_maul_sp";
            break;
        case 1:
            self.weapon = "iw5_maul_sp_opticsreddot";
            break;
        case 2:
            self.weapon = "iw5_maul_sp_opticstargetenhancer";
            break;
    }

    switch ( codescripts\character::get_random_character( 3 ) )
    {
        case 0:
            character\character_sf_police_a::main();
            break;
        case 1:
            character\character_sf_police_b::main();
            break;
        case 2:
            character\character_sf_police_c::main();
            break;
    }
}

spawner()
{
    self setspawnerteam( "allies" );
}

precache()
{
    character\character_sf_police_a::precache();
    character\character_sf_police_b::precache();
    character\character_sf_police_c::precache();
    precacheitem( "iw5_maul_sp" );
    precacheitem( "iw5_maul_sp_opticsreddot" );
    precacheitem( "iw5_maul_sp_opticstargetenhancer" );
    precacheitem( "iw5_titan45_sp" );
    precacheitem( "fraggrenade" );
}
