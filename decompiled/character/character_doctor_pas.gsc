// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "dr_pas_body" );
    self attach( "dr_pas_head", "", 1 );
    self.headmodel = "dr_pas_head";
    self.voice = "atlas";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "dr_pas_body" );
    precachemodel( "dr_pas_head" );
}
