// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "joker_atlas_pmc" );
    self attach( "head_hero_joker_goggles", "", 1 );
    self.headmodel = "head_hero_joker_goggles";
    self.voice = "xslice";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "joker_atlas_pmc" );
    precachemodel( "head_hero_joker_goggles" );
}
