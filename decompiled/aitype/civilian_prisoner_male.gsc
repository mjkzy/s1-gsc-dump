// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self.animtree = "";
    self.additionalassets = "";
    self.team = "team3";
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

    switch ( codescripts\character::get_random_character( 3 ) )
    {
        case 0:
            _id_A422::main();
            break;
        case 1:
            _id_A424::main();
            break;
        case 2:
            _id_A423::main();
            break;
    }
}

spawner()
{
    self _meth_8040( "team3" );
}

precache()
{
    _id_A422::precache();
    _id_A424::precache();
    _id_A423::precache();
}