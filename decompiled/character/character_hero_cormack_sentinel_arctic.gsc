// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "body_hero_cormack_sentinel_halo" );
    self attach( "head_hero_cormack_sentinel_halo", "", 1 );
    self.headmodel = "head_hero_cormack_sentinel_halo";
    self.voice = "xslice";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "body_hero_cormack_sentinel_halo" );
    precachemodel( "head_hero_cormack_sentinel_halo" );
}
