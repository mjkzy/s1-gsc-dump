// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "atlas_body" );
    self attach( "head_hero_gideon_beanie", "", 1 );
    self.headmodel = "head_hero_gideon_beanie";
    self.voice = "xslice";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "atlas_body" );
    precachemodel( "head_hero_gideon_beanie" );
}
