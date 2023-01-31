// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "kva_civilian_c" );
    self attach( "head_m_gen_cau_barton_kva_civ", "", 1 );
    self.headmodel = "head_m_gen_cau_barton_kva_civ";
    self.voice = "kva";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "kva_civilian_c" );
    precachemodel( "head_m_gen_cau_barton_kva_civ" );
}
