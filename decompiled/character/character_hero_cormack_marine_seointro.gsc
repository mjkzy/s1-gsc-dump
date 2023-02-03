// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "body_hero_cormack_marine_drop_pod" );
    self attach( "head_hero_cormack_marines", "", 1 );
    self.headmodel = "head_hero_cormack_marines";
    self.voice = "xslice";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "body_hero_cormack_marine_drop_pod" );
    precachemodel( "head_hero_cormack_marines" );
}
