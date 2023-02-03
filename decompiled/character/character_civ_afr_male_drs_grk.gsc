// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    codescripts\character::setmodelfromarray( xmodelalias\alias_civ_afr_dark_male_bodies_dress::main() );
    codescripts\character::attachhead( "alias_greece_civilian_heads_males_b", xmodelalias\alias_greece_civilian_heads_males_b::main() );
    self.voice = "african";
    self setclothtype( "vestlight" );
}

precache()
{
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_afr_dark_male_bodies_dress::main() );
    codescripts\character::precachemodelarray( xmodelalias\alias_greece_civilian_heads_males_b::main() );
}
