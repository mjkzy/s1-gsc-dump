// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "kva_civilian_a" );
    self attach( "head_m_act_cau_bedrosian_base", "", 1 );
    self.headmodel = "head_m_act_cau_bedrosian_base";
    self.voice = "kva";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "kva_civilian_a" );
    precachemodel( "head_m_act_cau_bedrosian_base" );
}
