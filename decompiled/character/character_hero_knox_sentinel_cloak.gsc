// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "sentinel_covert_body_a" );
    self attach( "head_hero_knox_sentinel_covert_blend", "", 1 );
    self.headmodel = "head_hero_knox_sentinel_covert_blend";
    self.voice = "xslice";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "sentinel_covert_body_a" );
    precachemodel( "head_hero_knox_sentinel_covert_blend" );
}
