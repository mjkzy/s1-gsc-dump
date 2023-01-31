// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "nigerian_general_body" );
    self attach( "nigerian_general_head", "", 1 );
    self.headmodel = "nigerian_general_head";
    self.voice = "african";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "nigerian_general_body" );
    precachemodel( "nigerian_general_head" );
}
