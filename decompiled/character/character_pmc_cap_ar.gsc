// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "atlas_pmc_body" );
    self attach( "pmc_casual_head_c", "", 1 );
    self.headmodel = "pmc_casual_head_c";
    self.voice = "atlas";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "atlas_pmc_body" );
    precachemodel( "pmc_casual_head_c" );
}
