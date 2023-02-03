// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "body_india_male_b_alt" );
    self attach( "head_india_male_d", "", 1 );
    self.headmodel = "head_india_male_d";
    self.voice = "arab";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "body_india_male_b_alt" );
    precachemodel( "head_india_male_d" );
}
