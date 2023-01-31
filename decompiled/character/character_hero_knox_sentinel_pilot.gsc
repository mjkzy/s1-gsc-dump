// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "knox_sentinel_pilot_body" );
    self attach( "head_hero_knox_blend_nohair", "", 1 );
    self.headmodel = "head_hero_knox_blend_nohair";
    self.voice = "xslice";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "knox_sentinel_pilot_body" );
    precachemodel( "head_hero_knox_blend_nohair" );
}
