// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "sentinel_udt_underwater" );
    self.voice = "sentinel";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "sentinel_udt_underwater" );
}
