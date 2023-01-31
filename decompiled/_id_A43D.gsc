// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_urban_female_body_e_asi" );
    self attach( "head_f_gen_asi_lee_base", "", 1 );
    self.headmodel = "head_f_gen_asi_lee_base";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_female_body_e_asi" );
    precachemodel( "head_f_gen_asi_lee_base" );
}
