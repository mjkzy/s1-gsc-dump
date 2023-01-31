// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self _meth_80B1( "doctor_body" );
    codescripts\character::attachhead( "alias_civ_asi_male_heads", xmodelalias\alias_civ_asi_male_heads::main() );
    self.voice = "atlas";
    self _meth_83DB( "vestlight" );
}

precache()
{
    precachemodel( "doctor_body" );
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_asi_male_heads::main() );
}
