// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "kva_hazmat_body_a" );
    self attach( "kva_hazmat_head_a", "", 1 );
    self.headmodel = "kva_hazmat_head_a";
    self.voice = "kva";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "kva_hazmat_body_a" );
    precachemodel( "kva_hazmat_head_a" );
}
