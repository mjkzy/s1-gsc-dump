// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "atlas_body" );
    codescripts\character::attachhead( "alias_enemy_atlas_heads", xmodelalias\alias_enemy_atlas_heads::main() );
    self.voice = "atlas";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "atlas_body" );
    codescripts\character::precachemodelarray( xmodelalias\alias_enemy_atlas_heads::main() );
}
