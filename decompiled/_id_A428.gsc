// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_funeral_female_body_a" );
    self attach( "head_f_gen_asi_kwok_base", "", 1 );
    self.headmodel = "head_f_gen_asi_kwok_base";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_funeral_female_body_a" );
    precachemodel( "head_f_gen_asi_kwok_base" );
}
