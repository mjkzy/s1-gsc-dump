// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    codescripts\character::setmodelfromarray( xmodelalias\alias_civ_asi_male_bodies_dress::main() );
    codescripts\character::attachhead( "alias_civ_asi_male_heads", xmodelalias\alias_civ_asi_male_heads::main() );
    self.voice = "northkorea";
    self setclothtype( "vestlight" );
}

precache()
{
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_asi_male_bodies_dress::main() );
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_asi_male_heads::main() );
}
