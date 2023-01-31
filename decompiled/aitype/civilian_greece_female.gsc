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

    switch ( codescripts\character::get_random_character( 8 ) )
    {
        case 0:
            _id_A416::main();
            break;
        case 1:
            _id_A417::main();
            break;
        case 2:
            _id_A40A::main();
            break;
        case 3:
            _id_A40B::main();
            break;
        case 4:
            _id_A403::main();
            break;
        case 5:
            _id_A404::main();
            break;
        case 6:
            _id_A41E::main();
            break;
        case 7:
            _id_A41F::main();
            break;
    }
}

spawner()
{
    self _meth_8040( "neutral" );
}

precache()
{
    _id_A416::precache();
    _id_A417::precache();
    _id_A40A::precache();
    _id_A40B::precache();
    _id_A403::precache();
    _id_A404::precache();
    _id_A41E::precache();
    _id_A41F::precache();
}
