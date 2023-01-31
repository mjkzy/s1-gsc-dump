// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "navy_body_c" );
    self attach( "head_m_gen_cau_young", "", 1 );
    self.headmodel = "head_m_gen_cau_young";
    self.voice = "sentinel";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "navy_body_c" );
    precachemodel( "head_m_gen_cau_young" );
}
