// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "body_hero_cormack_sentinel_udt_dry" );
    self attach( "head_hero_cormack_facemask_udt", "", 1 );
    self.headmodel = "head_hero_cormack_facemask_udt";
    self.voice = "xslice";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "body_hero_cormack_sentinel_udt_dry" );
    precachemodel( "head_hero_cormack_facemask_udt" );
}
