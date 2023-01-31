// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_urban_female_body_c_afr_dark" );
    self attach( "head_f_act_afr_townes", "", 1 );
    self.headmodel = "head_f_act_afr_townes";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_female_body_c_afr_dark" );
    precachemodel( "head_f_act_afr_townes" );
}
