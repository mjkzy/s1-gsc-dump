// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "mp_sentinel_body_nojet_b" );
    codescripts\character::attachhead( "alias_mp_sentinel_heads", xmodelalias\alias_mp_sentinel_heads::main() );
    self setviewmodel( "viewhands_s1_pmc" );
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "mp_sentinel_body_nojet_b" );
    codescripts\character::precachemodelarray( xmodelalias\alias_mp_sentinel_heads::main() );
    precachemodel( "viewhands_s1_pmc" );
}
