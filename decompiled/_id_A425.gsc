// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_funeral_female_body_a" );
    self attach( "head_f_act_cau_biedermann_fun", "", 1 );
    self.headmodel = "head_f_act_cau_biedermann_fun";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_funeral_female_body_a" );
    precachemodel( "head_f_act_cau_biedermann_fun" );
}
