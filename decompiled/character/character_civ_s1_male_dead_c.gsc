// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    codescripts\character::setmodelfromarray( xmodelalias\alias_civ_urban_dead_body_c::main() );
    codescripts\character::attachhead( "alias_civ_rec_funeral_male_heads", xmodelalias\alias_civ_rec_funeral_male_heads::main() );
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_urban_dead_body_c::main() );
    codescripts\character::precachemodelarray( xmodelalias\alias_civ_rec_funeral_male_heads::main() );
}
