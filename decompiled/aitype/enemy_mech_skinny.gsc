// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self.animtree = "";
    self.additionalassets = "mech.csv";
    self.team = "axis";
    self.type = "human";
    self.subclass = "mech";
    self.accuracy = 0.2;
    self.health = 4500;
    self.grenadeweapon = "fraggrenade";
    self.grenadeammo = 0;
    self.secondaryweapon = "";
    self.sidearm = "";

    if ( isai( self ) )
    {
        self _meth_816C( 512.0, 0.0 );
        self _meth_816D( 2056.0, 2056.0 );
    }

    self.weapon = "exo_minigun";
    character\character_mech::main();
}

spawner()
{
    self _meth_8040( "axis" );
}

precache()
{
    character\character_mech::precache();
    precacheitem( "exo_minigun" );
    precacheitem( "fraggrenade" );
    maps\_mech::main();
}
