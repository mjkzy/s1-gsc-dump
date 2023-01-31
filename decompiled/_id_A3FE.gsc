// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "atlas_security" );
    self attach( "atlas_security_head_a", "", 1 );
    self.headmodel = "atlas_security_head_a";
    self.voice = "atlas";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "atlas_security" );
    precachemodel( "atlas_security_head_a" );
}
