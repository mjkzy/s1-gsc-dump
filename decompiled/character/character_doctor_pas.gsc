// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "dr_pas_body" );
    self attach( "dr_pas_head", "", 1 );
    self.headmodel = "dr_pas_head";
    self.voice = "atlas";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "dr_pas_body" );
    precachemodel( "dr_pas_head" );
}
