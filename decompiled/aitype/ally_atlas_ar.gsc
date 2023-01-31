// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self.animtree = "";
    self.additionalassets = "";
    self.team = "allies";
    self.type = "human";
    self.subclass = "regular";
    self.accuracy = 0.2;
    self.health = 100;
    self.grenadeweapon = "fraggrenade";
    self.grenadeammo = 0;
    self.secondaryweapon = "";
    self.sidearm = "iw5_titan45_sp";

    if ( isai( self ) )
    {
        self _meth_816C( 256.0, 0.0 );
        self _meth_816D( 768.0, 1024.0 );
    }

    switch ( codescripts\character::get_random_weapon( 10 ) )
    {
        case 0:
            self.weapon = "iw5_himar_sp_himarscope";
            break;
        case 1:
            self.weapon = "iw5_himar_sp_opticsacog2";
            break;
        case 2:
            self.weapon = "iw5_himar_sp_opticsreddot";
            break;
        case 3:
            self.weapon = "iw5_himar_sp_variablereddot";
            break;
        case 4:
            self.weapon = "iw5_himar_sp_opticstargetenhancer";
            break;
        case 5:
            self.weapon = "iw5_bal27_sp";
            break;
        case 6:
            self.weapon = "iw5_bal27_sp_opticsacog2";
            break;
        case 7:
            self.weapon = "iw5_bal27_sp_opticsreddot";
            break;
        case 8:
            self.weapon = "iw5_bal27_sp_variablereddot";
            break;
        case 9:
            self.weapon = "iw5_bal27_sp_opticstargetenhancer";
            break;
    }

    _id_A3F6::main();
}

spawner()
{
    self _meth_8040( "allies" );
}

precache()
{
    _id_A3F6::precache();
    precacheitem( "iw5_himar_sp_himarscope" );
    precacheitem( "iw5_himar_sp_opticsacog2" );
    precacheitem( "iw5_himar_sp_opticsreddot" );
    precacheitem( "iw5_himar_sp_variablereddot" );
    precacheitem( "iw5_himar_sp_opticstargetenhancer" );
    precacheitem( "iw5_bal27_sp" );
    precacheitem( "iw5_bal27_sp_opticsacog2" );
    precacheitem( "iw5_bal27_sp_opticsreddot" );
    precacheitem( "iw5_bal27_sp_variablereddot" );
    precacheitem( "iw5_bal27_sp_opticstargetenhancer" );
    precacheitem( "iw5_titan45_sp" );
    precacheitem( "fraggrenade" );
}
