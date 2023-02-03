// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "sf_police_body_darkskin" );
    self attach( "head_m_gen_afr_davis_police", "", 1 );
    self.headmodel = "head_m_gen_afr_davis_police";
    self.voice = "sentinel";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "sf_police_body_darkskin" );
    precachemodel( "head_m_gen_afr_davis_police" );
}
