// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "atlas_body" );
    self attach( "head_hero_joker_goggles", "", 1 );
    self.headmodel = "head_hero_joker_goggles";
    self.voice = "xslice";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "atlas_body" );
    precachemodel( "head_hero_joker_goggles" );
}
