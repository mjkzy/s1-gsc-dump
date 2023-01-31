// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self.animtree = "";
    self.additionalassets = "sniper_glint.csv";
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
        self _meth_816C( 768.0, 700.0 );
        self _meth_816D( 1450.0, 2100.0 );
    }

    switch ( codescripts\character::get_random_weapon( 3 ) )
    {
        case 0:
            self.weapon = "iw5_thor_sp_thorscope";
            break;
        case 1:
            self.weapon = "iw5_thor_sp_thorscopevz";
            break;
        case 2:
            self.weapon = "iw5_thor_sp_thorstabilizer";
            break;
    }

    _id_A3FF::main();
}

spawner()
{
    self _meth_8040( "axis" );
}

precache()
{
    _id_A3FF::precache();
    precacheitem( "iw5_thor_sp_thorscope" );
    precacheitem( "iw5_thor_sp_thorscopevz" );
    precacheitem( "iw5_thor_sp_thorstabilizer" );
    precacheitem( "iw5_titan45_sp" );
    precacheitem( "fraggrenade" );
    maps\_sniper_glint::main();
}
