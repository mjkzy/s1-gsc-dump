// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "body_sp_usmc_zach" );
    self attach( "head_sp_usmc_zach_zach_body", "", 1 );
    self.headmodel = "head_sp_usmc_zach_zach_body";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "body_sp_usmc_zach" );
    precachemodel( "head_sp_usmc_zach_zach_body" );
}
