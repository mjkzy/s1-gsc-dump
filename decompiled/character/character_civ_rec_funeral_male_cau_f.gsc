// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "civ_male_body_suit_closed" );
    self attach( "head_m_act_cau_manasi_base", "", 1 );
    self.headmodel = "head_m_act_cau_manasi_base";
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "civ_male_body_suit_closed" );
    precachemodel( "head_m_act_cau_manasi_base" );
}
