// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "marines_body_assault_lowlod" );
    self attach( "pmc_casual_head_c_lowlod", "", 1 );
    self.headmodel = "pmc_casual_head_c_lowlod";
    self.voice = "atlas";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "marines_body_assault_lowlod" );
    precachemodel( "pmc_casual_head_c_lowlod" );
}
