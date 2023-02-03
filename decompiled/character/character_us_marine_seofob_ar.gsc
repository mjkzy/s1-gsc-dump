// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "marines_body_assault" );
    self attach( "marines_head_a", "", 1 );
    self.headmodel = "marines_head_a";
    self.voice = "sentinel";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "marines_body_assault" );
    precachemodel( "marines_head_a" );
}
