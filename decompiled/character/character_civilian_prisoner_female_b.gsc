// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "civ_prisoner_atlas_body_b" );
    codescripts\character::attachhead( "alias_civilian_heads_prisoner_female", xmodelalias\alias_civilian_heads_prisoner_female::main() );
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "civ_prisoner_atlas_body_b" );
    codescripts\character::precachemodelarray( xmodelalias\alias_civilian_heads_prisoner_female::main() );
}
