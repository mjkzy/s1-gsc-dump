// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_urban_male_body_b" );
    self attach( "civ_urban_male_head_kanik", "", 1 );
    self.headmodel = "civ_urban_male_head_kanik";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_male_body_b" );
    precachemodel( "civ_urban_male_head_kanik" );
}
