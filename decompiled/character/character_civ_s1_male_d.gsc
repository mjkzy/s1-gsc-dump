// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "civ_urban_male_body_d" );
    self attach( "head_m_gen_cau_clark", "", 1 );
    self.headmodel = "head_m_gen_cau_clark";
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_male_body_d" );
    precachemodel( "head_m_gen_cau_clark" );
}
