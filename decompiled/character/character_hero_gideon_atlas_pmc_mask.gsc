// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "kva_body_assault" );
    self attach( "head_hero_gideon_mask", "", 1 );
    self.headmodel = "head_hero_gideon_mask";
    self.voice = "xslice";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "kva_body_assault" );
    precachemodel( "head_hero_gideon_mask" );
}
