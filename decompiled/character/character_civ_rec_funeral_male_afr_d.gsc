// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "civ_urban_male_body_f_afr" );
    self attach( "head_m_gen_afr_rice", "", 1 );
    self.headmodel = "head_m_gen_afr_rice";
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_male_body_f_afr" );
    precachemodel( "head_m_gen_afr_rice" );
}
