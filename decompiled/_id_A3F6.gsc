// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "atlas_body" );
    codescripts\character::attachhead( "alias_enemy_atlas_heads", xmodelalias\alias_enemy_atlas_heads::main() );
    self.voice = "atlas";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "atlas_body" );
    codescripts\character::precachemodelarray( xmodelalias\alias_enemy_atlas_heads::main() );
}
