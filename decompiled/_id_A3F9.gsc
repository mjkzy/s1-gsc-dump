// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "civ_urban_male_body_g" );
    codescripts\character::attachhead( "alias_atlas_bodyguard_heads", xmodelalias\alias_atlas_bodyguard_heads::main() );
    self.voice = "secretservice";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "civ_urban_male_body_g" );
    codescripts\character::precachemodelarray( xmodelalias\alias_atlas_bodyguard_heads::main() );
}
