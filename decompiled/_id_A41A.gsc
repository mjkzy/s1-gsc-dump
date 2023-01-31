// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_urban_male_body_c_gray_shirt" );
    self attach( "head_m_gen_cau_barton", "", 1 );
    self.headmodel = "head_m_gen_cau_barton";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_male_body_c_gray_shirt" );
    precachemodel( "head_m_gen_cau_barton" );
}
