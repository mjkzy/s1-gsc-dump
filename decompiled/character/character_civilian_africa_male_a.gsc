// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "body_africa_civ_male_a" );
    codescripts\character::attachhead( "alias_africa_civilian_male_heads", xmodelalias\alias_africa_civilian_male_heads::main() );
    self.voice = "african";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "body_africa_civ_male_a" );
    codescripts\character::precachemodelarray( xmodelalias\alias_africa_civilian_male_heads::main() );
}
