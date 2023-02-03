// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "body_slum_civ_male_bb" );
    codescripts\character::attachhead( "alias_civilian_slum_heads", xmodelalias\alias_civilian_slum_heads::main() );
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "body_slum_civ_male_bb" );
    codescripts\character::precachemodelarray( xmodelalias\alias_civilian_slum_heads::main() );
}
