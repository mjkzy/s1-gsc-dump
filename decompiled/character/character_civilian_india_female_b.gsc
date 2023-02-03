// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "body_india_female_b" );
    self attach( "head_india_female_b", "", 1 );
    self.headmodel = "head_india_female_b";
    self.voice = "arab";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "body_india_female_b" );
    precachemodel( "head_india_female_b" );
}
