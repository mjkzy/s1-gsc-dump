// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "sf_police_body" );
    self attach( "head_m_gen_cau_young_police", "", 1 );
    self.headmodel = "head_m_gen_cau_young_police";
    self.voice = "sentinel";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "sf_police_body" );
    precachemodel( "head_m_gen_cau_young_police" );
}
