// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    codescripts\character::setmodelfromarray( xmodelalias\alias_civ_cau_fem_bod_drs_sml::main() );
    codescripts\character::attachhead( "alias_civ_cau_fem_heads_sml", xmodelalias\alias_civ_cau_fem_heads_sml::main() );
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_cau_fem_bod_drs_sml::main() );
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_cau_fem_heads_sml::main() );
}
