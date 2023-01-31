// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    codescripts\character::setmodelfromarray( xmodelalias\alias_civ_urban_dead_body_b::main() );
    codescripts\character::attachhead( "alias_civ_urban_male_heads_afr_light", xmodelalias\alias_civ_urban_male_heads_afr_light::main() );
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_urban_dead_body_b::main() );
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_urban_male_heads_afr_light::main() );
}
