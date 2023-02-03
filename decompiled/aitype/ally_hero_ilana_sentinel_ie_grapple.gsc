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
    self.sidearm = "iw5_pbwsingleshot_sp_silencerpistol";

    if ( isai( self ) )
    {
        self setengagementmindist( 256.0, 0.0 );
        self setengagementmaxdist( 768.0, 1024.0 );
    }

    switch ( codescripts\character::get_random_weapon( 5 ) )
    {
        case 0:
            self.weapon = "iw5_kf5fullauto_sp_silencer01";
            break;
        case 1:
            self.weapon = "iw5_kf5fullauto_sp_opticsacog2_silencer01";
            break;
        case 2:
            self.weapon = "iw5_kf5fullauto_sp_opticstargetenhancer_silencer01";
            break;
        case 3:
            self.weapon = "iw5_kf5fullauto_sp_opticsreddot_silencer01";
            break;
        case 4:
            self.weapon = "iw5_kf5fullauto_sp_silencer01_variablereddot";
            break;
    }

    character\character_hero_ilana_sentinel_udtgr::main();
}

spawner()
{
    self setspawnerteam( "allies" );
}

precache()
{
    character\character_hero_ilana_sentinel_udtgr::precache();
    precacheshellshock( "iw5_kf5fullauto_sp_silencer01" );
    precacheshellshock( "iw5_kf5fullauto_sp_opticsacog2_silencer01" );
    precacheshellshock( "iw5_kf5fullauto_sp_opticstargetenhancer_silencer01" );
    precacheshellshock( "iw5_kf5fullauto_sp_opticsreddot_silencer01" );
    precacheshellshock( "iw5_kf5fullauto_sp_silencer01_variablereddot" );
    precacheshellshock( "iw5_pbwsingleshot_sp_silencerpistol" );
    precacheshellshock( "fraggrenade" );
}
