// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "navy_body_c" );
    self attach( "navy_head_a", "", 1 );
    self.headmodel = "navy_head_a";
    self.voice = "sentinel";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "navy_body_c" );
    precachemodel( "navy_head_a" );
}
