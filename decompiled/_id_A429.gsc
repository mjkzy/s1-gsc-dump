// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_funeral_female_irons_body" );
    self attach( "head_f_act_cau_atias_funeral", "", 1 );
    self.headmodel = "head_f_act_cau_atias_funeral";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_funeral_female_irons_body" );
    precachemodel( "head_f_act_cau_atias_funeral" );
}
