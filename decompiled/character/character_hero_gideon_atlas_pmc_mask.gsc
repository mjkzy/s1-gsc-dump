// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "kva_body_assault" );
    self attach( "head_hero_gideon_mask", "", 1 );
    self.headmodel = "head_hero_gideon_mask";
    self.voice = "xslice";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "kva_body_assault" );
    precachemodel( "head_hero_gideon_mask" );
}