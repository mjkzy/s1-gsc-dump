// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "civ_worker" );
    self attach( "head_m_gen_cau_clark", "", 1 );
    self.headmodel = "head_m_gen_cau_clark";
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "civ_worker" );
    precachemodel( "head_m_gen_cau_clark" );
}
