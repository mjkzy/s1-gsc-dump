// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "kva_civilian_a" );
    self attach( "head_m_act_cau_bedrosian_base", "", 1 );
    self.headmodel = "head_m_act_cau_bedrosian_base";
    self.voice = "kva";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "kva_civilian_a" );
    precachemodel( "head_m_act_cau_bedrosian_base" );
}
