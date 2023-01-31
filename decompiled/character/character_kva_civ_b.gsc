// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "kva_civilian_b" );
    self attach( "head_m_gen_cau_young", "", 1 );
    self.headmodel = "head_m_gen_cau_young";
    self.voice = "kva";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "kva_civilian_b" );
    precachemodel( "head_m_gen_cau_young" );
}
