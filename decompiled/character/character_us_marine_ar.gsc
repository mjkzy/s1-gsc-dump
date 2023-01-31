// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "marines_body_assault" );
    codescripts\character::attachhead( "alias_us_marine_heads", xmodelalias\alias_us_marine_heads::main() );
    self.voice = "sentinel";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "marines_body_assault" );
    codescripts\character::precachemodelarray( xmodelalias\alias_us_marine_heads::main() );
}
