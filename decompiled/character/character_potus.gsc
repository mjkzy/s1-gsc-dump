// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "president_body" );
    self attach( "head_m_gen_cau_potus_base", "", 1 );
    self.headmodel = "head_m_gen_cau_potus_base";
    self.voice = "sentinel";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "president_body" );
    precachemodel( "head_m_gen_cau_potus_base" );
}
