// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "sf_police_body" );
    self attach( "sf_police_head_c", "", 1 );
    self.headmodel = "sf_police_head_c";
    self.voice = "sentinel";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "sf_police_body" );
    precachemodel( "sf_police_head_c" );
}
