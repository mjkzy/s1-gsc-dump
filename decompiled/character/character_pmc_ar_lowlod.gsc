// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "marines_body_assault_lowlod" );
    self attach( "pmc_casual_head_c_lowlod", "", 1 );
    self.headmodel = "pmc_casual_head_c_lowlod";
    self.voice = "atlas";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "marines_body_assault_lowlod" );
    precachemodel( "pmc_casual_head_c_lowlod" );
}
