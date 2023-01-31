// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "body_africa_civ_male_b" );
    codescripts\character::attachhead( "alias_africa_civilian_male_heads", xmodelalias\alias_africa_civilian_male_heads::main() );
    self.voice = "african";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "body_africa_civ_male_b" );
    codescripts\character::precachemodelarray( xmodelalias\alias_africa_civilian_male_heads::main() );
}
