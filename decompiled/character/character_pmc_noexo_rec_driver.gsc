// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "atlas_pmc_body_noexo" );
    self attach( "head_m_gen_cau_young_atlas_pmc", "", 1 );
    self.headmodel = "head_m_gen_cau_young_atlas_pmc";
    self.voice = "atlas";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "atlas_pmc_body_noexo" );
    precachemodel( "head_m_gen_cau_young_atlas_pmc" );
}
