// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "kva_civilian_c" );
    self attach( "head_m_gen_cau_barton_kva_civ", "", 1 );
    self.headmodel = "head_m_gen_cau_barton_kva_civ";
    self.voice = "kva";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "kva_civilian_c" );
    precachemodel( "head_m_gen_cau_barton_kva_civ" );
}
