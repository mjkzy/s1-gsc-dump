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
    self.sidearm = "beretta";

    if ( isai( self ) )
    {
        self _meth_816C( 256.0, 0.0 );
        self _meth_816D( 768.0, 1024.0 );
    }

    self.weapon = "s1_m160_npc_only";
    character\character_sentinel_soldier_cloaked::main();
}

spawner()
{
    self _meth_8040( "allies" );
}

precache()
{
    character\character_sentinel_soldier_cloaked::precache();
    precacheitem( "s1_m160_npc_only" );
    precacheitem( "beretta" );
    precacheitem( "fraggrenade" );
}
