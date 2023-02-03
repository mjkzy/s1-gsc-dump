// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "body_slum_civ_male_aa_wht" );
    codescripts\character::attachhead( "alias_civilian_slum_heads_wht", xmodelalias\alias_civilian_slum_heads_wht::main() );
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "body_slum_civ_male_aa_wht" );
    codescripts\character::precachemodelarray( xmodelalias\alias_civilian_slum_heads_wht::main() );
}
