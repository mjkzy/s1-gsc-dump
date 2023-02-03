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
        self setengagementmindist( 256.0, 0.0 );
        self setengagementmaxdist( 768.0, 1024.0 );
    }

    switch ( codescripts\character::get_random_weapon( 5 ) )
    {
        case 0:
            self.weapon = "iw5_kf5loot_sp";
            break;
        case 1:
            self.weapon = "iw5_kf5loot_sp_opticstargetenhancer";
            break;
        case 2:
            self.weapon = "iw5_kf5loot_sp_variablereddot";
            break;
        case 3:
            self.weapon = "iw5_kf5loot_sp_opticsacog2";
            break;
        case 4:
            self.weapon = "iw5_kf5loot_sp_opticsreddot";
            break;
    }

    character\character_atlas_elete::main();
}

spawner()
{
    self setspawnerteam( "axis" );
}

precache()
{
    character\character_atlas_elete::precache();
    precacheshellshock( "iw5_kf5loot_sp" );
    precacheshellshock( "iw5_kf5loot_sp_opticstargetenhancer" );
    precacheshellshock( "iw5_kf5loot_sp_variablereddot" );
    precacheshellshock( "iw5_kf5loot_sp_opticsacog2" );
    precacheshellshock( "iw5_kf5loot_sp_opticsreddot" );
    precacheshellshock( "iw5_titan45loot_sp" );
    precacheshellshock( "fraggrenade" );
}
