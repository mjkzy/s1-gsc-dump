// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "marine_dress_body_a" );
    self attach( "head_hero_cormack_dress_hat", "", 1 );
    self.headmodel = "head_hero_cormack_dress_hat";
    self.voice = "xslice";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "marine_dress_body_a" );
    precachemodel( "head_hero_cormack_dress_hat" );
}
