// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_urban_male_body_g" );
    self attach( "head_m_act_cau_bedrosian_base", "", 1 );
    self.headmodel = "head_m_act_cau_bedrosian_base";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_male_body_g" );
    precachemodel( "head_m_act_cau_bedrosian_base" );
}
