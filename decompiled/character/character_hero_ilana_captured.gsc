// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "body_ilana_sentinel_pilot_captured" );
    self attach( "head_hero_ilana_blend", "", 1 );
    self.headmodel = "head_hero_ilana_blend";
    self.voice = "xslice";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "body_ilana_sentinel_pilot_captured" );
    precachemodel( "head_hero_ilana_blend" );
}
