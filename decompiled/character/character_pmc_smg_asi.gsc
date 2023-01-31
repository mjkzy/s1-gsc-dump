// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "atlas_pmc_smg_asi" );
    codescripts\character::attachhead( "alias_pmc_casual_heads_asi", xmodelalias\alias_pmc_casual_heads_asi::main() );
    self.voice = "atlas";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "atlas_pmc_smg_asi" );
    codescripts\character::precachemodelarray( xmodelalias\alias_pmc_casual_heads_asi::main() );
}
