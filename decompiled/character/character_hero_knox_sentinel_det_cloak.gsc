// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "sentinel_covert_body_a" );
    self attach( "head_hero_knox_sentinel_covert_blend", "", 1 );
    self.headmodel = "head_hero_knox_sentinel_covert_blend";
    self.voice = "xslice";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "sentinel_covert_body_a" );
    precachemodel( "head_hero_knox_sentinel_covert_blend" );
}
