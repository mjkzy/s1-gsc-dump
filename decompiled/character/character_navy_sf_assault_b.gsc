// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "navy_body_c" );
    self attach( "head_m_gen_cau_young", "", 1 );
    self.headmodel = "head_m_gen_cau_young";
    self.voice = "sentinel";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "navy_body_c" );
    precachemodel( "head_m_gen_cau_young" );
}
