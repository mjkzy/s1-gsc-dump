// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_african_male_body_b" );
    self attach( "head_male_sp_gartei", "", 1 );
    self.headmodel = "head_male_sp_gartei";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_african_male_body_b" );
    precachemodel( "head_male_sp_gartei" );
}
