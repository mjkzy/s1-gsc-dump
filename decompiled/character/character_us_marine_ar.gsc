// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "marines_body_assault" );
    codescripts\character::attachhead( "alias_us_marine_heads", xmodelalias\alias_us_marine_heads::main() );
    self.voice = "sentinel";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "marines_body_assault" );
    codescripts\character::precachemodelarray( xmodelalias\alias_us_marine_heads::main() );
}
