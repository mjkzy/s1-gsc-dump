// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self.animtree = "dog.atr";
    self.additionalassets = "common_dogs.csv";
    self.team = "axis";
    self.type = "dog";
    self.subclass = "regular";
    self.accuracy = 0.2;
    self.health = 200;
    self.grenadeweapon = "fraggrenade";
    self.grenadeammo = 0;
    self.secondaryweapon = "dog_bite";
    self.sidearm = "";

    if ( isai( self ) )
    {
        self _meth_816C( 256.0, 0.0 );
        self _meth_816D( 768.0, 1024.0 );
    }

    self.weapon = "dog_bite";
    character\character_sp_doberman_dog::main();
}

spawner()
{
    self _meth_8040( "axis" );
}

precache()
{
    character\character_sp_doberman_dog::precache();
    precacheitem( "dog_bite" );
    precacheitem( "dog_bite" );
    precacheitem( "fraggrenade" );
    animscripts\dog\dog_init::initdoganimations();
}
