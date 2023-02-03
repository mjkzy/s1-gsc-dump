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
    self.health = 150;
    self.grenadeweapon = "fraggrenade";
    self.grenadeammo = 0;
    self.secondaryweapon = "";
    self.sidearm = "iw5_titan45pickup_sp_xmags";

    if ( isai( self ) )
    {
        self setengagementmindist( 256.0, 0.0 );
        self setengagementmaxdist( 768.0, 1024.0 );
    }

    self.weapon = "iw5_sn6pickup_sp_xmags";
    character\character_doctor_cpt::main();
}

spawner()
{
    self setspawnerteam( "neutral" );
}

precache()
{
    character\character_doctor_cpt::precache();
    precacheshellshock( "iw5_sn6pickup_sp_xmags" );
    precacheshellshock( "iw5_titan45pickup_sp_xmags" );
    precacheshellshock( "fraggrenade" );
}
