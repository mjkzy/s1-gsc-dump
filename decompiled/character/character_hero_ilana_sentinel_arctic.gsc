// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "body_hero_ilana_sentinel_halo" );
    self attach( "head_hero_ilana_blend", "", 1 );
    self.headmodel = "head_hero_ilana_blend";
    self.voice = "xslice";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "body_hero_ilana_sentinel_halo" );
    precachemodel( "head_hero_ilana_blend" );
}
