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

    switch ( codescripts\character::get_random_character( 5 ) )
    {
        case 0:
            _id_A440::main();
            break;
        case 1:
            _id_A441::main();
            break;
        case 2:
            _id_A442::main();
            break;
        case 3:
            _id_A443::main();
            break;
        case 4:
            _id_A447::main();
            break;
    }
}

spawner()
{
    self _meth_8040( "neutral" );
}

precache()
{
    _id_A440::precache();
    _id_A441::precache();
    _id_A442::precache();
    _id_A443::precache();
    _id_A447::precache();
}
