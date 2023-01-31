// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    codescripts\character::setmodelfromarray( xmodelalias\alias_sentinel_arctic_bodies::main() );
    codescripts\character::attachhead( "alias_sentinel_arctic_heads", xmodelalias\alias_sentinel_arctic_heads::main() );
    self.voice = "sentinel";
    self _meth_83DB( "vestlight" );
}

precache()
{
    codescripts\character::precachemodelarray( xmodelalias\alias_sentinel_arctic_bodies::main() );
    codescripts\character::precachemodelarray( xmodelalias\alias_sentinel_arctic_heads::main() );
}
