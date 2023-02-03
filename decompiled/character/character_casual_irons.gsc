// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "irons_casual" );
    self attach( "head_hero_irons_blend", "", 1 );
    self.headmodel = "head_hero_irons_blend";
    self.voice = "xslice";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "irons_casual" );
    precachemodel( "head_hero_irons_blend" );
}
