// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "navy_body_c" );
    self attach( "navy_head_c", "", 1 );
    self.headmodel = "navy_head_c";
    self.voice = "sentinel";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "navy_body_c" );
    precachemodel( "navy_head_c" );
}
