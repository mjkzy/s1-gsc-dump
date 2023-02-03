// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "body_india_male_a_alt" );
    self attach( "head_india_male_c", "", 1 );
    self.headmodel = "head_india_male_c";
    self.voice = "arab";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "body_india_male_a_alt" );
    precachemodel( "head_india_male_c" );
}
