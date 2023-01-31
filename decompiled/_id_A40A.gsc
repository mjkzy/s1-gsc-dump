// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    codescripts\character::setmodelfromarray( xmodelalias\alias_civ_afr_lgt_female_bodies_cas::main() );
    codescripts\character::attachhead( "alias_civ_afr_lgt_female_heads", xmodelalias\alias_civ_afr_lgt_female_heads::main() );
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_afr_lgt_female_bodies_cas::main() );
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_afr_lgt_female_heads::main() );
}
