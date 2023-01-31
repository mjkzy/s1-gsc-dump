// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self.animtree = "";
    self.additionalassets = "";
    self.team = "axis";
    self.type = "human";
    self.subclass = "elite";
    self.accuracy = 0.2;
    self.health = 1000;
    self.grenadeweapon = "fraggrenade";
    self.grenadeammo = 0;
    self.secondaryweapon = "";
    self.sidearm = "iw5_titan45loot_sp";

    if ( isai( self ) )
    {
        self _meth_816C( 256.0, 0.0 );
        self _meth_816D( 768.0, 1024.0 );
    }

    switch ( codescripts\character::get_random_weapon( 4 ) )
    {
        case 0:
            self.weapon = "iw5_uts19loot_sp";
            break;
        case 1:
            self.weapon = "iw5_uts19loot_sp_opticstargetenhancer";
            break;
        case 2:
            self.weapon = "iw5_uts19loot_sp_foregrip";
            break;
        case 3:
            self.weapon = "iw5_uts19loot_sp_opticsreddot";
            break;
    }

    _id_A3FA::main();
}

spawner()
{
    self _meth_8040( "axis" );
}

precache()
{
    _id_A3FA::precache();
    precacheitem( "iw5_uts19loot_sp" );
    precacheitem( "iw5_uts19loot_sp_opticstargetenhancer" );
    precacheitem( "iw5_uts19loot_sp_foregrip" );
    precacheitem( "iw5_uts19loot_sp_opticsreddot" );
    precacheitem( "iw5_titan45loot_sp" );
    precacheitem( "fraggrenade" );
}
