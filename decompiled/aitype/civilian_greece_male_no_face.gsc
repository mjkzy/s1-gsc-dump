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
        self _meth_816C( 256.0, 0.0 );
        self _meth_816D( 768.0, 1024.0 );
    }

    self.weapon = "none";

    switch ( codescripts\character::get_random_character( 4 ) )
    {
        case 0:
            _id_A41B::main();
            break;
        case 1:
            _id_A41D::main();
            break;
        case 2:
            _id_A40E::main();
            break;
        case 3:
            _id_A40F::main();
            break;
    }
}

spawner()
{
    self _meth_8040( "neutral" );
}

precache()
{
    _id_A41B::precache();
    _id_A41D::precache();
    _id_A40E::precache();
    _id_A40F::precache();
}
