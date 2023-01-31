// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "atlas_pmc_body" );
    codescripts\character::attachhead( "alias_pmc_helmet_heads", xmodelalias\alias_pmc_helmet_heads::main() );
    self.voice = "xslice";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "atlas_pmc_body" );
    codescripts\character::precachemodelarray( xmodelalias\alias_pmc_helmet_heads::main() );
}
