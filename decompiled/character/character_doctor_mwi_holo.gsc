// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "civ_urban_male_body_f" );
    self attach( "head_m_gen_cau_shipley_holo", "", 1 );
    self.headmodel = "head_m_gen_cau_shipley_holo";
    self.voice = "atlas";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_male_body_f" );
    precachemodel( "head_m_gen_cau_shipley_holo" );
}
