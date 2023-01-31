// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "kva_hazmat_body_low" );
    codescripts\character::attachhead( "alias_civ_cau_male_heads_hazmat_nohat", xmodelalias\alias_civ_cau_male_heads_hazmat_nohat::main() );
    self.voice = "kva";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "kva_hazmat_body_low" );
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_cau_male_heads_hazmat_nohat::main() );
}
