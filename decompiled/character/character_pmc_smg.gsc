// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "atlas_pmc_smg" );
    codescripts\character::attachhead( "alias_pmc_casual_heads", xmodelalias\alias_pmc_casual_heads::main() );
    self.voice = "atlas";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "atlas_pmc_smg" );
    codescripts\character::precachemodelarray( xmodelalias\alias_pmc_casual_heads::main() );
}
