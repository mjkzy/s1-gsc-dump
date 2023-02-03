// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "burke_atlas_pmc" );
    codescripts\character::attachhead( "alias_pmc_casual_heads", xmodelalias\alias_pmc_casual_heads::main() );
    self.voice = "atlas";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "burke_atlas_pmc" );
    codescripts\character::precachemodelarray( xmodelalias\alias_pmc_casual_heads::main() );
}
