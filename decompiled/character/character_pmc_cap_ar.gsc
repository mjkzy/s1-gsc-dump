// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "atlas_pmc_body" );
    self attach( "pmc_casual_head_c", "", 1 );
    self.headmodel = "pmc_casual_head_c";
    self.voice = "atlas";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "atlas_pmc_body" );
    precachemodel( "pmc_casual_head_c" );
}
