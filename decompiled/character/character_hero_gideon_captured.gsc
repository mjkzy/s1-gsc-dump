// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "sentinel_pilot_body_captured" );
    self attach( "head_hero_gideon_blend", "", 1 );
    self.headmodel = "head_hero_gideon_blend";
    self.voice = "xslice";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "sentinel_pilot_body_captured" );
    precachemodel( "head_hero_gideon_blend" );
}
