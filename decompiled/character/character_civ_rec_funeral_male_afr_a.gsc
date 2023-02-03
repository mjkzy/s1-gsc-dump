// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "civ_male_body_suit_closed_afr" );
    self attach( "head_m_gen_afr_bowman", "", 1 );
    self.headmodel = "head_m_gen_afr_bowman";
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "civ_male_body_suit_closed_afr" );
    precachemodel( "head_m_gen_afr_bowman" );
}
