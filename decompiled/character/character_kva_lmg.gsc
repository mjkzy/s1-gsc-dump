// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "kva_body_lmg" );
    codescripts\character::attachhead( "alias_kva_heads", xmodelalias\alias_kva_heads::main() );
    self.voice = "kva";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "kva_body_lmg" );
    codescripts\character::precachemodelarray( xmodelalias\alias_kva_heads::main() );
}
