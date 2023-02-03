// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "nk_army_shotgun_body" );
    self attach( "nk_army_b_head", "", 1 );
    self.headmodel = "nk_army_b_head";
    self.voice = "northkorea";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "nk_army_shotgun_body" );
    precachemodel( "nk_army_b_head" );
}
