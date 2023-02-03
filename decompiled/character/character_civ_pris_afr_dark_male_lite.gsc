// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    codescripts\character::setmodelfromarray( xmodelalias\alias_civ_pris_afr_dark_male_bodies::main() );
    codescripts\character::attachhead( "alias_civ_afr_dark_male_heads", xmodelalias\alias_civ_afr_dark_male_heads::main() );
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_pris_afr_dark_male_bodies::main() );
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_afr_dark_male_heads::main() );
}
