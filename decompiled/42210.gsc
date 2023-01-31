// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "marines_body_assault_drop_pod" );
    self attach( "marines_head_a", "", 1 );
    self.headmodel = "marines_head_a";
    self.voice = "sentinel";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "marines_body_assault_drop_pod" );
    precachemodel( "marines_head_a" );
}
