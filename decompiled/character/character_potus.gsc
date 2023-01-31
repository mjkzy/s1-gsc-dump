// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "president_body" );
    self attach( "head_m_gen_cau_potus_base", "", 1 );
    self.headmodel = "head_m_gen_cau_potus_base";
    self.voice = "sentinel";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "president_body" );
    precachemodel( "head_m_gen_cau_potus_base" );
}
