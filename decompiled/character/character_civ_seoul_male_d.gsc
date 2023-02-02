// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    codescripts\character::setmodelfromarray( xmodelalias\alias_seoul_civilian_body_males_c::main() );
    codescripts\character::attachhead( "alias_seoul_civilian_head_males_c", xmodelalias\alias_seoul_civilian_head_males_c::main() );
    self.voice = "american";
    self _meth_83DB( "vestlight" );
}

precache()
{
    codescripts\character::precachemodelarray( xmodelalias\alias_seoul_civilian_body_males_c::main() );
    codescripts\character::precachemodelarray( xmodelalias\alias_seoul_civilian_head_males_c::main() );
}
