// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "mp_body_cloak_test" );
    self attach( "mp_head_cloak_test", "", 1 );
    self.headmodel = "mp_head_cloak_test";
    self setviewmodel( "mp_viewhands_cloak_test" );
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "mp_body_cloak_test" );
    precachemodel( "mp_head_cloak_test" );
    precachemodel( "mp_viewhands_cloak_test" );
}
