// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "civ_urban_male_body_g" );
    self attach( "head_m_act_cau_bedrosian_base", "", 1 );
    self.headmodel = "head_m_act_cau_bedrosian_base";
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_male_body_g" );
    precachemodel( "head_m_act_cau_bedrosian_base" );
}
