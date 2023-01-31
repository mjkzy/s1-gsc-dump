// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "body_sentinel_soldier_cloaked" );
    self attach( "head_sentinel_soldier_cloaked", "", 1 );
    self.headmodel = "head_sentinel_soldier_cloaked";
    self.voice = "xslice";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "body_sentinel_soldier_cloaked" );
    precachemodel( "head_sentinel_soldier_cloaked" );
}
