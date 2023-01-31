// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "kva_body_shotgun" );
    codescripts\character::attachhead( "alias_kva_heads", xmodelalias\alias_kva_heads::main() );
    self.voice = "kva";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "kva_body_shotgun" );
    codescripts\character::precachemodelarray( xmodelalias\alias_kva_heads::main() );
}
