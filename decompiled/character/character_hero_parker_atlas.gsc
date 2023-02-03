// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "atlas_body" );
    self attach( "head_m_gen_mde_azzam", "", 1 );
    self.headmodel = "head_m_gen_mde_azzam";
    self.voice = "xslice";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "atlas_body" );
    precachemodel( "head_m_gen_mde_azzam" );
}
