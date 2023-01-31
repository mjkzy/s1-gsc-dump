// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    codescripts\character::setmodelfromarray( xmodelalias\alias_nigerian_army_bodies::main() );
    codescripts\character::attachhead( "alias_nigerian_army_heads", xmodelalias\alias_nigerian_army_heads::main() );
    self.voice = "african";
    self _meth_83DB( "vestlight" );
}

precache()
{
    codescripts\character::precachemodelarray( xmodelalias\alias_nigerian_army_bodies::main() );
    codescripts\character::precachemodelarray( xmodelalias\alias_nigerian_army_heads::main() );
}
