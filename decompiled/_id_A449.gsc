// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_worker" );
    self attach( "head_m_gen_cau_barton", "", 1 );
    self.headmodel = "head_m_gen_cau_barton";
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_worker" );
    precachemodel( "head_m_gen_cau_barton" );
}
