// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    codescripts\character::setmodelfromarray( xmodelalias\alias_civ_urban_dead_body_a::main() );
    codescripts\character::attachhead( "alias_civ_rec_funeral_male_heads", xmodelalias\alias_civ_rec_funeral_male_heads::main() );
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_urban_dead_body_a::main() );
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_rec_funeral_male_heads::main() );
}
