// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "body_india_male_b" );
    self attach( "head_india_male_b", "", 1 );
    self.headmodel = "head_india_male_b";
    self.voice = "arab";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "body_india_male_b" );
    precachemodel( "head_india_male_b" );
}
