// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "body_hero_cormack_sentinel_covert" );
    self attach( "head_hero_cormack_sentinel_covert", "", 1 );
    self.headmodel = "head_hero_cormack_sentinel_covert";
    self.voice = "xslice";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "body_hero_cormack_sentinel_covert" );
    precachemodel( "head_hero_cormack_sentinel_covert" );
}
