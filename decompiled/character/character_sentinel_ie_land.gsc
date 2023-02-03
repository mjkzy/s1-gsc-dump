// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "sentinel_udt_land_body" );
    codescripts\character::attachhead( "alias_sentinel_udt_heads", xmodelalias\alias_sentinel_udt_heads::main() );
    self.voice = "sentinel";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "sentinel_udt_land_body" );
    codescripts\character::precachemodelarray( xmodelalias\alias_sentinel_udt_heads::main() );
}
