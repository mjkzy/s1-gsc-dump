// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self.animtree = "";
    self.additionalassets = "";
    self.team = "axis";
    self.type = "human";
    self.subclass = "regular";
    self.accuracy = 0.2;
    self.health = 200;
    self.grenadeweapon = "fraggrenade";
    self.grenadeammo = 0;
    self.secondaryweapon = "";
    self.sidearm = "iw5_titan45_sp";

    if ( isai( self ) )
    {
        self _meth_816C( 256.0, 0.0 );
        self _meth_816D( 768.0, 1024.0 );
    }

    self.weapon = "iw5_mahem_sp";
    _id_A400::main();
}

spawner()
{
    self _meth_8040( "axis" );
}

precache()
{
    _id_A400::precache();
    precacheitem( "iw5_mahem_sp" );
    precacheitem( "iw5_titan45_sp" );
    precacheitem( "fraggrenade" );
}
