// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_seoul_male_body_f" );
    self attach( "civ_seoul_male_head_c", "", 1 );
    self.headmodel = "civ_seoul_male_head_c";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_seoul_male_body_f" );
    precachemodel( "civ_seoul_male_head_c" );
}
