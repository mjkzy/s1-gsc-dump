// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self.animtree = "";
    self.additionalassets = "";
    self.team = "neutral";
    self.type = "human";
    self.subclass = "regular";
    self.accuracy = 0.2;
    self.health = 1;
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
    character\character_ie_doctor::main();
}

spawner()
{
    self _meth_8040( "neutral" );
}

precache()
{
    character\character_ie_doctor::precache();
}
