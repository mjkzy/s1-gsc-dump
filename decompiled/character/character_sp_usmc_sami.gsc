// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "body_sp_usmc_james" );
    self attach( "head_sp_usmc_sami_zach_body", "", 1 );
    self.headmodel = "head_sp_usmc_sami_zach_body";
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "body_sp_usmc_james" );
    precachemodel( "head_sp_usmc_sami_zach_body" );
}
