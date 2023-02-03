// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "kva_hazmat_body_low" );
    codescripts\character::attachhead( "alias_civ_cau_male_heads_hazmat_nohat", xmodelalias\alias_civ_cau_male_heads_hazmat_nohat::main() );
    self.voice = "kva";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "kva_hazmat_body_low" );
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_cau_male_heads_hazmat_nohat::main() );
}
