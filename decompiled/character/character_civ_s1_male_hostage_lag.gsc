// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "civ_urban_male_body_f" );
    self attach( "head_m_act_cau_ramsay_base", "", 1 );
    self.headmodel = "head_m_act_cau_ramsay_base";
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_male_body_f" );
    precachemodel( "head_m_act_cau_ramsay_base" );
}
