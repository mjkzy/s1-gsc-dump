// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "atlas_security" );
    self attach( "atlas_security_head_a", "", 1 );
    self.headmodel = "atlas_security_head_a";
    self.voice = "atlas";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "atlas_security" );
    precachemodel( "atlas_security_head_a" );
}
