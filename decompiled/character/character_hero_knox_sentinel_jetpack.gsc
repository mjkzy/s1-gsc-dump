// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "sentinel_body_c" );
    self attach( "head_hero_knox_blend", "", 1 );
    self.headmodel = "head_hero_knox_blend";
    self.voice = "xslice";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "sentinel_body_c" );
    precachemodel( "head_hero_knox_blend" );
}
