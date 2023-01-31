// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_male_body_suit_closed_afr" );
    self attach( "head_m_gen_afr_bowman", "", 1 );
    self.headmodel = "head_m_gen_afr_bowman";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_male_body_suit_closed_afr" );
    precachemodel( "head_m_gen_afr_bowman" );
}
