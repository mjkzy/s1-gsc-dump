// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "burke_sentinel_body" );
    self attach( "head_hero_gideon_beanie", "", 1 );
    self.headmodel = "head_hero_gideon_beanie";
    self.voice = "xslice";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "burke_sentinel_body" );
    precachemodel( "head_hero_gideon_beanie" );
}
