// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "body_hero_gideon_pilot_finale" );
    self attach( "head_hero_gideon_blend", "", 1 );
    self.headmodel = "head_hero_gideon_blend";
    self.voice = "xslice";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "body_hero_gideon_pilot_finale" );
    precachemodel( "head_hero_gideon_blend" );
}
