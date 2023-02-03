// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "sentinel_covert_body_a" );
    self attach( "sentinel_covert_head_a", "", 1 );
    self.headmodel = "sentinel_covert_head_a";
    self.voice = "sentinel";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "sentinel_covert_body_a" );
    precachemodel( "sentinel_covert_head_a" );
}
