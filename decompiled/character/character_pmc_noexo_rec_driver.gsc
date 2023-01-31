// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "atlas_pmc_body_noexo" );
    self attach( "head_m_gen_cau_young_atlas_pmc", "", 1 );
    self.headmodel = "head_m_gen_cau_young_atlas_pmc";
    self.voice = "atlas";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "atlas_pmc_body_noexo" );
    precachemodel( "head_m_gen_cau_young_atlas_pmc" );
}
