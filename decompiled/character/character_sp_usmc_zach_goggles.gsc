// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "body_sp_usmc_zach" );
    self attach( "head_sp_usmc_zach_zach_body_goggles", "", 1 );
    self.headmodel = "head_sp_usmc_zach_zach_body_goggles";
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "body_sp_usmc_zach" );
    precachemodel( "head_sp_usmc_zach_zach_body_goggles" );
}
