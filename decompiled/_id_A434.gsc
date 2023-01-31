// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_urban_male_body_f" );
    self attach( "head_m_gen_cau_young", "", 1 );
    self.headmodel = "head_m_gen_cau_young";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_male_body_f" );
    precachemodel( "head_m_gen_cau_young" );
}
