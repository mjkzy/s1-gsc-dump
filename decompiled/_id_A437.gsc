// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_urban_female_body_a_mde" );
    self attach( "head_f_gen_mde_halabi", "", 1 );
    self.headmodel = "head_f_gen_mde_halabi";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_female_body_a_mde" );
    precachemodel( "head_f_gen_mde_halabi" );
}
