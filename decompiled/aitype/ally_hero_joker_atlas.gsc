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

    self.weapon = "iw5_himar_sp_himarscope";
    character\character_hero_joker_atlas::main();
}

spawner()
{
    self _meth_8040( "allies" );
}

precache()
{
    character\character_hero_joker_atlas::precache();
    precacheitem( "iw5_himar_sp_himarscope" );
    precacheitem( "iw5_titan45_sp" );
    precacheitem( "fraggrenade" );
}