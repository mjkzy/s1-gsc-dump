// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    codescripts\character::setmodelfromarray( xmodelalias\alias_seoul_civilian_body_males_d::main() );
    codescripts\character::attachhead( "alias_seoul_civilian_head_males_d", xmodelalias\alias_seoul_civilian_head_males_d::main() );
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    codescripts\character::precachemodelarray( xmodelalias\alias_seoul_civilian_body_males_d::main() );
    codescripts\character::precachemodelarray( xmodelalias\alias_seoul_civilian_head_males_d::main() );
}
