// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_urban_female_body_b" );
    self attach( "head_f_act_cau_hamilton_base", "", 1 );
    self.headmodel = "head_f_act_cau_hamilton_base";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_female_body_b" );
    precachemodel( "head_f_act_cau_hamilton_base" );
}
