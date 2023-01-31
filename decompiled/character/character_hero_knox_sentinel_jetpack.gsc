// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "sentinel_body_c" );
    self attach( "head_hero_knox_blend", "", 1 );
    self.headmodel = "head_hero_knox_blend";
    self.voice = "xslice";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "sentinel_body_c" );
    precachemodel( "head_hero_knox_blend" );
}
