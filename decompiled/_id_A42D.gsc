// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_urban_male_body_g_afr" );
    self attach( "head_m_act_afr_brickerson_base_sunglasses", "", 1 );
    self.headmodel = "head_m_act_afr_brickerson_base_sunglasses";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_male_body_g_afr" );
    precachemodel( "head_m_act_afr_brickerson_base_sunglasses" );
}
