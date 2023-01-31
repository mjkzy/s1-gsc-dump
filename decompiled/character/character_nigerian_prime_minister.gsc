// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "nigerian_prime_minister_body" );
    self attach( "prime_minister_head", "", 1 );
    self.headmodel = "prime_minister_head";
    self.voice = "african";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "nigerian_prime_minister_body" );
    precachemodel( "prime_minister_head" );
}
