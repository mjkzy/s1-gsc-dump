// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_urban_female_dead_body_b" );
    self attach( "head_ilana_civilian", "", 1 );
    self.headmodel = "head_ilana_civilian";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_female_dead_body_b" );
    precachemodel( "head_ilana_civilian" );
}