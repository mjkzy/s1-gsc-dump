// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "body_ilana_sentinel_udt_grapple" );
    self attach( "head_hero_ilana_blend", "", 1 );
    self.headmodel = "head_hero_ilana_blend";
    self.voice = "xslice";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "body_ilana_sentinel_udt_grapple" );
    precachemodel( "head_hero_ilana_blend" );
}
