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

    switch ( codescripts\character::get_random_character( 7 ) )
    {
        case 0:
            _id_A437::main();
            break;
        case 1:
            _id_A438::main();
            break;
        case 2:
            _id_A439::main();
            break;
        case 3:
            _id_A43A::main();
            break;
        case 4:
            _id_A43D::main();
            break;
        case 5:
            _id_A43E::main();
            break;
        case 6:
            _id_A43F::main();
            break;
    }
}

spawner()
{
    self _meth_8040( "neutral" );
}

precache()
{
    _id_A437::precache();
    _id_A438::precache();
    _id_A439::precache();
    _id_A43A::precache();
    _id_A43D::precache();
    _id_A43E::precache();
    _id_A43F::precache();
}
