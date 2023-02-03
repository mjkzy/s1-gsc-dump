// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "kva_hazmat_body_a" );
    self attach( "kva_hazmat_head_a", "", 1 );
    self.headmodel = "kva_hazmat_head_a";
    self.voice = "kva";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "kva_hazmat_body_a" );
    precachemodel( "kva_hazmat_head_a" );
}
