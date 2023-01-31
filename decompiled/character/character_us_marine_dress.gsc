// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    codescripts\character::setmodelfromarray( xmodelalias\alias_us_marine_dress_bodies::main() );
    codescripts\character::attachhead( "alias_us_marine_dress_heads", xmodelalias\alias_us_marine_dress_heads::main() );
    self.voice = "sentinel";
    self _meth_83DB( "vestlight" );
}

precache()
{
    codescripts\character::precachemodelarray( xmodelalias\alias_us_marine_dress_bodies::main() );
    codescripts\character::precachemodelarray( xmodelalias\alias_us_marine_dress_heads::main() );
}
