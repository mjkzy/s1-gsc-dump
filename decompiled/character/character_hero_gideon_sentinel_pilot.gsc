// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "sentinel_pilot_body_blk_helmet" );
    self attach( "head_hero_gideon_blend_nohair", "", 1 );
    self.headmodel = "head_hero_gideon_blend_nohair";
    self.voice = "xslice";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "sentinel_pilot_body_blk_helmet" );
    precachemodel( "head_hero_gideon_blend_nohair" );
}
