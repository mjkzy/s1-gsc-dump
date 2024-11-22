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

    self.weapon = "iw5_bal27_sp_opticstargetenhancer";
    character\character_hero_joker_atlas_pmc::main();
}

spawner()
{
    self setspawnerteam( "allies" );
}

precache()
{
    character\character_hero_joker_atlas_pmc::precache();
    precacheitem( "iw5_bal27_sp_opticstargetenhancer" );
    precacheitem( "iw5_titan45_sp" );
    precacheitem( "fraggrenade" );
}
