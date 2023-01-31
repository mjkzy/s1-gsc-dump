// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "nk_army_smg_body" );
    self attach( "nk_army_c_head", "", 1 );
    self.headmodel = "nk_army_c_head";
    self.voice = "northkorea";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "nk_army_smg_body" );
    precachemodel( "nk_army_c_head" );
}
